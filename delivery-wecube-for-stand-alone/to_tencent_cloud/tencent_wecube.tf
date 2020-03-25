#全局变量
variable "instance_root_password" {
  description = "Warn: to be safety, please setup real password by using os env variable - 'TF_VAR_instance_root_password'"
  default = "WeCube1qazXSW@"
}

variable "mysql_root_password" {
  description = "Warn: to be safety, please setup real password by using os env variable - 'TF_VAR_mysql_root_password'"
  default = "WeCube1qazXSW@"
}

variable "wecube_version" {
  description = "You can override the value by setup os env variable - 'TF_VAR_wecube_version'"
  default = "v2.1.1"
}

variable "wecube_home" {
  description = "You can override the value by setup os env variable - 'TF_VAR_wecube_home'"
  default = "/data/wecube"
}

#创建VPC
resource "tencentcloud_vpc" "vpc" {
  name       = "GZ_MGMT"
  cidr_block = "10.128.192.0/19"
}

#创建交换机（子网）- Wecube Platform组件运行的实例
resource "tencentcloud_subnet" "subnet_app" {
  name              = "GZP4_MGMT_MT_APP"
  vpc_id            = "${tencentcloud_vpc.vpc.id}"
  cidr_block        = "10.128.202.0/25"
  availability_zone = "ap-guangzhou-4"
}

#创建安全组
resource "tencentcloud_security_group" "sc_group" {
  name        = "SG_WECUBE"
  description = "Wecube Security Group"
}

#创建安全规则入站
resource "tencentcloud_security_group_rule" "allow_19090_tcp" {
  security_group_id = "${tencentcloud_security_group.sc_group.id}"
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "19090"
  policy            = "accept"
}

resource "tencentcloud_security_group_rule" "allow_22_tcp" {
  security_group_id = "${tencentcloud_security_group.sc_group.id}"
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "22"
  policy            = "accept"
}

resource "tencentcloud_security_group_rule" "allow_9000_tcp" {
  security_group_id = "${tencentcloud_security_group.sc_group.id}"
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "9000"
  policy            = "accept"
}

#创建安全规则出站
resource "tencentcloud_security_group_rule" "allow_all_tcp_out" {
  security_group_id = "${tencentcloud_security_group.sc_group.id}"
  type              = "egress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "1-65535"
  policy            = "accept"
}

#创建WeCube Platform主机
resource "tencentcloud_instance" "instance_wecube_platform" {
  availability_zone = "ap-guangzhou-4"  
  security_groups   = "${tencentcloud_security_group.sc_group.*.id}"
  instance_type     = "S5.LARGE16"
  image_id          = "img-oikl1tzv"
  instance_name     = "instance_wecube_platform"
  vpc_id            = "${tencentcloud_vpc.vpc.id}"
  subnet_id         = "${tencentcloud_subnet.subnet_app.id}"
  system_disk_type  = "CLOUD_PREMIUM"
  allocate_public_ip = true
  private_ip        ="10.128.202.3"
  internet_max_bandwidth_out = 10
  password ="${var.instance_root_password}"

#初始化配置
  connection {
    type     = "ssh"
    user     = "root"
    password = "${var.instance_root_password}"
    host     = "${tencentcloud_instance.instance_wecube_platform.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ${var.wecube_home}/installer"
    ]
  }

  provisioner "file" {
    source      = "../application/"
    destination = "${var.wecube_home}/installer"
  }

  provisioner "remote-exec" {
    inline = [
      "cd ${var.wecube_home}/installer/wecube",
      "chmod +x *.sh",
      "./install-wecube.sh ${tencentcloud_instance.instance_wecube_platform.private_ip} ${var.mysql_root_password} ${var.wecube_version} ${var.wecube_home}"
    ]
  }
}

output "wecube_website" {
  value="http://${tencentcloud_instance.instance_wecube_platform.public_ip}:19090"
}
