#!/bin/bash

apt-get update
apt-get install -y supervisor git zlib1g-dev libmysqlclient-dev libpq-dev
mkdir -p /var/log/supervisor

apt-get install -y openssh-server
mkdir -p /var/run/sshd

apt-get install -y apache2
mkdir -p /var/lock/apache2 /var/run/apache2

apt-get install -y ruby rails libapache2-mod-passenger libsqlite3-dev
apt-get install -y nodejs

#Install rbenv
git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv

rbenv install 2.1.0

gem install bundler

rbenv global 2.1.0
gem install passenger 
passenger-install-apache2-module

# Add rbenv to the path:
echo '# rbenv setup' > /etc/profile.d/rbenv.sh
echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
 
chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh
 
# Install ruby-build:
pushd /tmp
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  ./install.sh
popd
 