#!/usr/bin/bash


mkdir -p $WEB_SERVER_DIR/sites-available

# Prevent default file created as folder
if test -d "$WEB_SERVER_DIR/sites-available/default"; then
    sudo rm -drf $WEB_SERVER_DIR/sites-available/default
fi

# Installing default apache web config for container
if ! test -f "$WEB_SERVER_DIR/sites-available/default"; then
    curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/apache_web_config
    sudo cp apache_web_config $WEB_SERVER_DIR/sites-available/default
fi

# Installing default apache web config for ingress
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/setup_reverse_proxy.sh

chmod +x setup_reverse_proxy.sh
./setup_reverse_proxy.sh

# Remove left over files
rm apache_web_config
rm setup_reverse_proxy.sh