FROM composer:2.0.9 as preparation
WORKDIR /app
COPY .env.production .env
COPY . /app
RUN composer install

FROM php:7.4.15-apache
EXPOSE 80
COPY --from=preparation /app /app
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /app a2enmod rewrite