#!/usr/bin/bash

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/create-ssl-log.py

if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE
fi

if test -f "$CB_CFG_FILE"; then
    sudo certbot delete --cert-name $WEB_APP_DOMAIN
fi

sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN
rc=$?
echo "creating ssl log"
python3 create-ssl-log.py --endpoint $CREATE_SSL_LOG_ENDPOINT --domain-id $DOMAIN_ID --exit-code $rc

if test -f "$CB_CFG_FILE"; then
    sudo mv $CB_CFG_FILE $CB_CFG_FILE.disabled
fi

rm -f create-ssl-log.py