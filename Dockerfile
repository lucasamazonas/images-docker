FROM php:7.4-apache

WORKDIR /var/www/html

RUN a2enmod rewrite

RUN apt-get update && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

RUN apt-get install -y libzip-dev && \ 
    docker-php-ext-install zip && \
    apt-get install -y libpng-dev && \ 
    docker-php-ext-install gd && \ 
    apt-get install -y libpq-dev  && \ 
    docker-php-ext-install pdo_pgsql pgsql && \
    pecl install redis-5.3.7 && \
	docker-php-ext-enable redis

RUN chown -R www-data:www-data /var/www/html