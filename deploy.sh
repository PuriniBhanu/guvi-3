#!/bin/bash
set -e
IMAGE_NAME="devops-build-app"
CONTAINER_NAME="devops-build-container"
PORT=80

echo "-->Running new container..."
docker run -d   --name $CONTAINER_NAME   -p $PORT:80   $IMAGE_NAME:latest
echo "-->Application Deployed Successfully!"
echo "-->Access it at: http://localhost"

