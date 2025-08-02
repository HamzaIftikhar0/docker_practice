FROM php:8.2-apache

RUN a2enmod rewrite

COPY . /var/www/html/
RUN rm -f /var/www/html/index.html

WORKDIR /var/www/html/

RUN docker-php-ext-install mysqli pdo pdo_mysql

EXPOSE 80
