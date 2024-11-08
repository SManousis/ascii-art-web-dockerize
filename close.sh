#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
docker container stop $(docker container ls -q)

# Remove all stopped containers
echo "Removing all stopped containers..."
docker container rm $(docker container ls -aq)

# Remove all unused images
echo "Removing all unused images..."
docker image prune -af

# Remove all unused networks
echo "Removing all unused networks..."
docker network prune -f

echo "Docker cleanup complete!"