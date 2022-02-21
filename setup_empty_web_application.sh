#!/usr/bin/bash
mkdir -p $APPLICATION_DIR
cd $APPLICATION_DIR

mkdir -p public

cd public

curl -fsSL https://raw.githubusercontent.com/MAAF72/nomad-config/master/paas-landing.html -o index.html

rm -f /var/tmp/setup_empty_web_appliaction.sh