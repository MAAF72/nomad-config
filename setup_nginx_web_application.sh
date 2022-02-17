#!/usr/bin/bash
WEB_SERVER_DEFAULT_CONFIG=/home/workspace/web-server/sites-available/default

# Installing default nginx web config for ingress
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/nginx_web_config_application

# Do sed
sed -i "s!||APPLICATION_ID||!${APPLICATION_ID-}!g" nginx_web_config_application
sed -i "s!||APPLICATION_NAME||!${APPLICATION_NAME-}!g" nginx_web_config_application
sed -i "s!||APPLICATION_MAIN_DIR||!${APPLICATION_MAIN_DIR-}!g" nginx_web_config_application

# Rewrite web server config
csplit $WEB_SERVER_DEFAULT_CONFIG '/# START: CONFIG_NGINX #/+2' "/# END: CONFIG_NGINX #/-2"
cat xx00 nginx_web_config_application xx01 xx02 > $WEB_SERVER_DEFAULT_CONFIG

-----> NAH, INI RESTART NGINXNYA GIMANA BGSD???

# Installing default nginx web config for ingress
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/setup_reverse_proxy.sh

chmod +x setup_reverse_proxy.sh
./setup_reverse_proxy.sh

# Remove left over files
rm xx00 xx01 xx02 
rm nginx_web_config_application 
rm setup_reverse_proxy.sh