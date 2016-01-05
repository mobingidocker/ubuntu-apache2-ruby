FROM ubuntu:14.04
MAINTAINER david.siaw@mobingi.com

ADD provision.sh /provision.sh

RUN bash /provision.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config /config
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY sudoers /etc/sudoers

ADD run.sh /run.sh
ADD startup.sh /startup.sh

RUN chmod 755 /*.sh

EXPOSE 22 80
CMD ["/run.sh"]
