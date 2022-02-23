#!/usr/bin/bash

if ( test "${WEB_SERVER-}" = "NGINX" ); then
    START="# START: CONFIG_NGINX_PHP_${APPLICATION_ID-DEFAULT} #"
    END="# END: CONFIG_NGINX_PHP_${APPLICATION_ID-DEFAULT} #"
    PHP_HANDLER="fastcgi_pass     unix:/var/run/php/php${APPLICATION_PHP_VERSION-7.4}-fpm.sock;"

    sudo csplit $WEB_SERVER_DEFAULT_CONFIG '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
    sed -i 's!fastcgi_pass\s*.*;!'"$PHP_HANDLER"'!g' xx01
    cat xx00 xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG
    rm -f xx00 xx01 xx02
elif ( test "${WEB_SERVER-}" = "APACHE" ); then
    START="# START: CONFIG_APACHE_PHP_${APPLICATION_ID-DEFAULT} #"
    END="# END: CONFIG_APACHE_PHP_${APPLICATION_ID-DEFAULT} #"
    PHP_HANDLER='SetHandler "proxy:unix:/var/run/php/php'"${APPLICATION_PHP_VERSION-7.4}"'-fpm.sock|fcgi://localhost"'

    sudo csplit $WEB_SERVER_DEFAULT_CONFIG '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
    sed -i 's!SetHandler\s*".*"!'"$PHP_HANDLER"'!g' xx01
    cat xx00 xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG
    rm -f xx00 xx01 xx02
else
    echo "WEB SERVER : ${WEB_SERVER-} , IS NOT SUPPORTED!"
fi