FROM php:8.1-fpm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    zlib1g-dev \
    libpq-dev \
    libpng-dev \
    nginx \
    libzip-dev \
    unzip \
    zip \
    curl \
    git \
    libonig-dev \
    libxml2-dev

ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID dockeruser && useradd -u $UID -g $GID -m dockeruser

RUN docker-php-ext-install pdo pdo_pgsql mbstring xml gd pcntl exif zip sockets intl

RUN pecl install mongodb && docker-php-ext-enable mongodb

RUN git config --global --add safe.directory /var/www/edrn

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
