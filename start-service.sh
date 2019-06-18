#!/bin/bash

# Enable docker to start at boot time, required only once:
#   systemctl enable docker
# Init new server environment for services, required only once:
#   docker swarm init

# You may need to run this first before service works propery,
# it may otherwise give 0/1 replicas.
#   docker-compose up

# Start services
docker stack deploy -c docker-compose.yml geoweb
