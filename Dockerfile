# Use an official PHP image as the base image
FROM php:7.4-apache

# Set the working directory in the container to /app
WORKDIR /app

# Copy the entire project to the /app directory in the container
COPY . .

# Install dependencies
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip

# Copy the virtual host configuration file to the Apache configuration directory
COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Enable the virtual host configuration
RUN a2ensite 000-default

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel dependencies
RUN composer install

# Generate an application key
RUN php artisan key:generate

# Expose port 80 for web traffic
EXPOSE 80

# Start the Apache web server
CMD ["apache2-foreground"]
