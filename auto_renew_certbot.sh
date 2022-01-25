#!/usr/bin/bash

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/create-ssl-log.py

# Asumsi jika sudah terinstall certbot, pasti masih manual renew
if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE

    sudo certbot certonly --nginx --non-interactive -d $WEB_APP_DOMAIN --force-renewal
    rc=$?
    echo "creating ssl log"
    python3 create-ssl-log.py --endpoint $CREATE_SSL_LOG_ENDPOINT --domain-id $DOMAIN_ID --exit-code $rc
else
    # Install jika belum terinstall, set auto renew
    sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN
    rc=$?
    echo "creating ssl log"
    python3 create-ssl-log.py --endpoint $CREATE_SSL_LOG_ENDPOINT --domain-id $DOMAIN_ID --exit-code $rc
fi

rm -f create-ssl-log.py