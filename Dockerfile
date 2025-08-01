# Use PHP with Apache
FROM php:8.2-apache

# Install MySQLi extension for PHP
RUN docker-php-ext-install mysqli

# Copy all PHP code to Apache's root
COPY src/ /var/www/html/

EXPOSE 80
