#!/bin/bash

# Enable docker to start at boot time, required only once:
#   systemctl enable docker
# Init new server environment for services, required only once:
#   docker swarm init

# You may need to run this first before service works propery,
# it may otherwise give 0/1 replicas.
#   docker-compose up

echo "List services"
docker service ls

VAR=$(docker service ls | grep geoweb | awk '{print $1}')
if [[ ! -z "$VAR" ]]
then
  echo -e "\nRemove existing geoweb services"
  docker service rm $(echo "$VAR" | xargs)
fi


echo -e "\n\nList containers"
docker ps -a

VAR=$(docker ps -a | grep -E "(geoweb|adaguc)" | awk '{print $1}')
if [[ ! -z "$VAR" ]]
then
  echo -e "\nStop geoweb containers"
  docker stop $(echo "$VAR" | xargs)
fi

VAR=$(docker ps -a | grep -E "(geoweb|adaguc)" | awk '{print $1}')
if [[ ! -z "$VAR" ]]
then
  echo -e "\nRemove existing geoweb containers"
  docker rm $(echo "$VAR" | xargs)
fi


echo -e "\n\nStart services"
docker stack deploy -c docker-compose.yml geoweb