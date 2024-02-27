# DruDocker
Local development environment for Drupal with multiple PHP versions.
## 1. Clone drudocker
   🔭 **To build and run the containers using Docker Compose:**
   - Build the Docker containers: `docker-compose build`
   - Start the containers (use -d to run in detached mode): `docker-compose up` or `docker-compose up -d`

   🌱 **To access the server via command line for different PHP versions:**
   - For PHP 7.x: `docker exec -it dru-server-php7 bash`
   - For PHP 8.x: `docker exec -it dru-server-php8 bash`

## 2. Config vhost:
- 📫 **For PHP7-Server:**
  - Create vhost in  docker/app/php7-server/apache2/sites-available  (refer file: sample.conf.example)
  - Update file hosts (/etc/hosts)
  - Ex:
      - docker/app/php7-server/apache2/sites-available/example.mydomain.conf
      - 127.0.0.1 example.php7.local
  - Run command: `docker exec -it dru-server-php7 service apache2 restart`

👋*****Note**: The domain must follow the pattern: `*.php7.local`. If you need to make changes, please refer to the Traefik configuration in the docker-compose file.

- 📫 **For PHP8-Server:**
  - Create vhost in  docker/app/php8-server/apache2/sites-available  (refer file: sample.conf.example)
  - Update file hosts (/etc/hosts)
  - Ex:
      - docker/app/php8-server/apache2/sites-available/example.mydomain.conf
      - 127.0.0.1 example.mydomain
  - Run command: `docker exec -it dru-server-php8 service apache2 restart`
    
👋*****Note**: The domain must follow the pattern: *.php8.local. If you need to make changes, please refer to the Traefik configuration in the docker-compose file.

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
./script/install-xdebug-php74-fpm.sh
```
 - For other versions, you can duplicate the script file and modify it for the respective PHP version installation.

