FROM php:7-apache

RUN docker-php-ext-install pdo_mysql

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

VOLUME /var/www
VOLUME /var/log

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

COPY ./conf/php.ini /usr/local/etc/php/php.ini

ADD ./sites-available/*.conf /etc/apache2/sites-available/

RUN a2enmod rewrite

RUN for file in /etc/apache2/sites-available/*.conf; \
  do \
    echo "**** $(basename $file)"; \
    a2ensite "$(basename $file)"; \
  done

WORKDIR /var/www
