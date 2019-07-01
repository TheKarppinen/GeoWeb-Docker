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


# Small wait to make sure previous operation has enought time to finish
sleep 2

echo -e "\n\nList containers"
docker ps -a

VAR=$(docker ps -a | grep -E "(geoweb|adaguc)" | awk '{print $1}')
if [[ ! -z "$VAR" ]]
then
  echo -e "\nStop geoweb containers"
  docker stop $(echo "$VAR" | xargs)
fi

# Small wait to make sure previous operation has enought time to finish
sleep 2

VAR=$(docker ps -a | grep -E "(geoweb|adaguc)" | awk '{print $1}')
if [[ ! -z "$VAR" ]]
then
  echo -e "\nRemove existing geoweb containers"
  docker rm $(echo "$VAR" | xargs)
fi


# Small wait to make sure previous operation has enought time to finish
sleep 2

echo -e "\n\nList networks"
docker network ls

VAR=$(docker network ls | grep -E "(geoweb|adaguc)" | awk '{print $2}')
if [[ ! -z "$VAR" ]]
then
  echo -e "\nRemove geoweb networks"
  docker network rm $(echo "$VAR" | xargs)
fi


# Small wait to make sure previous operation has enought time to finish
sleep 2

echo -e "\n\nList volumes"
docker volume ls

VAR=$(docker volume ls | grep -E "(geoweb|adaguc)" | awk '{print $2}')
if [[ ! -z "$VAR" ]]
then
  echo -e "\nRemove geoweb volumes"
  docker volume rm $(echo "$VAR" | xargs)
fi


# Small wait to make sure previous operation has enought time to finish
sleep 4

echo -e "\n\nStart services"
docker stack deploy -c docker-compose.yml geoweb
