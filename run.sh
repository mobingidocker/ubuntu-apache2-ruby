#!/bin/bash

mkdir -p /srv/rails
cp -r /srv/code /srv/rails/app
chown -R www-data:www-data /srv/rails/app/public
chown -R www-data:www-data /srv/rails/app/tmp
chmod -R 777 /srv/rails/app/tmp
cd /srv/rails/app
bundle install
/usr/bin/supervisord
