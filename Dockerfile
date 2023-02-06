# Use an official PHP image as the base image
FROM php:7.4-fpm


# Set the working directory in the container to /app
WORKDIR /app

# Copy the composer.json and composer.lock files to the container
COPY composer.json composer.lock ./


# Install dependencies with composer
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip
    
RUN apt-get update && apt-get install -y libmcrypt-dev \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mcrypt pdo_mysql


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install
# Copy the rest of the application code to the container
COPY . ./

# Expose port 9000 and run the PHP-FPM process
EXPOSE 80

CMD ["php-fpm"]

