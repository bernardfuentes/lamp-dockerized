FROM php:7-apache

RUN docker-php-ext-install mysqli

#RUN docker-php-ext-install pdo_mysql

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

VOLUME /var/www
VOLUME /var/log

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

COPY conf/php.ini /usr/local/etc/php/php.ini

COPY index.php /var/www

COPY /virtual_sites/001-indigenous.conf /etc/apache2/sites-available/
COPY /virtual_sites/000-default.conf /etc/apache2/sites-available/
RUN a2ensite 000-default.conf
RUN a2ensite 001-indigenous.conf

RUN a2enmod rewrite

WORKDIR /var/www
