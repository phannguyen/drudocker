#!/bin/bash

XDEBUG_INI="/etc/php/7.4/fpm/conf.d/20-xdebug.ini"

add_xdebug_config() {
  CONFIG=$1
  FILE=$2

  if ! grep -qF -- "$CONFIG" "$FILE"; then
    echo "$CONFIG" >> "$FILE"
  fi
}

# Install Xdebug
docker-compose exec -T php7-server apt-get update
docker-compose exec -T php7-server apt-get install -y php7.4-xdebug

# Add Xdebug configuration
docker-compose exec -T php7-server bash -c "$(declare -f add_xdebug_config); add_xdebug_config 'xdebug.mode=debug' $XDEBUG_INI"
docker-compose exec -T php7-server bash -c "$(declare -f add_xdebug_config); add_xdebug_config 'xdebug.start_with_request=yes' $XDEBUG_INI"
docker-compose exec -T php7-server bash -c "$(declare -f add_xdebug_config); add_xdebug_config 'xdebug.client_host=host.docker.internal' $XDEBUG_INI"
docker-compose exec -T php7-server bash -c "$(declare -f add_xdebug_config); add_xdebug_config 'xdebug.client_port=9003' $XDEBUG_INI"
docker-compose exec -T php7-server bash -c "$(declare -f add_xdebug_config); add_xdebug_config 'xdebug.log=/var/www/html/xdebug.log' $XDEBUG_INI"

# Restart PHP-FPM
docker-compose exec -T php7-server service php7.4-fpm restart
