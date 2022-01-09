#!/usr/bin/bash

if test -d "/var/www/public"; then
    rm -rf /var/www/public
fi
composer create-project --prefer-dist laravel/laravel /var/www/
chown -R www-data.www-data /var/www/storage
chown -R www-data.www-data /var/www//bootstrap/cache