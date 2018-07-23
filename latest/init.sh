#!/bin/bash

trap ctrl_c INT
function ctrl_c() {
    /bin/bash
}

sed -i "s/GLOBAL_ADMIN_PASSWORD/$GLOBAL_ADMIN_PASSWD/g" /opt/data/mxhero.sql
sed -i "s|MXHEROMYNETWORKS|$MYNETWORKS|g" /etc/postfix/main.cf.proto /etc/postfix/main.cf
sed -i "s/MXHEROHOSTNAME/`hostname`/g" /etc/postfix/main.cf.proto /etc/postfix/main.cf

/etc/init.d/apache2 start
/etc/init.d/dovecot start
/etc/init.d/mysql start
/etc/init.d/nginx start
/etc/init.d/postfix start
systemctl start mxheroweb
systemctl start mxhero
if [ $INITDB -eq 1 ]; then
    source /opt/initdb.sh
fi

if [ $? -eq 0 ]; then
    echo "Started Sucessfully..."
    while true; do
        sleep 1
    done
fi

