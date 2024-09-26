#!/bin/bash

# ddừng script nếu có lỗi
set -e

IMAGE_NAME="my-docker-image"

CONTAINER_NAME="my-docker-container"
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  echo "Docker image not found. Building Docker image..."
  docker build -t $IMAGE_NAME .
else
  echo "Docker image found. Skipping build."
fi

if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" ]]; then
    echo "Container is running. Stopping container..."
    docker stop $CONTAINER_NAME
fi

if [[ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]]; then
    echo "Removing existing container..."
    docker rm $CONTAINER_NAME
fi

echo "Running Docker container..."
docker run -d --name $CONTAINER_NAME $IMAGE_NAME

echo "Docker container is up and running!"
