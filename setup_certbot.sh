#!/usr/bin/bash

CERTBOT_NAME=cb_${APPLICATION_ID--}_${WEB_APP_DOMAIN--}
sudo certbot --certbot-name $CERTBOT_NAME --nginx --non-interactive --agree-tos -m $CERTBOT_EMAIL -d $WEB_APP_DOMAIN

sudo nginx -t && sudo nginx -s reload