#!/usr/bin/bash

LARAVEL_DIR=/var/www/${LARAVEL_DOMAIN_NAME-}

mkdir -p $LARAVEL_DIR
composer create-project --prefer-dist laravel/laravel $LARAVEL_DIR
chown -R www-data.www-data $LARAVEL_DIR/storage
chown -R www-data.www-data $LARAVEL_DIR/bootstrap/cache