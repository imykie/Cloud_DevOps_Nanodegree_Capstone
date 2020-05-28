#!/bin/bash

# Docker image path
dockerpath=imykel/devops-capstone

echo "Docker image path: $dockerpath"

# Authenticate docker
docker login -u $1 -p $2

# Tag docker path
docker tag capstone-app $dockerpath:latest

# Push docker image to dockerhub registry
docker push $dockerpath:latest
