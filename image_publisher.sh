#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Missing TAG parameter"
  exit 1
else
  TAG=$1
fi

docker login

DOCKER_HUB_ACCOUNT=thyrlian
DOCKER_FILE_NAME=Dockerfile
MAIN_IMAGE_NAME=android-sdk
MAIN_IMAGE_DIR=android-sdk
SUB_IMAGE_NAME=android-sdk-vnc
SUB_IMAGE_DIR=vnc
TEMP_DIR=temp_authorized_keys

# extract base image name and tag from Dockerfile
regex_name_and_tag='FROM[[:blank:]]([^:]*):([^:]*)'
base_info=$(grep "^FROM[[:blank:]][^:]*:[^:]*" $MAIN_IMAGE_DIR/$DOCKER_FILE_NAME)
if [[ $base_info =~ $regex_name_and_tag ]]; then
  BASE_IMAGE_NAME=${BASH_REMATCH[1]}
  BASE_IMAGE_TAG=${BASH_REMATCH[2]}
fi

# change to the correct working directory
cd $(dirname "$0")
cd $MAIN_IMAGE_DIR

echo "Pulling the latest base image..."
docker pull $BASE_IMAGE_NAME:$BASE_IMAGE_TAG

echo "Hiding files inside authorized_keys directory..."
rm -r $TEMP_DIR 2> /dev/null
mkdir -p $TEMP_DIR
mv -v authorized_keys/* $TEMP_DIR

echo "Building the main image..."
docker build -t $MAIN_IMAGE_NAME .

image_id=$(docker images $MAIN_IMAGE_NAME | awk '{if (NR!=1) {print $3}}')
echo "Built main image ID is: $image_id"

echo "Tagging the main image with $TAG..."
docker tag $image_id $DOCKER_HUB_ACCOUNT/$MAIN_IMAGE_NAME:$TAG

echo "Pushing the main image to Docker Hub..."
docker push $DOCKER_HUB_ACCOUNT/$MAIN_IMAGE_NAME:$TAG

echo "Change the base image tag in the sub image file..."
if [ $(uname) = "Darwin" ]; then
	sed -i "" "s/$MAIN_IMAGE_NAME:latest/$MAIN_IMAGE_NAME:$TAG/" $SUB_IMAGE_DIR/Dockerfile
else
	sed -i"" "s/$MAIN_IMAGE_NAME:latest/$MAIN_IMAGE_NAME:$TAG/" $SUB_IMAGE_DIR/Dockerfile
fi

echo "Building the sub image..."
docker build -t $SUB_IMAGE_NAME $SUB_IMAGE_DIR

echo "Revert the change of the base image tag in the sub image file..."
git checkout -- $SUB_IMAGE_DIR/Dockerfile

image_id=$(docker images $SUB_IMAGE_NAME | awk '{if (NR!=1) {print $3}}')
echo "Built sub image ID is: $image_id"

echo "Tagging the sub image with $TAG..."
docker tag $image_id $DOCKER_HUB_ACCOUNT/$SUB_IMAGE_NAME:$TAG

echo "Pushing the sub image to Docker Hub..."
docker push $DOCKER_HUB_ACCOUNT/$SUB_IMAGE_NAME:$TAG

echo "Unhiding files inside authorized_keys directory..."
mv -v $TEMP_DIR/* authorized_keys
rm -r $TEMP_DIR
