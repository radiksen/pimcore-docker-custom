# Используем официальный образ PHP 8.2-FPM на Alpine Linux
FROM php:8.2-fpm-alpine

# Устанавливаем системные зависимости
RUN apk update && apk add --no-cache     $PHPIZE_DEPS     icu-dev     libzip-dev     libjpeg-turbo-dev     libpng-dev     freetype-dev     imagemagick-dev     libwebp-dev     ffmpeg

# Устанавливаем расширения PHP, необходимые для Pimcore
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp     && docker-php-ext-install -j$(nproc)     pdo_mysql     intl     zip     gd     exif     opcache     bcmath

# Устанавливаем PECL расширения (redis, imagick)
RUN pecl install redis imagick     && docker-php-ext-enable redis imagick

# Устанавливаем Composer (глобально)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем кастомный php.ini
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Создаем пользователя www-data, чтобы не работать из-под root
RUN addgroup -g 1000 www && adduser -u 1000 -G www -s /bin/sh -D www-data
USER www-data

# Устанавливаем рабочую директорию
WORKDIR /var/www/html
