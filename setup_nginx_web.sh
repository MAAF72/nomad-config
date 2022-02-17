#!/usr/bin/bash
WEB_SERVER_DIR=/home/workspace/web-server/

# Installing default nginx web config for container
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/nginx_web_config

mkdir -p $WEB_SERVER_DIR/sites-available/default
cp nginx_default_web_config $WEB_SERVER_DIR/sites-available/default

# Installing default nginx web config for ingress
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/setup_reverse_proxy.sh

chmod +x setup_reverse_proxy.sh
./setup_reverse_proxy.sh

# Remove left over files
rm nginx_default_web_config
rm setup_reverse_proxy.sh