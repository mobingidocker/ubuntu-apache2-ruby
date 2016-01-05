#!/bin/bash

apt-get update
apt-get install -y supervisor git zlib1g-dev libmysqlclient-dev libpq-dev
mkdir -p /var/log/supervisor

apt-get install -y openssh-server
mkdir -p /var/run/sshd

apt-get install -y apache2
mkdir -p /var/lock/apache2 /var/run/apache2

apt-get install -y libsqlite3-dev libcurl4-openssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev
apt-get install -y nodejs

wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
tar -xzf ruby-install-0.5.0.tar.gz
pushd ruby-install-0.5.0/ 
	make install
popd
/usr/local/bin/ruby-install --system rbx 2.2.10 -- --disable-install-rdoc
export PATH=$PATH:/usr/local/bin
which ruby

wget https://rubygems.org/rubygems/rubygems-2.5.1.tgz
tar xvzf rubygems-2.5.1.tgz
pushd rubygems-2.5.1 
	ruby setup.rb config
	ruby setup.rb setup
	ruby setup.rb install
popd

gem install passenger 
passenger-install-apache2-module

gem install bundler
