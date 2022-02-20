#!/usr/bin/bash

if [ -d "/var/www" ]; then
    rm -drf /var/www
fi

composer create-project --prefer-dist laravel/laravel /var/www
chown -R www-data.www-data /var/www/storage
chown -R www-data.www-data /var/www/bootstrap/cache

sed -i "s/^APP_NAME=.*/APP_NAME=\"${LARAVEL_APP_NAME-Laravel}\"/g" /var/www/.env
sed -i "s/^APP_ENV=.*/APP_ENV=${LARAVEL_APP_ENV-local}/g" /var/www/.env
sed -i "s/^APP_DEBUG=.*/APP_DEBUG=${LARAVEL_APP_DEBUG-true}/g" /var/www/.env
sed -i "s/^DB_CONNECTION=.*/DB_CONNECTION=${LARAVEL_DB_CONNECTION-mysql}/g" /var/www/.env
sed -i "s/^DB_HOST=.*/DB_HOST=${LARAVEL_DB_HOST-127.0.0.1}/g" /var/www/.env
sed -i "s/^DB_PORT=.*/DB_PORT=${LARAVEL_DB_PORT-3306}/g" /var/www/.env
sed -i "s/^DB_DATABASE=.*/DB_DATABASE=${LARAVEL_DB_DATABASE-laravel}/g" /var/www/.env
sed -i "s/^DB_USERNAME=.*/DB_USERNAME=${LARAVEL_DB_USERNAME-root}/g" /var/www/.env
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=\"${LARAVEL_DB_PASSWORD-}\"/g" /var/www/.env

rm -f /var/tmp/setup_laravel.sh