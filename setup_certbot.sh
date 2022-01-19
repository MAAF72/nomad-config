#!/usr/bin/bash

sudo certbot --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN

sudo nginx -t && sudo nginx -s reload

crontab -l

if test -f "/etc/cron.d/certbot"; then
    sudo cat /etc/cron.d/certbot
fi