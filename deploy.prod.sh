#!/bin/sh

# docker stop $(docker ps -aqf "name=personal-site_app")
docker stop $(docker ps -aqf "name=personal-site_webserver")
docker rm $(docker ps -aq)
docker volume rm $(docker volume ls -q)
# docker rmi $(docker image ls -q)
# export CURRENT_UID=$UID
docker-compose -f docker-compose.prod.yml up #-d

# Create a user in each of the containers
# docker exec -it $(docker ps -aqf "name=personal-site_app") "useradd -D -g ${GID} -u ${UID} && su ${UID}"
# docker exec -it $(docker ps -aqf "name=personal-site_webserver") "useradd -D -g ${GID} -u ${UID} && su ${UID}"