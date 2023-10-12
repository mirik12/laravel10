ARG PHP_IMAGE
ARG NGINX_IMAGE

FROM ${PHP_IMAGE} as php_dev

RUN apk --update add wget \
  curl \
  git \
  grep \
  build-base \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  imagemagick-dev \
  pcre-dev \
  libtool \
  make \
  autoconf \
  g++ \
  cyrus-sasl-dev \
  libgsasl-dev \
  supervisor

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql xml mbstring exif intl pcntl bcmath gd redis
RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick

RUN rm /var/cache/apk/*

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="${PATH}:/root/.composer/vendor/bin"

WORKDIR /var/www
COPY --chown=www-data:www-data . /var/www
COPY --chown=www-data:www-data .env.example /var/www/.env
RUN set -eux; \
    composer install --no-scripts --no-interaction --prefer-dist;

# Copy PHP configs
COPY ./dev/docker-compose/php/supervisord-app.conf /etc/supervisord.conf
COPY ./dev/docker-compose/php/app.ini /usr/local/etc/php/conf.d/app.ini

ENTRYPOINT [ "docker-entrypoint" ]

EXPOSE 9000
CMD ["php-fpm"]

FROM ${NGINX_IMAGE} as nginx_dev

WORKDIR /var/www

COPY ./dev/docker-compose/nginx /etc/nginx/conf.d/
COPY --from=php_dev /var/www /var/www

CMD ["nginx", "-g", "daemon off;"]
