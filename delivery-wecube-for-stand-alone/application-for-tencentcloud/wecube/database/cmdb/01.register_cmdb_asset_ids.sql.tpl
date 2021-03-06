SET NAMES utf8 ;

UPDATE `network_segment` 
SET `vpc_asset_id`='${wecube_vpc_asset_id}',
    `route_table_asset_id`='${wecube_route_table_asset_id}',
    `security_group_asset_id`='${wecube_security_group_id}'
WHERE `name`='TX_BJ_PRD_MGMT';

UPDATE `network_segment` SET `route_table_asset_id`='${wecube_route_table_asset_id}' WHERE `name`='TX_BJ_PRD_MGMT';

UPDATE `network_segment` SET `subnet_asset_id`='${wecube_subnet_asset_id}' WHERE `name`='TX_BJ_PRD1_MGMT_APP';

UPDATE `host_resource_instance` SET `asset_id`='${wecube_host_asset_id}' WHERE `name`='txbjwecubehost';

UPDATE `host_resource_instance` SET `ip_address`='10.128.202.3' WHERE `name`='txbjwecubehost';
