FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev

RUN docker-php-ext-install pdo pdo_pgsql

WORKDIR /var/www/html

COPY . /var/www/html

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer install

CMD ["php-fpm"]
