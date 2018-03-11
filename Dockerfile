FROM php:7-apache

RUN docker-php-ext-install mysqli

#RUN docker-php-ext-install pdo_mysql

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

VOLUME /var/www
VOLUME /var/log

WORKDIR /var/www

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

COPY ./conf/php.ini /usr/local/etc/php/php.ini

COPY ./www/index.php /var/www

ADD ./sites-available/*.conf /etc/apache2/sites-available/

RUN a2enmod rewrite

COPY ./scripts/a2ensites.sh /a2ensites.sh
RUN chmod +x /a2ensites.sh
RUN /a2ensites.sh && rm /a2ensites.sh
