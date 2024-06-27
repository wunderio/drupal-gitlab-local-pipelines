# Use PHP 8.2 official image.
FROM php:8.2-cli

# Install system dependencies.
RUN apt-get update && apt-get install -y \
    git \
    unzip

# Install Composer globally.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create a non-root user and give it sudo privileges.
RUN useradd -m dockeruser && \
    echo "dockeruser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the non-root user.
USER dockeruser

# Set working directory
WORKDIR /app

# Copy the composer.json and composer.lock
# This allows us to utilize Docker cache layers when composer dependencies do not change
# COPY composer.json composer.lock /app/

# Install project dependencies
#RUN composer install

# Copy the rest of the application code
#COPY . /app

# Default command to be run when the container starts
CMD ["php", "-v"]
