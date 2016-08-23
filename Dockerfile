FROM php:5.6.23-fpm

RUN apt-get update \
  && apt-get install -y \
    git sudo vim emacs \
    cron \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxslt1-dev \
    libbz2-dev \
    libc-client-dev \
    php5-memcache \
    php5-memcached \
    libpspell-dev \
    php5-redis \
    libtidy-dev \
	libxpm-dev


RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-xpm-dir=/usr/include/

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
  bz2 \
  calendar \
  dba \
  exif \
  gettext \
  hash \
  mysql \
  mysqli \
  pcntl \
  pspell \
  shmop \
  soap \
  sockets \
  sysvmsg \
  sysvsem \
  sysvshm \
  tidy \
  wddx \
  xmlrpc \
  opcache

  RUN apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
  RUN pecl install imagick-beta

  RUN git clone https://github.com/phadej/igbinary.git && \
      cd igbinary && \
      phpize && \
      ./configure CFLAGS="-O2 -g" --enable-igbinary && \
      make && \
      make install && \
      cd .. && \
      rm -fr igbinary && \
      echo "extension=igbinary.so" >> /etc/php5/mods-available/igbinary.ini && \
      echo "igbinary.compact_strings=Off" >> /etc/php5/mods-available/igbinary.ini && \
      php5enmod igbinary

  # ftp \ aa
  # pcre \ aaa
  # redis \ aaa
  # imap \

RUN curl -sS https://getcomposer.org/installer | \
  php -- \
    --install-dir=/usr/local/bin \
    --filename=composer \
    --version=1.1.2

# ### CLEANUP ###
# RUN apt-get clean && \
#     apt-get -qqy autoclean && \
#     apt-get -qqy autoremove && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


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
COPY bin/* /usr/local/bin/

WORKDIR /srv/www

CMD ["/usr/local/bin/start"]
