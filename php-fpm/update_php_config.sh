#!/usr/bin/bash

if ( test "${WEB_SERVER-}" = "NGINX" ) || ( test "${WEB_SERVER-}" = "APACHE" ); then
    curl -fsSL ${STATIC_URL}/php-fpm/create_php_fpm_config.sh -o create_php_fpm_config.sh
    chmod +x create_php_fpm_config.sh
    ./create_php_fpm_config.sh

    if ( test "${WEB_SERVER-}" = "NGINX" ); then
        START="# START: CONFIG_NGINX_CLIENT_MAX_BODY_SIZE_$APPLICATION_ID #"
        END="# END: CONFIG_NGINX_CLIENT_MAX_BODY_SIZE_$APPLICATION_ID #"
        CONFIG_HANDLER="client_max_body_size ${NGINX_CLIENT_MAX_BODY_SIZE}M;"

        sudo csplit $WEB_SERVER_DEFAULT_CONFIG '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
        sed -i 's!client_max_body_size\s*.*;!'"$CONFIG_HANDLER"'!g' xx01
        cat xx00 xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG
        rm -f xx00 xx01 xx02
    elif ( test "${WEB_SERVER-}" = "APACHE" ); then
        START="# START: CONFIG_APACHE_LIMIT_REQUEST_BODY_$APPLICATION_ID #"
        END="# END: CONFIG_APACHE_LIMIT_REQUEST_BODY_$APPLICATION_ID #"
        BYTES_APACHE_LIMIT_REQUEST_BODY=$((APACHE_LIMIT_REQUEST_BODY * 1024 * 1024))
        CONFIG_HANDLER="LimitRequestBody $BYTES_APACHE_LIMIT_REQUEST_BODY"

        sudo csplit $WEB_SERVER_DEFAULT_CONFIG '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
        sed -i 's!LimitRequestBody\s*.*$!'"$CONFIG_HANDLER"'!g' xx01
        cat xx00 xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG
        rm -f xx00 xx01 xx02
    fi
else
    echo "WEB SERVER : ${WEB_SERVER-} , IS NOT SUPPORTED!"
fi