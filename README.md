# docker_server
Dev environment for Drupal
1. Clone drudocker
   Run:
   - docker-compose build
   - docker-compose up 

2. Config vhost: 
  - Create vhost in  docker/app/ubuntu/apache2/sites-available  (refer file: sample.conf.example)
  - Update file hosts (/etc/hosts)
  - Ex: 
      docker/app/ubuntu/apache2/sites-available/example.mydomain.conf
      127.0.0.1 example.mydomain
    
3. phpMyAdmin
- http://localhost:9090/
- Username: root
- Password: root

4. Mailhog
- Webmail: http://localhost:8025
- SMTP: + host: mailhog
        + user: null
        + password: null
