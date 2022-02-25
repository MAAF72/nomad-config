#!/usr/bin/bash

mkdir -p $FM_DIR

curl -fksSL https://raw.githubusercontent.com/MAAF72/nomad-config/master/file-manager.zip -o $FM_DIR/file-manager.zip
unzip $FM_DIR/file-manager.zip

# Do sed for admin creds
START="# START: FILE_MANAGER_ADMIN_CREDENTIAL #"
END="# END: FILE_MANAGER_ADMIN_CREDENTIAL #"
FM_ADMIN_CREDENTIAL="    '$FM_ADMIN_USERNAME' => password_hash('$FM_ADMIN_USERNAME', PASSWORD_DEFAULT)"

sudo csplit $FILE_MANAGER_DIR/index.php '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
(cat xx00; echo "$FM_ADMIN_CREDENTIAL"; cat xx02) | sudo tee $FM_DIR/index.php

rm -f xx00 xx01 xx02
rm -f $FM_DIR/file-manager.zip

if [ -d "$FM_DIR" ]; then
    sudo chown -R www-data:www-data $FM_DIR
fi