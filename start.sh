#!/bin/bash

PHP_VERSION=${2:-php74}

if [ "$1" == "-i" ]; then
  PHP_CONTAINER="dru-server-${PHP_VERSION}"
else
  PHP_CONTAINER="dru-server-php74"
fi

CONTAINER_STATUS=$(docker inspect --format='{{.State.Status}}' $PHP_CONTAINER)

if [ "$CONTAINER_STATUS" == "running" ]; then
  docker exec -it $PHP_CONTAINER bash
else
  docker-compose up -d && docker exec -it $PHP_CONTAINER bash
fi



