#!/bin/bash
set -e
IMAGE_NAME="devops-build-app"
TAG=${BUILD_NUMBER}

if [ -z "$TAG" ]; then
  echo "BUILD_NUMBER not found"
  exit 1
fi

echo "Building Docker image with tag: $TAG"

docker build -t ${IMAGE_NAME}:${TAG} .

echo "Build completed successfully"
