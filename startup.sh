#!/bin/bash

echo "Install Ruby 2.1.0"
rbenv install 2.1.0
rbenv global 2.1.0
 
echo "Ruby Rehash"
rbenv rehash

echo "Create Rails Directory"
mkdir -p /srv/rails
cp -r /srv/code /srv/rails/app
chown -R www-data:www-data /srv/rails/app/public
cd /srv/rails/app
mkdir -p tmp
chown -R www-data:www-data /srv/rails/app/tmp
chmod -R 777 /srv/rails/app/tmp

echo "Prepare logging directory"
rm -rf /srv/rails/app/log
mkdir -p /var/log/rails
ln -s /var/log/rails/ /srv/rails/app/log

echo "Prepare production log"
touch log/production.log
chmod 666 log/production.log
chown -R www-data:www-data /srv/rails/app/log/

echo "Running bundler..."
bundle install 2>&1 >> /var/log/bundler.log

echo "Migrate database"
bundle exec rake db:migrate RAILS_ENV="production" 2>&1 >> /var/log/migration.log
/usr/bin/supervisord
