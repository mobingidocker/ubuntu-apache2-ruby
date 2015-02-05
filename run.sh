#!/bin/bash

mkdir -p /srv/rails
cp -r /srv/code /srv/rails/app
chown -R www-data:www-data /srv/rails/app/public
cd /srv/rails/app
mkdir -p tmp
chown -R www-data:www-data /srv/rails/app/tmp
chmod -R 777 /srv/rails/app/tmp
touch log/production.log
chmod 666 log/production.log
bundle install 2>&1 > /var/log/bundler.log
rake db:migrate RAILS_ENV="production" 2>&1 > /var/log/migration.log
/usr/bin/supervisord
