# Install dependencies using composer
FROM composer AS build-stage
WORKDIR /app
# Note that composer.json and composer.lock are excluded from COPY by the .dockerignore.
COPY ./laravel/composer.json ./laravel/composer.lock ./laravel/artisan ./
COPY ./laravel/database/. ./database/
COPY ./laravel/bootstrap/. ./bootstrap/
RUN composer install --no-scripts
COPY ./laravel/. ./
RUN composer install && php artisan key:generate

# Start the nginx server
FROM richarvey/nginx-php-fpm  
WORKDIR /var/www/html
RUN rm index.php
COPY --from=build-stage /app/. ./
ENV WEBROOT /var/www/html/public/
EXPOSE 80