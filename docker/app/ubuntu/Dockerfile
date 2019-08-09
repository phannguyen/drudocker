FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install git
    git \
    # Install apache
    apache2 \
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php-imagick \
    # Install tools
    openssl \
    nano \
    graphicsmagick \
    imagemagick \
    ghostscript \
    mysql-client \
    iputils-ping \
    locales \
    sqlite3 \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

# Update php.ini
COPY drupal.ini /etc/php/7.2/mods-available/
RUN phpenmod drupal

# Configure apache 
RUN a2enmod rewrite expires ssl
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

# Configure vhost 
COPY ssl/ /etc/apache2/ssl/
COPY vhost.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite vhost.conf

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get install --yes nodejs

RUN npm install -g gulp

EXPOSE 80 443

WORKDIR /var/www/html

RUN rm index.html

CMD apachectl -D FOREGROUND