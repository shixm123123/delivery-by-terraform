#!/bin/bash

PLUGIN_URL=$1
PLUGIN_PKG=$2
PLUGIN_PKG_DIR=$3
PLUGIN_LIST_CSV=$4

PLUGIN_PKG_FILE="$PLUGIN_PKG_DIR/$PLUGIN_PKG"
echo -e "\nFetching from $PLUGIN_URL/$PLUGIN_PKG"
curl -L ${PLUGIN_URL}/${PLUGIN_PKG} -o ${PLUGIN_PKG_DIR}/${PLUGIN_PKG}
echo ${PLUGIN_PKG_DIR}/${PLUGIN_PKG} >> $PLUGIN_LIST_CSV
