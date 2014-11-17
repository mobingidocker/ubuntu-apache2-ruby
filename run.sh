#!/bin/bash

mkdir -p /srv/rails
cp -r /srv/code /srv/rails/app
chown -R www-data:www-data /srv/rails/app/public
chown -R www-data:www-data /srv/rails/app/tmp
chmod -R 777 /srv/rails/app/tmp
cd /srv/rails/app
mkdir -p tmp
touch log/production.log
chmod 666 log/production.log
rake db:migrate RAILS_ENV="production" 
bundle install
/usr/bin/supervisord
