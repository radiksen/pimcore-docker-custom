FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    librabbitmq-dev \
    libssl-dev \
    libzip-dev libicu-dev libxml2-dev unzip git \
    libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev \
    && pecl install amqp \
    && docker-php-ext-enable amqp \
    && docker-php-ext-install pdo pdo_mysql zip intl exif gd

RUN a2enmod rewrite

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

