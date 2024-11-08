#!/bin/bash

# Build the Docker image
if ! docker image inspect ascii-art-web-docker > /dev/null 2>&1; then
    echo "Building Docker image..."
    docker image build -f Dockerfile -t ascii-art-web-docker .
else
    echo "Image already exists, skipping build."
fi

# Run the container
if ! docker container inspect ascii-art-web > /dev/null 2>&1; then
    echo "Container not found, starting new container."
    docker container run -p 8080:8080 --detach --name ascii-art-web ascii-art-web-docker
else
    echo "Container is already running."
fi
