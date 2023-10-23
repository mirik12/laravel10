ARG PHP_IMAGE
ARG NGINX_IMAGE
# 57 та 58 оголошую їх в гітлаб сі а 69 і 70 використовую

FROM ${PHP_IMAGE} as php_dev

# додаю тули пакети які потрібні будуть
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

# Install php extensions (копіюю код в контейнер який збираю)
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

# качаю тули але по послідовності ( якщо перший не виокнається далі йти нічого не буде)
RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="${PATH}:/root/.composer/vendor/bin"

# оголушую що при вході в контейнер , то буде по дефолту значення /var/www (робота директорія при використанні докер контейнера)
WORKDIR /var/www
# копіюю поточну директорію з правами user data group www data
COPY --chown=www-data:www-data . /var/www
COPY --chown=www-data:www-data .env.ci /var/www/.env
RUN set -eux; \
    composer install --no-scripts --no-interaction --prefer-dist;

# Copy PHP configs
COPY ./dev/docker-compose/php/supervisord-app.conf /etc/supervisord.conf
COPY ./dev/docker-compose/php/app.ini /usr/local/etc/php/conf.d/app.ini

COPY --link ./k8s/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
# те що запускається по дефолту (docker-entrypoint - це виконувальний файл - артіфакт)
ENTRYPOINT [ "docker-entrypoint" ]

EXPOSE 9000
CMD ["php-fpm"]

FROM ${NGINX_IMAGE} as nginx_dev

WORKDIR /var/www

COPY ./dev/docker-compose/nginx /etc/nginx/conf.d/
COPY --from=php_dev /var/www /var/www

CMD ["nginx", "-g", "daemon off;"]
