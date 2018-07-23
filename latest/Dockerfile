FROM mxhero:config
MAINTAINER Leo Marangoni <leonardo.marangoni@inova.net>

ENV INITDB 0
ENV GLOBAL_ADMIN_PASSWD admin
ENV MYSQL_ADMIN_PASSWD root
ENV MYNETWORKS="127.0.0.0/8 10.0.0.0/8 192.168.0.0/16"

VOLUME /var/lib/mysql \
       /var/spool \
       /opt/maildir-mxhero

ADD init.sh /opt/
ADD initdb.sh /opt/
RUN chmod +x /opt/init*

EXPOSE 25:25/tcp
EXPOSE 26:26/tcp
EXPOSE 80:80/tcp

CMD ["/opt/init.sh"]
