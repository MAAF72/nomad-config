#!/usr/bin/bash

INSTALLATION_DIR=/var/www/laravel

mkdir -p $INSTALLATION_DIR
cd $INSTALLATION_DIR

composer create-project --prefer-dist laravel/laravel $INSTALLATION_DIR
chown -R www-data.www-data /var/www/storage
chown -R www-data.www-data /var/www/bootstrap/cache

mv . /var/www

cd $HOME
rm -drf $INSTALLATION_DIR
rm -drf /var/tmp