#!/bin/bash

PHP_VERSION=${1:-php74}
XDEBUG_INI="/etc/php/${PHP_VERSION:3:2}/apache2/conf.d/20-xdebug.ini"

# Display help message.
display_help() {
    echo "Usage: $0 [option...]" >&2
    echo
    echo "   -i php_version   the PHP version you want to use (default is 'php74')"
    echo "   --host           the host IP address for Xdebug (e.g., '172.17.0.1', default is 'host.docker.internal')"
    echo "   -h, --help       print this help message"
    exit 1
}

# Option --host is optional and has a default value.
HOST_IP=""

# Use getopts to handle options and their arguments.
while :; do
    case "$1" in
        -i)
            if [ "$2" ]; then
                PHP_VERSION=$2
                shift 2
                continue
            else
                echo 'ERROR: "-i" requires a non-empty option argument.'
                exit 1
            fi
            ;;
        --host)
            if [ "$2" ]; then
                HOST_IP=$2
                shift 2
                continue
            else
                echo 'ERROR: "--host" requires a non-empty option argument.'
                exit 1
            fi
            ;;
        -h|--help)
            display_help
            ;;
        --)
            shift
            break
            ;;
        *)
            break
    esac
shift
done

# If the host IP is not provided, use the default value.
if [ -z "$HOST_IP" ]; then
    HOST_IP='host.docker.internal'
fi

PHP_CONTAINER="dru-server-${PHP_VERSION}"


# Install Xdebug for the specified PHP version.
install_xdebug() {
  CONTAINER_NAME="dru-server-${PHP_VERSION}"
  CONTAINER_STATUS=$(docker inspect --format='{{.State.Status}}' $PHP_CONTAINER)

  if [ "$CONTAINER_STATUS" != "running" ]; then
    docker-compose up -d
  fi

  # Install Xdebug
  docker-compose exec -T ${CONTAINER_NAME} apt-get update
  docker-compose exec -T ${CONTAINER_NAME} apt-get install -y php-xdebug

  # Add Xdebug configuration
  docker-compose exec -T ${CONTAINER_NAME} bash -c "echo 'xdebug.mode=debug' >> $XDEBUG_INI"
  docker-compose exec -T ${CONTAINER_NAME} bash -c "echo 'xdebug.start_with_request=yes' >> $XDEBUG_INI"
  docker-compose exec -T ${CONTAINER_NAME} bash -c "echo 'xdebug.client_host=$HOST_IP' >> $XDEBUG_INI"
  docker-compose exec -T ${CONTAINER_NAME} bash -c "echo 'xdebug.client_port=9003' >> $XDEBUG_INI"
  docker-compose exec -T ${CONTAINER_NAME} bash -c "echo 'xdebug.log=/var/www/html/xdebug.log' >> $XDEBUG_INI"

  # Reload Apache after installing xdebug
  docker-compose exec -T ${CONTAINER_NAME} service apache2 reload

  echo "Xdebug installed and configured for ${CONTAINER_NAME} with host: ${HOST_IP}"
}

# Install Xdebug for the specified PHP version.
case "$PHP_VERSION" in
  php70|php74|php81|php82)
    install_xdebug
    ;;
  *)
    echo "Unsupported PHP version: ${PHP_VERSION}"
    exit 1
    ;;
esac
