#!/usr/bin/bash

mkdir -p $APPLICATION_DIR/public

curl -fsSL https://raw.githubusercontent.com/MAAF72/nomad-config/master/paas-landing.html -o $APPLICATION_DIR/public/index.html