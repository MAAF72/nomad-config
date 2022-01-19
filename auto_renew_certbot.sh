#!/usr/bin/bash

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE
fi

sudo certbot certonly --nginx --non-interactive -d $WEB_APP_DOMAIN --force-renewal