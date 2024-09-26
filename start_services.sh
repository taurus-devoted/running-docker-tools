#!/bin/bash

set -e

if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi

echo "Stopping and removing existing containers..."
docker-compose down

echo "Starting services with Docker Compose..."
docker-compose up -d

echo "Services are up and running!"
