FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/php && \
    apt-get update &&  apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    git \
    composer \
    nano \
    vim \
    graphicsmagick \
    imagemagick \
    ghostscript \
    mysql-client \
    locales \
    supervisor \
    wget \
    patch \
    ## For PHP Developer
    apache2 \
    libapache2-mod-fcgid \
    ### Install php 7.0
    php7.0 libapache2-mod-php7.0 php7.0-common php7.0-mbstring php7.0-xmlrpc php7.0-soap php7.0-gd php7.0-xml php7.0-intl php7.0-mysql php7.0-cli php7.0-zip php7.0-curl \
    php7.0-fpm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8


#Install mhmail
RUN cd /usr/local/bin && wget https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64
RUN chmod +x /usr/local/bin/mhsendmail_linux_amd64 && mv /usr/local/bin/mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
COPY mailhog.ini /etc/php/7.0/mods-available/
RUN phpenmod mailhog

# Update php.ini
COPY drupal.ini /etc/php/7.0/mods-available/
RUN phpenmod drupal


# Configure apache
RUN a2enmod actions alias proxy_fcgi fcgid
RUN a2enmod rewrite
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf
RUN a2dissite 000-default
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
#RUN a2ensite vhost.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash
RUN apt-get install --yes nodejs

#RUN npm install -g gulp
RUN npm install -g yarn

EXPOSE 80

WORKDIR /var/www/html


#CMD apachectl -D FOREGROUND
CMD ["/usr/bin/supervisord"]
