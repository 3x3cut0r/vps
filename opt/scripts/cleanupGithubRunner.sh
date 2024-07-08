#!/bin/bash
docker container stop $(docker ps -q)
docker builder prune -af
docker image prune -af
docker volume prune -af
docker system prune -af