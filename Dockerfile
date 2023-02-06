# Use an official PHP image as the base image
FROM php:7.4-fpm

# Set the working directory
WORKDIR /app

# Copy the composer.json and composer.lock files
COPY composer.json composer.lock ./

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    zip \
    libpq-dev \
    libonig-dev \
    libxml2-dev

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel dependencies
RUN composer install --no-scripts --no-dev --no-autoloader

# Copy the rest of the application code
COPY . .

# Run composer again to generate autoload files and to optimize the class loading
RUN composer dump-autoload --optimize

# Expose the port 9000 to the host
EXPOSE 9000

# Set the command to run when the container starts
CMD ["php-fpm"]

