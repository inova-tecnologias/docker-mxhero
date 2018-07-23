FROM ubuntu:16.04
MAINTAINER Leo Marangoni <leonardo.marangoni@inova.net>

#ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install dialog

# PERL
RUN apt-get -y install perl
RUN apt-get -y install \
libcgi-fast-perl \
libfcgi-perl \
libhttp-date-perl \
liblwp-mediatypes-perl \
libsocket6-perl \
libcgi-pm-perl \
libhtml-parser-perl \
libhttp-message-perl \
libmail-spf-perl \
libtimedate-perl \
libdigest-hmac-perl \
libhtml-tagset-perl \
libio-html-perl \
libnet-dns-perl \
liburi-perl \
libencode-locale-perl \
libhtml-template-perl \
libio-socket-inet6-perl \
libnet-ip-perl

# MYSQL
RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections

RUN apt-get update && \
	apt-get -y install mysql-server-5.7 && \
	mkdir -p /var/lib/mysql && \
	mkdir -p /var/run/mysqld && \
	mkdir -p /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/log/mysql


# # UTF-8 and bind-address
RUN sed -i -e "$ a [client]\n\n[mysql]\n\n[mysqld]"  /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysqld\]\)/\1\ninit_connect='SET NAMES utf8'\ncharacter-set-server = utf8\ncollation-server=utf8_unicode_ci\nbind-address = 0.0.0.0/g" /etc/mysql/my.cnf


# POSTFIX
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install postfix postfix-mysql

# PHP
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php -y || true
RUN apt-get update
RUN apt-get -y install php5.6 --allow-unauthenticated
RUN apt-get -y install php5.6-mysql php5.6-xml --allow-unauthenticated

#spamassassin
RUN apt-get install -y spamassassin

#clamav
RUN apt-get install -y clamav

#dovecot
RUN apt-get install -y dovecot-core dovecot-imapd dovecot-mysql

#apache2
#no need but just in case…
RUN apt-get install -y apache2 libapache2-mod-php5.6

#nginx
RUN /etc/init.d/apache2 stop
RUN apt-get install -y nginx --allow-unauthenticated
RUN apt-get install -y libvpx3 libwebp5

#mxhero
RUN apt-get -y install wget
RUN wget https://s3.amazonaws.com/mxhero/releases/mxhero_2.2.4_amd64.deb \
&& dpkg -i mxhero_2.2.4_amd64.deb
