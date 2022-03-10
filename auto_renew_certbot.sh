#!/usr/bin/bash

CB_CFG_FILE=/etc/letsencrypt/renewal/$WEB_APP_DOMAIN.conf

curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/create-ssl-log.py

DOMAIN_LIST=$WEB_APP_DOMAIN
if test "${ENABLE_WWW-false}" = true; then
    DOMAIN_LIST=$DOMAIN_LIST,www.$DOMAIN_LIST
fiDOMAIN_LIST=$WEB_APP_DOMAIN
if test "${ENABLE_WWW-false}" = true; then
    DOMAIN_LIST=$DOMAIN_LIST,www.$DOMAIN_LIST
fi

# Asumsi jika sudah terinstall certbot, pasti masih manual renew
if test -f "$CB_CFG_FILE.disabled"; then
    sudo mv $CB_CFG_FILE.disabled $CB_CFG_FILE

    sudo certbot certonly --force-renewal --nginx --non-interactive -d $DOMAIN_LIST 
    rc=$?
    echo "creating ssl log"
    python3 create-ssl-log.py --endpoint $CREATE_SSL_LOG_ENDPOINT --domain-id $DOMAIN_ID --exit-code $rc
else
    # Install jika belum terinstall, set auto renew
    sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $DOMAIN_LIST
    rc=$?
    echo "creating ssl log"
    python3 create-ssl-log.py --endpoint $CREATE_SSL_LOG_ENDPOINT --domain-id $DOMAIN_ID --exit-code $rc
fi

rm -f create-ssl-log.py