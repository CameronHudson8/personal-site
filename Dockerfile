# Use an official image as a parent image
FROM composer

# Set the working directory within the docker container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Run the installation command
RUN composer install

