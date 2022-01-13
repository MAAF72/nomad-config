#!/usr/bin/bash

id
id nomad
ufw allow $WEB_APP_PORT/tcp
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/reverse_proxy
sed -i "s!||WEB_APP_PORT||!$WEB_APP_PORT!g" reverse_proxy
sed -i "s!||WEB_APP_DOMAIN||!${WEB_APP_DOMAIN-_}!g" reverse_proxy
sed -i "s!||PROXY_ADDRESS||!http://$PROXY_ADDRESS:$PROXY_PORT!g" reverse_proxy

if test -f "/etc/nginx/sites-enabled/default"; then
    rm /etc/nginx/sites-enabled/default
fi

if test -f "/etc/nginx/sites-available/default"; then
    rm /etc/nginx/sites-available/default
fi

cp reverse_proxy /etc/nginx/sites-available/reverse_proxy_$PROXY_ADDRESS:$PROXY_PORT:$WEB_APP_DOMAIN
ln -s /etc/nginx/sites-available/reverse_proxy_$PROXY_ADDRESS:$PROXY_PORT:$WEB_APP_DOMAIN /etc/nginx/sites-enabled
rm reverse_proxy
nginx -s reload