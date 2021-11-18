#!/usr/bin/bash

cd /tmp
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
dbhost=${DEPLOY_ENV-localhost}
dbname=${DEPLOY_ENV-db}
dbuser=${DEPLOY_ENV-root}
dbpass=${DEPLOY_ENV-}

sed -i "s/localhost/$dbhost/g" wp-config.php
sed -i "s/database_name_here/$dbname/g" wp-config.php
sed -i "s/username_here/$dbuser/g" wp-config.php
sed -i "s/password_here/$dbpass/g" wp-config.php

domain=${DOMAIN_NAME-public}
mkdir wordpress/wp-content/upgrade
mkdir -p /home/www/wordpress/$domain
cp -a wordpress/. /home/www/wordpress/$domain
rm -rf wordpress
chown -R www-data:www-data /home/www/wordpress/$domain
find /home/www/wordpress/$domain -type d -exec chmod 750 {} \;
find /home/www/wordpress/$domain -type f -exec chmod 640 {} \;