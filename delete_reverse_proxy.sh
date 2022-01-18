#!/usr/bin/bash

CFG_NAME=rp_${APPLICATION_ID--}_${WEB_APP_DOMAIN--}

crontab -l
# delete cron
# delete certificate (?)

if test -f "/etc/nginx/sites-enabled/default"; then
    sudo rm /etc/nginx/sites-enabled/default
fi

if test -f "/etc/nginx/sites-available/default"; then
    sudo rm /etc/nginx/sites-available/default
fi

if test -f "/etc/nginx/sites-enabled/$CFG_NAME"; then
    sudo rm /etc/nginx/sites-enabled/$CFG_NAME
fi

if test -f "/etc/nginx/sites-available/$CFG_NAME"; then
    sudo rm /etc/nginx/sites-available/$CFG_NAME
fi

sudo nginx -t
sudo nginx -s reload