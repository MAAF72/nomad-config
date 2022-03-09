#!/usr/bin/bash

# Clean previous socket
sudo rm -f $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf
sudo rm -f $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf.disabled

# Build new socket
curl -fsSL https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/php-fpm/pool.conf -o pool.conf

sed -i "s!||APPLICATION_ID||!$APPLICATION_ID!g" pool.conf
sed -i "s!||APPLICATION_CURR_PHP_VERSION||!$APPLICATION_CURR_PHP_VERSION!g" pool.conf

sudo mkdir -p $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION

# curl -fsSL https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/create_php_fpm_config.sh -o create_php_fpm_config.sh
# chmod +x $TMP_DIR/create_php_fpm_config.sh
# ./create_php_fpm_config.sh

# echo "include = $PAAS_APP_CONFIG_DIR/$APPLICATION_ID.conf" | tee -a pool.conf

sudo cp pool.conf $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf.disabled