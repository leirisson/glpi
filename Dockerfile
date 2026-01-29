ARG PHP_VERSION=8.4
FROM ghcr.io/glpi-project/glpi-development-env:$PHP_VERSION
USER root
RUN cp /etc/apache2/sites-available/glpi-10.x.conf /etc/apache2/sites-available/000-default.conf
ENV PHP_INI_SCAN_DIR="/usr/local/etc/php/conf.d/:/usr/local/etc/php/custom_conf.d/"
RUN mkdir -p /usr/local/etc/php/custom_conf.d/
WORKDIR /var/www/glpi
COPY . /var/www/glpi/
RUN composer install --no-dev --prefer-dist --no-progress --no-interaction
RUN php bin/console dependencies install
RUN chown -R www-data:www-data /var/www/glpi
EXPOSE 80
