#!/bin/bash

set -e
IMAGE_NAME="my-docker-image"

CONTAINER_NAME="my-docker-container"

function main() {
  case "$1" in
    build)
      build_image
      ;;
    run)
      run_container
      ;;
    exec)
      exec_bash "$2"
      ;;
    logs)
      show_logs
      ;;
    *)
      echo "Usage: $0 {build|run|exec|logs}"
      exit 1
  esac
}

function build_image() {
  echo "Building Docker image..."
  docker build -t $IMAGE_NAME .
}

function run_container() {
  echo "Running Docker container..."
  docker run -d --name $CONTAINER_NAME $IMAGE_NAME
}

function exec_bash() {
  if [ -z "$1" ]; then
    echo "Error: No command provided to exec."
    exit 1
  fi
  echo "Executing command inside container..."
  docker exec -it $CONTAINER_NAME bash -c "$1"
}

function show_logs() {
  echo "Showing logs from container..."
  docker logs -f $CONTAINER_NAME
}

main "$@"
