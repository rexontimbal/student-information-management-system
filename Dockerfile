FROM php:8.2-fpm-alpine

# System packages and PHP extensions (pdo_mysql for the external MySQL add-on)
RUN apk add --no-cache bash nginx supervisor libzip icu-libs \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS libzip-dev icu-dev \
    && docker-php-ext-install pdo_mysql intl zip opcache \
    && apk del .build-deps

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# PHP, php-fpm, nginx and supervisor config
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
COPY docker/php/docker-vars.ini /usr/local/etc/php/conf.d/docker-vars.ini
COPY docker/php/www-overrides.conf /usr/local/etc/php-fpm.d/zz-overrides.conf
COPY docker/nginx/nginx-site.conf /etc/nginx/http.d/default.conf
COPY docker/supervisor/supervisord.conf /etc/supervisord.conf
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh

# Laravel config
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV LOG_CHANNEL=stderr

# Allow composer to run as root during build
ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /var/www/html
COPY . .
RUN chmod +x docker/deploy.sh \
    && composer install --no-dev --optimize-autoloader --working-dir=/var/www/html \
    && chown -R www-data:www-data storage bootstrap/cache

EXPOSE 80

CMD ["/start.sh"]
