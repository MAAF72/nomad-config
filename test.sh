#!/usr/bin/bash

# sudo ls -l

# ls_rc=$?

# echo $ls_rc

# python3 create-ssl-log.py --endpoint http://3025-103-120-170-14.ngrok.io/v1/ssl-logs --domain-id 8046b2ff-8d35-45c2-8aa1-b9517e9127e4 --exit-code $ls_rc


# export ENABLE_WWW=true
# export WEB_APP_DOMAIN=a

# if ( test "${ENABLE_WWW-false}" = true ) && ( test -n "${WEB_APP_DOMAIN-}" ); then
#     echo "yeah"
# else
#     echo "nah"
# fi

# =======================================================================================
# export WEB_APP_DOMAIN=fatih.com
# export ENABLE_WWW=true

# DOMAIN_LIST=$WEB_APP_DOMAIN
# if test "${ENABLE_WWW-false}" = true; then
#     DOMAIN_LIST=$DOMAIN_LIST,www.$DOMAIN_LIST
# fi

# echo $DOMAIN_LIST
# =================================================================================

# =======================================================
# curl "https://raw.githubusercontent.com/MAAF72/nomad-config/master/custom-wp-config.php" -o custom-wp-config.php
# csplit wp-config-sample.php '/Add any custom values between this line and the "stop editing" line./+1' "/That's all, stop editing! Happy publishing./-1"
# cat xx00 custom-wp-config.php xx02 > wp-config-sample-2.php
# rm xx00 xx01 xx02 custom-wp-config.php
# ======================================================

# ======================================================
# sed -i "s!||ENABLE_PROXY_REDIRECT||!#!g" reverse_proxy
# ======================================================

# ======================================================
if ! test -f "test.php"; then
    echo "jaja"
else
    echo "jiji"
fi
# ======================================================