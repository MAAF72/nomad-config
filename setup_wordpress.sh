#!/usr/bin/bash

WORDPRESS_DIR=$APPLICATION_DIR/www/public

cd $WORDPRESS_DIR

mkdir -p wordpress_tmp
cd wordpress_tmp

curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
touch wordpress/.htaccess
cp wordpress/wp-config-sample.php wordpress/wp-config.php

# Configure salts
curl "https://api.wordpress.org/secret-key/1.1/salt/" -o salts
csplit wordpress/wp-config.php '/AUTH_KEY/' '/NONCE_SALT/+1'
cat xx00 salts xx02 > wordpress/wp-config.php
rm salts xx00 xx01 xx02

# Configure db using env
sed -i "s/localhost/${WORDPRESS_DB_HOST-localhost}/g" wordpress/wp-config.php
sed -i "s/database_name_here/${WORDPRESS_DB_NAME-db}/g" wordpress/wp-config.php
sed -i "s/username_here/${WORDPRESS_DB_USER-root}/g" wordpress/wp-config.php
sed -i "s/password_here/${WORDPRESS_DB_PASSWORD-}/g" wordpress/wp-config.php

mkdir -p wordpress/wp-content/upgrade

cp -a wordpress/. $WORDPRESS_DIR
rm -rf wordpress_tmp
chown -R www-data:www-data $WORDPRESS_DIR
find $WORDPRESS_DIR -type d -exec chmod 750 {} \;
find $WORDPRESS_DIR -type f -exec chmod 640 {} \;