#!/bin/bash

# Deploy Script for Jenkins Automation
# Uses Jenkins environment variables:
# BUILD_NUMBER
# BRANCH_NAME
# DOCKER_USERNAME
# DOCKER_PASSWORD
set -e
IMAGE_NAME="devops-build-app"
TAG=${BUILD_NUMBER}
BRANCH=${BRANCH_NAME}
DOCKERHUB_USERNAME=${DOCKER_USERNAME}

if [ -z "$TAG" ] || [ -z "$BRANCH" ]; then
  echo "Required Jenkins environment variables not found"
  exit 1
fi

# Decide repository based on branch
if [ "$BRANCH" = "dev" ]; then
  REPO="devops-build-app-dev"
elif [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
  REPO="devops-build-app-prod"
else
  echo "Unknown branch: $BRANCH"
  echo "Defaulting to dev repository"
  REPO="devops-build-app-dev"
fi

echo "Logging into DockerHub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "Tagging image..."
docker tag ${IMAGE_NAME}:${TAG} ${DOCKERHUB_USERNAME}/${REPO}:${TAG}

echo "Pushing image..."
docker push ${DOCKERHUB_USERNAME}/${REPO}:${TAG}

echo "Image pushed successfully to ${REPO}:${TAG}"