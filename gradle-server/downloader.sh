#!/bin/bash

function check_installation_of_wget() {
  which wget > /dev/null 2>&1
  return $?
}

function download_gradle_distributions() {
  DOWNLOAD_DIRECTORY=$1
  echo "--------------------------------------------------"
  echo "Start to download Gradle distributions..."
  local url="https://services.gradle.org/distributions/"
  # TODO: Skip downloading if local file exists
  wget -q --show-progress -P $DOWNLOAD_DIRECTORY https://services.gradle.org/distributions/gradle-3.5-all.zip
}

if [ "$#" -ne 1 ]; then
  echo "Missing parameter for download directory"
  exit 1
fi
DOWNLOAD_DIRECTORY=$1
check_installation_of_wget && download_gradle_distributions $DOWNLOAD_DIRECTORY || (echo "wget is not installed" && exit 1)
