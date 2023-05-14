FROM php:8.1-apache
WORKDIR /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -O https://phar.phpunit.de/phpunit-10.0.19.phar

RUN chmod +x phpunit-10.0.19.phar && mv phpunit-10.0.19.phar /usr/local/bin/phpunit

RUN phpunit --version

RUN apt-get update && apt-get install -y \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-enable pdo pdo_mysql

COPY . /var/www/html/
EXPOSE 80