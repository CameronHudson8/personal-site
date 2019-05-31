# Use an official image as a parent image
FROM composer

# Set the working directory within the docker container
WORKDIR /app

# Copy in the app, then install dependencies.
# Note that composer.json and composer.lock are excluded from COPY by the .dockerignore.
COPY . /app
RUN composer install

# Expose the development server port to the docker service
EXPOSE 8000

ENTRYPOINT ["php", "artisan", "serve", "--host=0.0.0.0"]