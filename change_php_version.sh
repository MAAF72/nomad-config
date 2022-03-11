#!/usr/bin/bash

if ( test "${WEB_SERVER-}" = "NGINX" ) || ( test "${WEB_SERVER-}" = "APACHE" ); then
    # Create curr php version socket if not exist
    # Using default config if not provided 
    CURR_PHP_VERSION_SOCKET_CONFIG=$PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf
    if (! test -f "$CURR_PHP_VERSION_SOCKET_CONFIG.disabled") && (! test -f "$CURR_PHP_VERSION_SOCKET_CONFIG"); then
        curl -fsSL https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/create_php_fpm_socket.sh -o create_php_fpm_socket.sh
        chmod +x create_php_fpm_socket.sh
        ./create_php_fpm_socket.sh
    fi

    # Disable prev php version socket if exist
    PREV_PHP_VERSION_SOCKET_CONFIG=$PAAS_PHP_CONFIG_DIR/$APPLICATION_PREV_PHP_VERSION/$APPLICATION_ID.conf
    if test -f "$PREV_PHP_VERSION_SOCKET_CONFIG"; then
        sudo mv $PREV_PHP_VERSION_SOCKET_CONFIG $PREV_PHP_VERSION_SOCKET_CONFIG.disabled
    fi

    # Enable curr php version socket
    if test -f "$CURR_PHP_VERSION_SOCKET_CONFIG.disabled"; then
        sudo mv $CURR_PHP_VERSION_SOCKET_CONFIG.disabled $CURR_PHP_VERSION_SOCKET_CONFIG
    fi

    if ( test "${WEB_SERVER-}" = "NGINX" ); then
        START="# START: CONFIG_NGINX_PHP_${APPLICATION_ID-DEFAULT} #"
        END="# END: CONFIG_NGINX_PHP_${APPLICATION_ID-DEFAULT} #"
        PHP_HANDLER="fastcgi_pass     unix:/var/run/php/${APPLICATION_ID}_${APPLICATION_CURR_PHP_VERSION}.sock;"

        sudo csplit $WEB_SERVER_DEFAULT_CONFIG '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
        sed -i 's!fastcgi_pass\s*.*;!'"$PHP_HANDLER"'!g' xx01
        cat xx00 xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG
        rm -f xx00 xx01 xx02
    elif ( test "${WEB_SERVER-}" = "APACHE" ); then
        START="# START: CONFIG_APACHE_PHP_${APPLICATION_ID-DEFAULT} #"
        END="# END: CONFIG_APACHE_PHP_${APPLICATION_ID-DEFAULT} #"
        PHP_HANDLER='SetHandler "proxy:unix:/var/run/php/php'"${APPLICATION_ID}_${APPLICATION_CURR_PHP_VERSION}"'.sock|fcgi://localhost"'

        sudo csplit $WEB_SERVER_DEFAULT_CONFIG '/'"$START"'/+1' '/'"$END"'/' &>/dev/null
        sed -i 's!SetHandler\s*".*"!'"$PHP_HANDLER"'!g' xx01
        cat xx00 xx01 xx02 | sudo tee $WEB_SERVER_DEFAULT_CONFIG
        rm -f xx00 xx01 xx02
    fi
else
    echo "WEB SERVER : ${WEB_SERVER-} , IS NOT SUPPORTED!"
fi