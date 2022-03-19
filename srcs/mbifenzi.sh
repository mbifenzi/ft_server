#!/bin/sh
chown -R www-data:www-data /var/www/html/phpmyadmin;
chown -R mysql: /var/lib/mysql;


service mysql start;

mysql -u root -e "CREATE USER 'mbifenzi'@'localhost' IDENTIFIED BY '123456';"
mysql -u root -e "CREATE DATABASE mbifenzidb; use mbifenzidb; source /var/lib/mysql/mbifenzidb.sql;"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'mbifenzi'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root < /var/www/html/phpmyadmin/sql/create_tables.sql;

service nginx start;
service php7.3-fpm start;

/bin/bash
