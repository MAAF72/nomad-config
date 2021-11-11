#!/usr/bin/bash
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
touch /tmp/wordpress/.htaccess
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
mkdir -p /home/www/wordpress/slave.test.paas.proclubstudio.com
cp -a /tmp/wordpress/. /home/www/wordpress/slave.test.paas.proclubstudio.com
rm -rf /tmp/wordpress
chown -R www-data:www-data /home/www/wordpress/slave.test.paas.proclubstudio.com
find /home/www/wordpress/slave.test.paas.proclubstudio.com -type d -exec chmod 750 {} \;
find /home/www/wordpress/slave.test.paas.proclubstudio.com -type f -exec chmod 640 {} \;