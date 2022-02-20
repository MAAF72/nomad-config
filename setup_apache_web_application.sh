#!/usr/bin/bash

# Installing default apache web config for ingress
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/apache_web_config_application

# Do sed
sed -i "s!||APPLICATION_ID||!${APPLICATION_ID-}!g" apache_web_config_application
sed -i "s!||APPLICATION_NAME||!${APPLICATION_NAME-}!g" apache_web_config_application
sed -i "s!||APPLICATION_MAIN_DIR||!${APPLICATION_MAIN_DIR-}!g" apache_web_config_application

# Rewrite web server config
csplit $WEB_SERVER_DEFAULT_CONFIG '/# START: CONFIG_APACHE #/+1' "/# END: CONFIG_APACHE #/-1"
cat xx00 apache_web_config_application xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG

# Restart apache in container

# Remove left over files
rm xx00 xx01 xx02 
rm apache_web_config_application