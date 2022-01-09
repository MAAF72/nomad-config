#!/usr/bin/bash

composer create-project --prefer-dist laravel/laravel /var/www/
chown -R www-data.www-data /var/www/storage
chown -R www-data.www-data /var/www//bootstrap/cache