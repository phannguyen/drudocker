# DruDocker
Local development environment for Drupal with multiple PHP versions. 
Support: PHP 7.0, 7.4, 8.1, 8.2
## 1. Clone drudocker
   🔭 **To build and run the containers using Docker Compose:**
   - Build the Docker containers: `docker-compose build`
   - Start the containers (use -d to run in detached mode): `docker-compose up` or `docker-compose up -d`

   🌱 **To access the server via command line for different PHP versions:**
   - For PHP 7.0: `docker exec -it dru-server-php70 bash`
   - For PHP 7.4: `docker exec -it dru-server-php74 bash`
   - For PHP 8.1: `docker exec -it dru-server-php81 bash`
   - For PHP 8.2: `docker exec -it dru-server-php81 bash`

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

