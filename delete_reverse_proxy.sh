#!/usr/bin/bash

CFG_NAME=rp_${APPLICATION_ID--}_${WEB_APP_DOMAIN--}

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE
fi

if test -f "$CB_CFG_FILE"; then
    sudo certbot delete --cert-name $WEB_APP_DOMAIN
fi

if test -f "/etc/nginx/sites-enabled/default"; then
    sudo rm /etc/nginx/sites-enabled/default
fi

if test -f "/etc/nginx/sites-available/default"; then
    sudo rm /etc/nginx/sites-available/default
fi

if test -f "/etc/nginx/sites-enabled/$CFG_NAME"; then
    sudo rm /etc/nginx/sites-enabled/$CFG_NAME
fi

if test -f "/etc/nginx/sites-available/$CFG_NAME"; then
    sudo rm /etc/nginx/sites-available/$CFG_NAME
fi

sudo nginx -t && sudo nginx -s reload