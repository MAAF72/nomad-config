#!/usr/bin/bash

if ( test "${WEB_SERVER-}" = "NGINX" ) || ( test "${WEB_SERVER-}" = "APACHE" ); then
    # Create new php-fpm config, override
    curl -fsSL https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/create_php_fpm_config.sh -o create_php_fpm_config.sh
    chmod +x create_php_fpm_config.sh
    ./create_php_fpm_config.sh

    # Activate default php version socket
    CURR_PHP_VERSION_SOCKET_CONFIG=$PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf
    if test -f "$CURR_PHP_VERSION_SOCKET_CONFIG.disabled"; then
        sudo mv $CURR_PHP_VERSION_SOCKET_CONFIG.disabled $CURR_PHP_VERSION_SOCKET_CONFIG
    fi

    # Setup web app host config based on web server type
    if ( test "${WEB_SERVER-}" = "NGINX" ); then
        curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/setup_nginx_web_application.sh
        chmod +x setup_nginx_web_application.sh
        ./setup_nginx_web_application.sh
    elif ( test "${WEB_SERVER-}" = "APACHE" ); then
        curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/setup_apache_web_application.sh
        chmod +x setup_apache_web_application.sh
        ./setup_apache_web_application.sh
    fi

    # Change user & group to www-data
    if [ -d "$APPLICATION_DIR" ]; then
        sudo chown -R www-data:www-data $APPLICATION_DIR
        sudo find $APPLICATION_DIR -type d -exec chmod 750 {} \;
        sudo find $APPLICATION_DIR -type f -exec chmod 640 {} \;
    fi
else
    echo "WEB SERVER : ${WEB_SERVER-} , IS NOT SUPPORTED!"
fi

