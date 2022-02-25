#!/usr/bin/bash

mkdir -p $FILE_MANAGER_DIR

curl -fksSL https://raw.githubusercontent.com/MAAF72/nomad-config/master/file-manager.zip -o $FILE_MANAGER_DIR/file-manager.zip
unzip $FILE_MANAGER_DIR/file-manager.zip

# Do sed for admin creds
START="# START: FILE_MANAGER_ADMIN_CREDENTIAL #"
END="# END: FILE_MANAGER_ADMIN_CREDENTIAL #"
ADMIN_CREDENTIAL="    '$ADMIN_USERNAME' => password_hash('$ADMIN_PASSWORD', PASSWORD_DEFAULT)"

sudo csplit $FILE_MANAGER_DIR/index.php '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
(cat xx00; echo "$ADMIN_CREDENTIAL"; cat xx02) | sudo tee $FILE_MANAGER_DIR/index.php
rm -f xx00 xx01 xx02

rm -f $FILE_MANAGER_DIR/file-manager.zip

if [ -d "$FILE_MANAGER_DIR" ]; then
    sudo chown -R www-data:www-data $FILE_MANAGER_DIR
fi