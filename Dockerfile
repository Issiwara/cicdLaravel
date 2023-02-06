# Use an official PHP image as the base image
FROM php:7.4-apache

# Set working directory
WORKDIR /var/www/html

# Copy the application code to the container
COPY . .

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install \
    intl \
    zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel dependencies
RUN composer install

# Copy the Apache configuration file to the container
COPY /var/www/html/apache2.conf /etc/apache2/sites-available/000-default.conf

# Expose port 80 for web traffic
EXPOSE 80

# Start Apache when the container launches
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


