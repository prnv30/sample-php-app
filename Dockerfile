# Use official PHP image with Apache
FROM php:8.1-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git curl zip \
    && docker-php-ext-install zip pdo pdo_mysql \
    && a2enmod rewrite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install PHP dependencies using Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Expose port
EXPOSE 8080

# Start built-in PHP server serving the Yii2 web root
CMD ["php", "-S", "0.0.0.0:8080", "-t", "basic/web"]
