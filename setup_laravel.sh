#!/usr/bin/bash

INSTALLATION_DIR=/var/www/temp-laravel

mkdir -p $INSTALLATION_DIR
cd $INSTALLATION_DIR

composer create-project --prefer-dist laravel/laravel $INSTALLATION_DIR
chown -R www-data.www-data $INSTALLATION_DIR/storage
chown -R www-data.www-data $INSTALLATION_DIR/bootstrap/cache


cd $HOME

cp -a $INSTALLATION_DIR/. /var/www
rm -drf $INSTALLATION_DIR
rm -f /var/tmp/setup_laravel.sh