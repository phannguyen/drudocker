# docker_server
Dev environment for Drupal

1. Run: docker-compose up
2. Config vhost: 
  - Add/update in file docker/app/ubuntu/vhost.conf
  - Update file hosts (/etc/hosts)
    ex: 127.0.0.1 example.mydomain
    
3. phpMyAdmin
- http://localhost:9090/
- Username: root
- Password: root
