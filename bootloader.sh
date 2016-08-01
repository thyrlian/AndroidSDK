#!/bin/bash

docker run -v `pwd`/volume:/opt/android-sdk-linux ubuntu:latest /bin/bash -c ' \
  apt-get update -y; \
  apt-get install -y wget; \
  apt-get install -y --no-install-recommends openjdk-8-jdk; \
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64; \
  cd /opt; \
  wget -q https:$(wget -q -O- "https://developer.android.com/sdk" | \
  sed -n "s,.*\"\(//.*android-sdk.*linux.*\.tgz\)\".*,\1,p"); \
  tar -xzf android-sdk*linux*.tgz; \
  rm android-sdk*linux*.tgz; \
  export ANDROID_HOME=/opt/android-sdk-linux; \
  export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools; \
  echo "y" | \
  android update sdk --no-ui --all --filter \
  tools,platform-tools,build-tools-24.0.1,android-21,android-22,android-23,android-24
'
