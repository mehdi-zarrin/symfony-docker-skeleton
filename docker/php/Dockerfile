FROM php:8.3-fpm-alpine

ARG USER_ID
ARG GROUP_ID

RUN apk update && apk add $PHPIZE_DEPS
RUN apk add --update bzip2-dev openjdk11-jre linux-headers libmcrypt-dev curl-dev curl libxml2-dev gettext-dev gmp-dev oniguruma-dev sqlite-dev libedit-dev libzip-dev

# Install PHP extensions
#RUN docker-php-ext-configure mcrypt

RUN docker-php-ext-install bcmath \
    bz2 \
    calendar \
    ctype \
    curl \
    dba \
    dom \
    exif \
    fileinfo \
    filter \
    ftp \
    gettext \
    mbstring \
    mysqli \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_sqlite \
    simplexml \
    sockets \
    xml \
    zip

RUN apk add --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug pcov \
    && docker-php-ext-enable xdebug pcov \
    && mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" \
    && apk --no-cache del .build-deps


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

USER $USER_ID
COPY --chown=$USER_ID:$GROUP_ID . /app