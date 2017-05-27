#!/bin/bash

check_installation_of_wget() {
  which wget > /dev/null 2>&1
  return $?
}

download_from_link_to_dir() {
  local link=$1
  local directory=$2
  echo "--------------------------------------------------"
  echo "Start to download Gradle distributions..."
  echo $link
  # TODO: Skip downloading if local file exists
  wget -q --show-progress -P $directory $link
}

parse_gradle_distributions_links_and_download() {
  local directory=$1
  local amount=$2
  local url="https://services.gradle.org/distributions/"
  local data=$(wget -q -O- $url | grep -o "\".*distributions.*all\.zip\"" | sed "s/\"//g" | sed "s/.*distributions/https:\/\/services.gradle.org\/distributions/g")
  read -ra links <<< $data
  for i in "${!links[@]}"; do
    if [ $i -eq $amount ]; then
      break
    fi
    download_from_link_to_dir ${links[i]} $directory
  done
}

if [ "$#" -lt 1 ]; then
  echo "Missing parameter for download directory"
  exit 1
elif [ "$#" -lt 2 ]; then
  DOWNLOAD_AMOUNT=65535
fi
DOWNLOAD_DIRECTORY=$1
[ -z $DOWNLOAD_AMOUNT ] && DOWNLOAD_AMOUNT=$2
check_installation_of_wget && parse_gradle_distributions_links_and_download $DOWNLOAD_DIRECTORY $DOWNLOAD_AMOUNT || (echo "wget is not installed" && exit 1)
