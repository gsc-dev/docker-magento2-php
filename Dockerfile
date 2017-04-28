FROM php:7.0-fpm

ENV PHPREDIS_VERSION 3.2.3

RUN apt-get update \
  && apt-get install -y \
    git sudo vim mysql-client curl \
    cron \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxslt1-dev \
    libcurl4-gnutls-dev

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/

RUN docker-php-ext-install \
gd \
intl \
mbstring \
mcrypt \
pdo_mysql \
soap \
xsl \
zip \
bcmath \
zip \
json \
opcache

# install imagick extension
RUN apt-get install -y imagemagick libmagickwand-dev libmagickcore-dev \
&& pecl install imagick \
&& docker-php-ext-enable imagick

RUN apt-get install -y build-essential tcl8.5 wget \
&& wget http://download.redis.io/releases/redis-stable.tar.gz \
&& tar xzf redis-stable.tar.gz \
&& cd redis-stable \
&& make \
&& make install \
&& cd utils \
&& ./install_server.sh

# install phpredis extension
RUN git clone https://github.com/phpredis/phpredis /usr/src/php/ext/redis \
&& cd /usr/src/php/ext/redis \
&& git checkout php7 \
&& docker-php-ext-install redis

RUN curl -sS https://getcomposer.org/installer | \
    php -- \
      --install-dir=/usr/local/bin \
      --filename=composer \
      --version=1.1.2

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 10
ENV PHP_PM_START_SERVERS 4
ENV PHP_PM_MIN_SPARE_SERVERS 2
ENV PHP_PM_MAX_SPARE_SERVERS 6
ENV APP_MAGE_MODE default

COPY conf/www.conf /usr/local/etc/php-fpm.d/
COPY conf/php.ini /usr/local/etc/php/
COPY conf/php-fpm.conf /usr/local/etc/
COPY docker/* /usr/local/docker/

WORKDIR /srv/www

# Start the Service
CMD ["/usr/local/docker/entrypoint"]
