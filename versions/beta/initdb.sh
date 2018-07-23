#!/bin/bash
# SET PANEL ADMIN PASSWORD
sed -i "s/GLOBAL_ADMIN_PASSWORD/$GLOBAL_ADMIN_PASSWD/g" /opt/data/mxhero.sql
# # CREATE DATABASES
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS attachments"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS mxhero"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS quarantine"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS roundcubemail"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS secureemail"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS statistics"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS text2image"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "CREATE DATABASE IF NOT EXISTS threadlight"
# # POPULATE
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D attachments < /opt/data/attachments.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D mxhero < /opt/data/mxhero.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D quarantine < /opt/data/quarantine.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D roundcubemail < /opt/data/roundcubemail.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D secureemail < /opt/data/secureemail.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D statistics < /opt/data/statistics-schema.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D text2image < /opt/data/text2image.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D threadlight < /opt/data/threadlight.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D mxhero < /opt/data/functions/mxhero.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D secureemail < /opt/data/functions/secureemail.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D statistics < /opt/data/functions/statistics.sql
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -D threadlight < /opt/data/functions/threadlight.sql
# # CREATE USERS
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON attachments.* TO attachmentlink@'localhost' IDENTIFIED BY 'attachmentlink'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'localhost' IDENTIFIED BY 'mxhero'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'%' IDENTIFIED BY 'mxhero'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON roundcubemail.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON attachments.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON statistics.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON threadlight.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "GRANT ALL PRIVILEGES ON text2image.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -p$MYSQL_ADMIN_PASSWD -Bse "FLUSH PRIVILEGES"
