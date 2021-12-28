#!/usr/bin/bash

LARAVEL_DIR=$APPLICATION_DIR/www/${APPLICATION_ADDRESS-public}

rm -rfv $APPLICATION_DIR/www/{*,.*}
composer.phar create-project --prefer-dist laravel/laravel $LARAVEL_DIR
chown -R www-data.www-data $LARAVEL_DIR/storage
chown -R www-data.www-data $LARAVEL_DIR/bootstrap/cache