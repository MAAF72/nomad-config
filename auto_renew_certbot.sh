#!/usr/bin/bash

CONFIG_FILE=/etc/letsencrypt/live/$WEB_APP_DOMAIN.conf

if test -f "$CONFIG_FILE.disabled"; then
    sudo mv $CONFIG_FILE.disabled $CONFIG_FILE
fi

sudo certbot certonly --nginx --non-interactive -d $WEB_APP_DOMAIN --force-renewal