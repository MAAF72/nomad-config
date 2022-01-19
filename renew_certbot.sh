#!/usr/bin/bash

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

# Asumsi jika sudah terinstall certbot, pasti manual renew
if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE

    sudo certbot certonly --nginx --non-interactive -d $WEB_APP_DOMAIN --force-renewal

    if test -f "$CB_CFG_FILE"; then
        sudo mv $CB_CFG_FILE $CB_CFG_FILE.disabled
    fi
else
    # Install jika belum terinstall, set manual renew
    sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN

    if test -f "$CB_CFG_FILE"; then
        sudo mv $CB_CFG_FILE $CB_CFG_FILE.disabled
    fi
fi