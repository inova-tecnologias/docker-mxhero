FROM mxhero:install
MAINTAINER Leo Marangoni <leonardo.marangoni@inova.net>

RUN apt-get update && apt-get -y install python
ADD systemctl.py /bin/systemctl
RUN chmod +x /bin/systemctl
# CONFIGURE SECURITY LIMITS
RUN grep ^mxhero /etc/security/limits.conf || \
echo -e "mxhero soft nofile 524288\nmxhero soft nofile 524288" >> /etc/security/limits.conf
RUN grep ^root /etc/security/limits.conf || \
echo -e "root soft nofile 524288\nroot soft nofile 524288" >> /etc/security/limits.conf

# CREATE MXHERO USER
RUN id mxhero >/dev/null 2>/dev/null || \
adduser --gecos "" --no-create-home --disabled-password --quiet --shell /bin/bash mxhero

# CONFIGURE MXHERO
RUN mkdir -m 0750 -p /opt/maildir-mxhero \ 
&&  chown mxhero: -R /opt/maildir-mxhero \
&&  chown mxhero: -R /opt/mxhero
RUN /bin/systemctl enable mxhero && /bin/systemctl enable mxheroweb

# CONFIGURE ROUNDCUBE
RUN rm -f /etc/apache2/sites-enabled/* \
          /etc/apache2/ports.conf

ADD apache2/sites-enabled/roundcube.conf /etc/apache2/sites-enabled/
ADD apache2/ports.conf /etc/apache2/

RUN ln -s /opt/mxhero/web/roundcube /var/www/roundcube
RUN chown www-data: -R /var/www
RUN /etc/init.d/apache2 restart

# CONFIGURE DOVECOT
ADD dovecot/dovecot-sql.conf.ext /etc/dovecot/
RUN sed -i 's/#!include auth-sql.conf.ext/!include auth-sql.conf.ext/g' /etc/dovecot/conf.d/10-auth.conf
RUN sed -i 's/#!include auth-master.conf.ext/!include auth-master.conf.ext/g' /etc/dovecot/conf.d/10-auth.conf
RUN sed -i 's/\#auth_master_user_separator =.*/auth_master_user_separator = \*/g' /etc/dovecot/conf.d/10-auth.conf
RUN sed -i 's/#valid_chroot_dirs =/valid_chroot_dirs = \/opt\/maildir-mxhero\/%d/g' /etc/dovecot/conf.d/10-mail.conf
RUN sed -i "s/#first_valid_gid.*/first_valid_gid=$(id mxhero -u)/g" /etc/dovecot/conf.d/10-mail.conf
RUN sed -i 's/^mail_location.*/mail_location = maildir:\/opt\/maildir-mxhero\/%d\/%n/g' /etc/dovecot/conf.d/10-mail.conf
RUN sed -i "s/MXHEROUID/$(id mxhero -u)/g" /etc/dovecot/dovecot-sql.conf.ext
RUN htpasswd -b -c -s /etc/dovecot/master-users mxhero mxhero
RUN /etc/init.d/dovecot restart

# CONFIGURE POSTFIX
ADD postfix/* /etc/postfix/

RUN postmulti -e init 
RUN postmulti -I postfix-mxh -G mxhero -e create 2> /dev/null
RUN postmulti -i postfix-mxh -e enable

RUN sed -i 's/^master_service_disable = inet/#master_service_disable = inet/g' /etc/postfix-mxh/main.cf 
RUN sed -i 's/^authorized_submit_users = /#authorized_submit_users = /g' /etc/postfix-mxh/main.cf

RUN /etc/init.d/postfix restart

# CONFIGURE MYSQL

ADD mysql/mysql.conf.d/mxhero.conf /etc/mysql/mysql.conf.d/
RUN TOTALMEMORY=$(grep MemTotal: /proc/meminfo |awk {'print $2'}); \
INNODBPOOLSIZE=$(echo "$(($TOTALMEMORY * 30 / 100))"); \
sed -i "s|INNODBPOOLSIZE|$INNODBPOOLSIZE|g" /etc/mysql/mysql.conf.d/mxhero.conf

ADD data/ /opt/data/
# CONFIGURE NGINX
ADD nginx/conf.d/mxhero.conf /etc/nginx/sites-available/default
RUN /etc/init.d/nginx restart

# START HERO
RUN systemctl start mxheroweb
RUN systemctl start mxhero

