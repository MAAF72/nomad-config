#!/usr/bin/bash

rm -rfv $APPLICATION_DIR/{*,.*}
mkdir -p $APPLICATION_DIR/letsencrypt
mkdir -p $APPLICATION_DIR/www
mkdir -p $APPLICATION_DIR/nginx/sites-enabled