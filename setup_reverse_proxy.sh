#!/usr/bin/bash

export

sudo ufw allow ${WEB_APP_PORT-80}/tcp
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/reverse_proxy
sed -i "s!||WEB_APP_PORT||!${WEB_APP_POR-80}!g" reverse_proxy
sed -i "s!||WEB_APP_DOMAIN||!${WEB_APP_DOMAIN-_}!g" reverse_proxy
sed -i "s!||PROXY_ADDRESS_PORT||!http://${PROXY_ADDRESS-127.0.0.1}:${PROXY_PORT-80}!g" reverse_proxy

if test -f "/etc/nginx/sites-enabled/default"; then
    sudo rm /etc/nginx/sites-enabled/default
fi

if test -f "/etc/nginx/sites-available/default"; then
    sudo rm /etc/nginx/sites-available/default
fi

sudo cp reverse_proxy /etc/nginx/sites-available/rp_${APPLICATION_ID--}_${WEB_APP_DOMAIN--}
sudo ln -s /etc/nginx/sites-available/rp_${APPLICATION_ID--}_${WEB_APP_DOMAIN--} /etc/nginx/sites-enabled/
rm reverse_proxy
sudo nginx -s reload