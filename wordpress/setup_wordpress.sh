#!/usr/bin/bash

mkdir -p $APPLICATION_DIR
cd $APPLICATION_DIR

mkdir -p public

mkdir -p wordpress_tmp
cd wordpress_tmp

curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php

# Configure htaccess
curl -fsSL ${STATIC_URL}/wordpress/wordpress.htaccess -o wordpress/.htaccess
sed -i "s!||APPLICATION_NAME||!${APPLICATION_NAME-}!g" wordpress/.htaccess

# Configure salts
curl -fsSL https://api.wordpress.org/secret-key/1.1/salt/ -o salts
csplit wordpress/wp-config.php '/AUTH_KEY/' '/NONCE_SALT/+1'
cat xx00 salts xx02 | tee wordpress/wp-config.php
rm -f salts xx00 xx01 xx02

# Configure custom wp-config
curl -fsSL ${STATIC_URL}/wordpress/custom-wp-config.php -o custom-wp-config.php
csplit wordpress/wp-config.php '/Add any custom values between this line and the "stop editing" line./+1' "/That's all, stop editing! Happy publishing./-1"
cat xx00 custom-wp-config.php xx02 | tee wordpress/wp-config.php
rm -f xx00 xx01 xx02 custom-wp-config.php

# Configure db using env
sed -i "s/localhost/${WORDPRESS_DB_HOST-localhost}/g" wordpress/wp-config.php
sed -i "s/database_name_here/${WORDPRESS_DB_NAME-db}/g" wordpress/wp-config.php
sed -i "s/username_here/${WORDPRESS_DB_USER-root}/g" wordpress/wp-config.php
sed -i "s/password_here/${WORDPRESS_DB_PASSWORD-}/g" wordpress/wp-config.php

mkdir -p wordpress/wp-content/upgrade

cp -a wordpress/. $APPLICATION_DIR/public

cd $APPLICATION_DIR

rm -rf wordpress_tmp