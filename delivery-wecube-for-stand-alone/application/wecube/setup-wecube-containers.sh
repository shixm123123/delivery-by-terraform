#!/bin/sh

install_target_host=$1
mysql_password=$2
wecube_version=$3
wecube_home=${4:-/data/wecube/installer}

mkdir -p $wecube_home/plugin

CONFIG_FILE="wecube.cfg"
sed -i "s~{{WECUBE_HOME}}~$wecube_home~g" $CONFIG_FILE
sed -i "s~{{SINGLE_HOST}}~$install_target_host~g" $CONFIG_FILE
sed -i "s~{{SINGLE_PASSWORD}}~$mysql_password~g" $CONFIG_FILE

echo "Starting wecube database ..."
./generate_sql_file.sh $CONFIG_FILE
./generate_db_compose_file.sh $CONFIG_FILE
docker-compose -f wecube-db.yml up -d
sleep 120

echo "Starting wecube platform ..."
./deploy_generate_compose.sh $CONFIG_FILE ${wecube_version}
docker-compose -f docker-compose.yml up -d
