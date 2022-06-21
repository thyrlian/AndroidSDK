#!/bin/bash

check_android_sdk_root() {
  if [ "$#" -lt 1 ]; then
    if [ -z "${ANDROID_SDK_ROOT}" ]; then
      echo "Please either set ANDROID_SDK_ROOT environment variable, or pass ANDROID_SDK_ROOT directory as a parameter"
      exit 1
    else
      ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT}"
    fi
  else
    ANDROID_SDK_ROOT=$1
  fi
  echo "ANDROID_SDK_ROOT is at $ANDROID_SDK_ROOT"
}

check_android_sdk_root "$@"

$ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager --update
yes | $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager --licenses

$ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager "cmake;3.10.2.4988404"
