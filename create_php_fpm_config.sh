#!/usr/bin/bash

# Clean previous config
sudo rm -f $PAAS_APP_CONFIG_DIR/$APPLICATION_ID.conf

# Create new config
curl -fsSL https://raw.githubusercontent.com/MAAF72/nomad-config/php-fpm-config/php-fpm/pool_sub.conf -o pool_sub.conf

sed -i "s!||FPM_PM||!${FPM_PM-ondemand}!g" pool_sub.conf
sed -i "s!||FPM_MAX_CHILDREN||!${FPM_MAX_REQUEST-5}!g" pool_sub.conf
sed -i "s!||FPM_MAX_REQUEST||!${FPM_MAX_REQUEST-300}!g" pool_sub.conf
sed -i "s!||FPM_START_SERVERS||!${FPM_START_SERVERS-2}!g" pool_sub.conf
sed -i "s!||FPM_MIN_SPARE_SERVERS||!${FPM_MIN_SPARE_SERVERS-1}!g" pool_sub.conf
sed -i "s!||FPM_MAX_SPARE_SERVERS||!${FPM_MAX_SPARE_SERVERS-3}!g" pool_sub.conf

DEFAULT_PHP_DISABLE_FUNCTIONS="exec,passthru,shell_exec,system"

sed -i "s!||PHP_DISABLE_FUNCTIONS||!${PHP_DISABLE_FUNCTIONS:-$DEFAULT_PHP_DISABLE_FUNCTIONS}!g" pool_sub.conf
sed -i "s!||PHP_MAX_EXECUTION_TIME||!${PHP_MAX_EXECUTION_TIME-30}!g" pool_sub.conf
sed -i "s!||PHP_MAX_INPUT_TIME||!${PHP_MAX_INPUT_TIME-60}!g" pool_sub.conf
sed -i "s!||PHP_MAX_INPUT_VARS||!${PHP_MAX_INPUT_VARS-1000}!g" pool_sub.conf
sed -i "s!||PHP_MAX_MEMORY_LIMIT||!${PHP_MAX_INPUT_VARS-256}!g" pool_sub.conf
sed -i "s!||PHP_POST_MAX_SIZE||!${PHP_POST_MAX_SIZE-256}!g" pool_sub.conf
sed -i "s!||PHP_UPLOAD_MAX_FILESIZE||!${PHP_UPLOAD_MAX_FILESIZE-256}!g" pool_sub.conf
sed -i "s!||PHP_SESSION_GC_MAXLIFETIME||!${PHP_SESSION_GC_MAXLIFETIME-1440}!g" pool_sub.conf

sed -i "s!||PHP_ALLOW_URL_FOPEN||!${PHP_ALLOW_URL_FOPEN-on}!g" pool_sub.conf

sudo mkdir -p $PAAS_APP_CONFIG_DIR

sudo cp pool_sub.conf $PAAS_APP_CONFIG_DIR/$APPLICATION_ID.conf