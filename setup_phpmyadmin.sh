#!/usr/bin/bash

PMA_DIR=/var/www/public/phpmyadmin

if [ -d $PMA_DIR ]; then
    rm -drf $PMA_DIR
fi

mkdir -p $PMA_DIR
composer create-project --no-interaction --prefer-dist phpmyadmin/phpmyadmin /var/www/public/phpmyadmin

if [ ! -f $PMA_DIR/config.inc.php ]; then
    cp $PMA_DIR/config.sample.inc.php $PMA_DIR/config.inc.php
    blowfish_secret=$(tr -dc 'a-zA-Z0-9~!@#$%^*_()+}{?></;.,[]=-' < /dev/urandom | fold -w 32 | head -n 1)
    sed -i "s|\['blowfish_secret'\] = ''|\['blowfish_secret'\] = '${blowfish_secret}'|" $PMA_DIR/config.inc.php

    if test -n "${PROXY_ADDRESS-}"; then
        sed -i "s/localhost/$PROXY_ADDRESS/g" $PMA_DIR/config.inc.php
    fi
fi

rm -f /var/tmp/setup_phpmyadmin.sh