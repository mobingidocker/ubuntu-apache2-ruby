FROM ubuntu:14.04
MAINTAINER david.siaw@mobingi.com

RUN apt-get update
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

RUN apt-get install -y apache2
RUN mkdir -p /var/lock/apache2 /var/run/apache2

RUN apt-get install -y ruby rails libapache2-mod-passenger libsqlite3-dev
RUN apt-get install -y nodejs

RUN a2enmod rewrite
RUN a2enmod passenger

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config /config
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY Gemfile /root/bootstrapgems/Gemfile

ADD run.sh /run.sh
RUN chmod 755 /*.sh

RUN cd /root/bootstrapgems && bundle install

EXPOSE 22 80
CMD ["/run.sh"]
