#!/usr/bin/bash

CONFIG_FILE=/etc/letsencrypt/live/$WEB_APP_DOMAIN.conf

sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN

if test -f "$CONFIG_FILE"; then
    sudo mv $CONFIG_FILE $CONFIG_FILE.disabled
fi