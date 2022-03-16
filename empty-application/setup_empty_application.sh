#!/usr/bin/bash

mkdir -p $APPLICATION_DIR/public

curl -fsSL ${STATIC_URL}/html/paas-landing.html -o $APPLICATION_DIR/public/index.html