# Use the official PHP 8.2-FPM image on Alpine Linux
FROM php:8.2-fpm-alpine

# Install system dependencies required by Pimcore
RUN apk update && apk add --no-cache     $PHPIZE_DEPS     icu-dev     libzip-dev     libjpeg-turbo-dev     libpng-dev     freetype-dev     imagemagick-dev     libwebp-dev     ffmpeg

# Configure and install PHP extensions needed for Pimcore
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp     && docker-php-ext-install -j$(nproc)     pdo_mysql     intl     zip     gd     exif     opcache     bcmath

# Install PECL extensions (redis, imagick)
RUN pecl install redis imagick     && docker-php-ext-enable redis imagick

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy custom php.ini configuration
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Create a non-root user to run commands
RUN addgroup -g 1000 www && adduser -u 1000 -G www -s /bin/sh -D www-data
USER www-data

# Set the working directory
WORKDIR /var/www/html
