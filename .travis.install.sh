#!/bin/sh
set -x
if [ "$TRAVIS_PHP_VERSION" = 'hhvm' ] || [ "$TRAVIS_PHP_VERSION" = 'hhvm-nightly' ] ; then
    curl -sS https://getcomposer.org/installer > composer-installer.php
    hhvm composer-installer.php
    hhvm -v ResourceLimit.SocketDefaultTimeout=30 -v Http.SlowQueryThreshold=30000 composer.phar update --prefer-source
elif [ "$TRAVIS_PHP_VERSION" = '5.3.3' ] ; then
    ## Can't update on php 5.3.3 as openssl is now required in the latest build and not available on php5.3.3 at travis
    composer update --prefer-source --no-dev -g disable-tls true
    composer dump-autoload
else
    composer self-update
    composer update --prefer-source
fi
