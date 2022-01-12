#!/usr/bin/bash

sudo ufw allow $WEB_APP_PORT/tcp
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/reverse_proxy
sed -i "s!||WEB_APP_PORT||!$WEB_APP_PORT!g" reverse_proxy
sed -i "s!||PROXY_ADDRESS||!http://$PROXY_ADDRESS:$PROXY_PORT!g" reverse_proxy
sudo cp reverse_proxy /etc/nginx/sites-available/reverse_proxy_$PROXY_ADDRESS:$PROXY_PORT
sudo ln -s /etc/nginx/sites-available/reverse_proxy_$PROXY_ADDRESS:$PROXY_PORT /etc/nginx/sites-enabled
rm reverse_proxy
sudo nginx -s reload