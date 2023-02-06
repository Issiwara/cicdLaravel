# Use an official PHP image as the base image
FROM php:7.4-apache

WORKDIR /app

RUN docker-php-ext-install pdo_mysql
RUN a2enmod rewrite

COPY . .

ADD . /var/www
ADD ./public /var/www/html
RUN composer install
EXPOSE 80



