ARG PHP_IMAGE
ARG NGINX_IMAGE

FROM ${PHP_IMAGE} as php_dev

RUN apk --update --no-cache add wget \
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

# Install php extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN set -eux; \
    install-php-extensions \
        apcu \
        bcmath \
        exif \
        gd \
        intl \
        intl \
        mbstring \
        mysqli \
        pcntl \
        pdo \
        pdo_mysql \
        redis \
        xml \
        zip \
    ;

RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick

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
