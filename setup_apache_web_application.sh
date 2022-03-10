#!/usr/bin/bash

# Installing default apache web config for ingress
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/apache_web_config_application

# Do sed
sed -i "s!||APPLICATION_ID||!${APPLICATION_ID-}!g" apache_web_config_application
sed -i "s!||APPLICATION_NAME||!${APPLICATION_NAME-}!g" apache_web_config_application
sed -i "s!||APPLICATION_MAIN_DIR_CONTAINER||!${APPLICATION_MAIN_DIR_CONTAINER-}!g" apache_web_config_application
sed -i "s!||APPLICATION_CURR_PHP_VERSION||!${APPLICATION_CURR_PHP_VERSION-}!g" apache_web_config_application

# Rewrite web server config
csplit $WEB_SERVER_DEFAULT_CONFIG '/# START: CONFIG_APACHE #/+1' "/# END: CONFIG_APACHE #/-1"
cat xx00 apache_web_config_application xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG

# Restart apache in container

# Remove left over files
rm -f xx00 xx01 xx02 
rm -f apache_web_config_application