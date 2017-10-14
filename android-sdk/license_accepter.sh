#!/bin/bash

check_android_home() {
  if [ "$#" -lt 1 ]; then
    if [ -z "${ANDROID_HOME}" ]; then
      echo "Please either set ANDROID_HOME environment variable, or pass ANDROID_HOME directory as a parameter"
      exit 1
    else
      ANDROID_HOME="${ANDROID_HOME}"
    fi
  else
    ANDROID_HOME=$1
  fi
  echo "ANDROID_HOME is at $ANDROID_HOME"
}

accept_all_android_licenses() {
  ANDROID_LICENSES="$ANDROID_HOME/licenses"
  if [ ! -d $ANDROID_LICENSES ]; then
    echo "Android licenses directory doesn't exist, creating one..."
    mkdir -p $ANDROID_LICENSES
  fi
  accept_license_of android-sdk-license 8933bad161af4178b1185d1a37fbf41ea5269c55
  accept_license_of android-sdk-license d56f5187479451eabf01fb78af6dfcb131a6481e
  accept_license_of android-sdk-preview-license 84831b9409646a918e30573bab4c9c91346d8abd
  accept_license_of intel-android-extra-license d975f751698a77b662f1254ddbeed3901e976f5a
}

accept_license_of() {
  local license=$1
  local content=$2
  local file=$ANDROID_LICENSES/$license
  if [ -f $file ]; then
    if grep -q "^$content$" $file; then
      echo "$license: $content has been accepted already"
    else
      echo "Accepting $license: $content ..."
      echo -e $content >> $file
    fi
  else
    echo "Accepting $license: $content ..."
    echo -e $content > $file
  fi
}

check_android_home "$@"
accept_all_android_licenses
