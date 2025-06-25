FROM php:8.2-apache
# Local
RUN apt-get update && apt-get install -y locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_ALL ru_RU.UTF-8
# end local
RUN apt-get update && apt-get install -y \
    librabbitmq-dev \
    libssl-dev \
    libzip-dev libicu-dev libxml2-dev unzip git \
    libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev \
    && pecl install amqp \
    && docker-php-ext-enable amqp \
    && docker-php-ext-install pdo pdo_mysql zip intl exif gd

RUN a2enmod rewrite
COPY docker/apache/pimcore.conf /etc/apache2/sites-available/000-default.conf
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

