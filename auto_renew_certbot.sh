#!/usr/bin/bash

CERTBOT_NAME=cb_${APPLICATION_ID--}_${WEB_APP_DOMAIN--}
sudo certbot --nginx certonly --non-interactive -d $WEB_APP_DOMAIN --force-renewal

sudo nginx -t && sudo nginx -s reload

crontab -l

if test -f "/etc/cron.d/certbot"; then
    sudo cat /etc/cron.d/certbot
fi