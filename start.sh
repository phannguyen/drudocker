#!/bin/bash

display_help() {
    echo "Usage: $0 -i php_version [--host host_ip_address]" >&2
    echo
    echo "   -i php_version   Specify the PHP version you want to use (default is 'php74')"
    echo "   -h, --help       Display help information"
    exit 1
}

PHP_VERSION='php74' # default PHP version

while getopts ':hi:' OPTION; do
  case "$OPTION" in
    h)
      display_help
      ;;
    i)
      PHP_VERSION="$OPTARG"
      ;;
    ?)
      display_help
      ;;
  esac
done

PHP_CONTAINER="dru-server-${PHP_VERSION}"
CONTAINER_STATUS=$(docker inspect --format='{{.State.Status}}' "$PHP_CONTAINER")

if [ "$CONTAINER_STATUS" == "running" ]; then
  docker exec -it "$PHP_CONTAINER" bash
else
  # If you have a specific docker-compose file, make sure to reference it.
  docker-compose up -d
  # Wait until container is fully up before attempting to exec into it
  while [ "$(docker inspect --format='{{.State.Status}}' "$PHP_CONTAINER")" != "running" ]; do
    sleep 0.5
  done
  docker exec -it "$PHP_CONTAINER" bash
fi
