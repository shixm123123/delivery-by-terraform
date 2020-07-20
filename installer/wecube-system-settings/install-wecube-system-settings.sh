#!/bin/bash

set -e

ENV_FILE=$1
source $ENV_FILE

echo "Updating WeCube system settings..."
./update-resource-settings.sh $ENV_FILE

[ "$SHOULD_INSTALL_PLUGINS" != "true" ] && echo "Skipped installation of plugins as requested." && exit 0


echo "Determine plugin versions to be installed..."

if [ -f "$WECUBE_RELEASE_VERSION" ]; then
    VERSION_SPEC_FILE="$WECUBE_RELEASE_VERSION"
    echo "Reading customized WeCube version specs from $VERSION_SPEC_FILE..."
    PATH="$PATH:." source "$VERSION_SPEC_FILE"
    PATH="$PATH:." cat "$VERSION_SPEC_FILE" >>"$ENV_FILE"
else
  GITHUB_RELEASE_URL="https://api.github.com/repos/WeBankPartners/wecube-platform/releases/$WECUBE_RELEASE_VERSION"
  GITHUB_RELEASE_INFO_FILE="$WECUBE_HOME/installer/release-info"
  echo "Fetching release $WECUBE_RELEASE_VERSION from $GITHUB_RELEASE_URL..."
  ../curl-with-retry.sh -fL $GITHUB_RELEASE_URL -o $GITHUB_RELEASE_INFO_FILE

  WECUBE_IMAGE_VERSION=""
  PLUGIN_PKGS=()
  COMPONENT_TABLE_MD=$(cat $GITHUB_RELEASE_INFO_FILE | grep -o '|[ ]*wecube image[ ]*|.*|\\r\\n' | sed -e 's/[ ]*|[ ]*/|/g')
  while [ -n "$COMPONENT_TABLE_MD" ]; do
    # process row by row
    COMPONENT=${COMPONENT_TABLE_MD%%"\r\n"*}
    COMPONENT_TABLE_MD=${COMPONENT_TABLE_MD#*"\r\n"}
    # take name from 1st column
    COMPONENT=${COMPONENT#"|"}
    COMPONENT_NAME=${COMPONENT%%"|"*}
    # take version from 2nd column
    COMPONENT=${COMPONENT#*"|"}
    COMPONENT_VERSION=${COMPONENT%%"|"*}
    # take download link from 3rd column
    COMPONENT=${COMPONENT#*"|"}
    COMPONENT_LINK=${COMPONENT%%"|"*}

    if [ "$COMPONENT_NAME" == 'wecube image' ]; then
        continue
    elif [ -n "$COMPONENT_NAME" ]; then
        PLUGIN_PKGS+=("$COMPONENT_LINK")
    fi
  done
fi

[ ${#PLUGIN_PKGS[@]} == 0 ] && echo -e "\n\e[0;31mFailed to fetch component versions! Installation aborted.\e[0m\n" && exit 1

echo -e "\nInstalling the following WeCube plugin...\n"
printf '  %s\n' "${PLUGIN_PKGS[@]}"
./configure-plugins.sh $ENV_FILE "${PLUGIN_PKGS[@]}"
