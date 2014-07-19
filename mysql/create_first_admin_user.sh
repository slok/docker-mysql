#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

# Wait until Mysql is up
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

# First admin user
# User: 'root'
# Pass: ''
mysql -uroot -e "UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION"
mysql -uroot -e "flush privileges"

mysqladmin -uroot shutdown