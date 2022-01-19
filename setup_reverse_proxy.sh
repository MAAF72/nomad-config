#!/usr/bin/bash

DEFAULT_CFG_NAME=rp_${APPLICATION_ID--}_-
CFG_NAME=rp_${APPLICATION_ID--}_${WEB_APP_DOMAIN--}

sudo ufw allow ${WEB_APP_PORT-80}/tcp
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/reverse_proxy
sed -i "s!||WEB_APP_PORT||!${WEB_APP_PORT-80}!g" reverse_proxy
sed -i "s!||WEB_APP_DOMAIN||!${WEB_APP_DOMAIN-_}!g" reverse_proxy
sed -i "s!||PROXY_ADDRESS_PORT||!http://${PROXY_ADDRESS-127.0.0.1}:${PROXY_PORT-80}!g" reverse_proxy

if test -f "/etc/nginx/sites-enabled/default"; then
    sudo rm /etc/nginx/sites-enabled/default
fi

if test -f "/etc/nginx/sites-available/default"; then
    sudo rm /etc/nginx/sites-available/default
fi

if test -f "/etc/nginx/sites-enabled/$DEFAULT_CFG_NAME"; then
    sudo rm /etc/nginx/sites-enabled/$DEFAULT_CFG_NAME
fi

if test -f "/etc/nginx/sites-available/$DEFAULT_CFG_NAME"; then
    sudo rm /etc/nginx/sites-available/$DEFAULT_CFG_NAME
fi

if test -f "/etc/nginx/sites-enabled/$CFG_NAME"; then
    sudo rm /etc/nginx/sites-enabled/$CFG_NAME
fi

if test -f "/etc/nginx/sites-available/$CFG_NAME"; then
    sudo rm /etc/nginx/sites-available/$CFG_NAME
fi

sudo cp reverse_proxy /etc/nginx/sites-available/$CFG_NAME
sudo ln -s /etc/nginx/sites-available/$CFG_NAME /etc/nginx/sites-enabled/
rm reverse_proxy
sudo nginx -t && sudo nginx -s reload