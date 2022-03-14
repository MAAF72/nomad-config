#!/usr/bin/bash

if [ -d "$FM_DIR" ]; then
    sudo rm -drf $FM_DIR
fi

mkdir -p $FM_DIR

cd $FM_DIR

curl -fksSL https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/file-manager/index.php -o index.php
curl -fksSL https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/file-manager/translation.json -o translation.json

# Do sed for admin creds
START="# START: FILE_MANAGER_ADMIN_CREDENTIAL #"
END="# END: FILE_MANAGER_ADMIN_CREDENTIAL #"
FM_ADMIN_CREDENTIAL="    '${FM_ADMIN_USERNAME-admin}' => password_hash('${FM_ADMIN_PASSWORD-admin}', PASSWORD_DEFAULT)"

sudo csplit index.php '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
(cat xx00; echo "$FM_ADMIN_CREDENTIAL"; cat xx02) | sudo tee index.php

rm -f xx00 xx01 xx02

# if [ -d "$FM_DIR" ]; then
#     sudo chown -R www-data:www-data $FM_DIR
# fi