#!/usr/bin/bash

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

# Asumsi jika sudah terinstall certbot, pasti masih manual renew
if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE

    sudo certbot certonly --nginx --non-interactive -d $WEB_APP_DOMAIN --force-renewal
else
    # Install jika belum terinstall, set auto renew
    sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN
fi