#!/usr/bin/bash

if ( test "${WEB_SERVER-}" = "NGINX" ); then
    curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/setup_nginx_web_application.sh
    chmod +x setup_nginx_web_application.sh
    ./setup_nginx_web_application.sh
elif ( test "${WEB_SERVER-}" = "APACHE" ); then
    curl --silent --remote-name https://raw.githubusercontent.com/MAAF72/nomad-config/master/setup_apache_web_application.sh
    chmod +x setup_apache_web_application.sh
    ./setup_apache_web_application.sh
else
    echo "WEB SERVER : ${WEB_SERVER-} , IS NOT SUPPORTED!"
fi