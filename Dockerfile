# Use official PHP image with Apache
FROM php:8.1-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git curl \
    && docker-php-ext-install zip pdo pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /app

# Copy Yii2 app files
COPY . /app

# Expose port
EXPOSE 8080

# Start server
#CMD ["php", "basic/yii", "serve", "--host=0.0.0.0", "--port=8080"]
CMD ["php", "-S", "0.0.0.0:8080", "-t", "basic/web"]
