#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Missing TAG parameter"
  exit 1
else
  TAG=$1
fi

DOCKER_HUB_ACCOUNT=thyrlian
IMAGE_NAME=android-sdk
TEMP_DIR=temp_authorized_keys

# change to the correct working directory
cd $(dirname "$0")

echo "Hiding files inside authorized_keys directory..."
rm -r $TEMP_DIR 2> /dev/null
mkdir -p $TEMP_DIR
mv -v authorized_keys/* $TEMP_DIR

echo "Building Docker image..."
docker build -t $IMAGE_NAME .

echo "Unhiding files inside authorized_keys directory..."
mv -v $TEMP_DIR/* authorized_keys
rm -r $TEMP_DIR

image_id=$(docker images android-sdk | awk '{if (NR!=1) {print $3}}')
echo "Built image ID is: $image_id"

echo "Tagging image with $TAG..."
docker tag $image_id $DOCKER_HUB_ACCOUNT/$IMAGE_NAME:$TAG

docker login

echo "Pushing to Docker Hub..."
docker push $DOCKER_HUB_ACCOUNT/$IMAGE_NAME:$TAG
