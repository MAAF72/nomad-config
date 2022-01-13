#!/usr/bin/bash
id
id nomad
sudo ufw allow $WEB_APP_PORT/tcp
echo "1"
curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/reverse_proxy
echo "2"
sed -i "s!||WEB_APP_PORT||!$WEB_APP_PORT!g" reverse_proxy
sed -i "s!||WEB_APP_DOMAIN||!${WEB_APP_DOMAIN-_}!g" reverse_proxy
sed -i "s!||PROXY_ADDRESS||!http://$PROXY_ADDRESS:$PROXY_PORT!g" reverse_proxy
echo "3"

if test -f "/etc/nginx/sites-enabled/default"; then
    sudo rm /etc/nginx/sites-enabled/default
fi
echo "4"
if test -f "/etc/nginx/sites-available/default"; then
    sudo rm /etc/nginx/sites-available/default
fi
echo "5"
sudo cp reverse_proxy /etc/nginx/sites-available/reverse_proxy_$PROXY_ADDRESS:$PROXY_PORT:$WEB_APP_DOMAIN
echo "6"
sudo ln -s /etc/nginx/sites-available/reverse_proxy_$PROXY_ADDRESS:$PROXY_PORT:$WEB_APP_DOMAIN /etc/nginx/sites-enabled
echo "7"
rm reverse_proxy
sudo nginx -s reload
echo "8"