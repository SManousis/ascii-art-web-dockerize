#!/bin/bash

# Build the Docker image
docker image build -f Dockerfile -t ascii-art-web-docker .

# Run the container
docker container run -p 8080:8080 --detach --name ascii-art-web ascii-art-web-docker
