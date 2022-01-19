#!/usr/bin/bash

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE
fi

if test -f "$CB_CFG_FILE"; then
    sudo certbot delete --cert-name $WEB_APP_DOMAIN
fi

sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN

if test -f "$CB_CFG_FILE"; then
    sudo mv $CB_CFG_FILE $CB_CFG_FILE.disabled
fi