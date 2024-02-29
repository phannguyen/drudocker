# DruDocker
Local development environment for Drupal with multiple PHP versions. 
 
## 1. Setup drudocker
   🔭 **Build the Docker containers :**
```
docker-compose build
```
🌱 **Start the containers and access container**
Use ```
./script/start.sh
``` to start and access the default container `dru-server-php74`, or use the -i option followed by `-i <php-version>` to access a different PHP version container. Example: `./script/start.sh -i php81`

```bash
Usage: ./start.sh -i php_version [--host host_ip_address]

   -i php_version   Specify the PHP version you want to use (default is 'php74')
   -h, --help       Display help information

```
💬 **Additional Commands**

- Start Docker containers: `docker-compose up` or `docker-compose up -d` for detached mode
- Access the PHP 7.0 container: `docker exec -it dru-server-php70 bash`
- Access the PHP 7.4 container: `docker exec -it dru-server-php74 bash`
- Access the PHP 8.1 container: `docker exec -it dru-server-php81 bash`
- Access the PHP 8.2 container: `docker exec -it dru-server-php82 bash`

 ⚡ **Install xdebug**
Refer: `./script/install-xdebug.sh -h`

```bash
Usage: ./script/install-xdebug.sh [option...]

   -i php_version   the PHP version you want to use (default is 'php74')
   --host           the host IP address for Xdebug (e.g., '172.17.0.1', default is 'host.docker.internal')
   -h, --help       print this help message
```
Ex: `./script/install-xdebug.sh -i php81`

## 2. Config vhost:
- 📫 **For php 7x:** 
  - Create vhost in  docker/data/apache2/php7x/sites-available  (refer file: sample.conf.example)
  - Update file hosts (/etc/hosts)
  - Ex:
      - docker/data/apache2/php74/sites-available/example.mydomain.conf
      - 127.0.0.1 example.php74.local
  - Run command: `docker exec -it dru-server-php70 service apache2 restart` or `docker exec -it dru-server-php74 service apache2 restart`

👋*****Note**: The domain must follow the pattern: `*.php70.local` or `*.php74.local`. If you need to make changes, please refer to the Traefik configuration in the docker-compose file.

- 📫 **For php 8x:**
  - Create vhost in  docker/data/apache2/php8x/sites-available  (refer file: sample.conf.example)
  - Update file hosts (/etc/hosts)
  - Ex:
      - docker/data/apache2/php81/sites-available/example.mydomain.conf
      - 127.0.0.1 example.php81.local
  - Run command: `docker exec -it dru-server-php81 service apache2 restart` or `docker exec -it dru-server-php82 service apache2 restart`
    
👋*****Note**: The domain must follow the pattern: `*.php81.local` or `*.php82.local`. If you need to make changes, please refer to the Traefik configuration in the docker-compose file.

## 3. phpMyAdmin
- http://localhost:9090/
- Username: root
- Password: root

## 4. Mailhog
- Webmail: http://localhost:8025
- SMTP:
   - Host: mailhog
   - Port: 1025
   - User: null
   - Password: null

## 5. Solr
- Webmail: http://localhost:8983
- Setting:
   - Host: solr
   - Port: 8983

## 6. MySql
- Port: 3306
- Host: mysql
- Root password: root

## 7. Enable Xdebug (Manual Installation)
 - To enable Xdebug for PHP 7.4-FPM run the script 
```
./script/install-xdebug-php74.sh
```
 - For other versions, you can duplicate the script file and modify it for the respective PHP version installation.

