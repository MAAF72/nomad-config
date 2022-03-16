#!/usr/bin/bash

# Clean previous socket
sudo rm -f $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf
sudo rm -f $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf.disabled

# Build new socket
curl -fsSL ${STATIC_URL}/php-fpm/pool.conf -o pool.conf

sed -i "s!||APPLICATION_ID||!$APPLICATION_ID!g" pool.conf
sed -i "s!||APPLICATION_CURR_PHP_VERSION||!$APPLICATION_CURR_PHP_VERSION!g" pool.conf

sudo mkdir -p $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION

sudo cp pool.conf $PAAS_PHP_CONFIG_DIR/$APPLICATION_CURR_PHP_VERSION/$APPLICATION_ID.conf.disabled