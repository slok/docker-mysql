#!/bin/bash

set -e

/usr/bin/mysqld_safe > /dev/null 2>&1 &

# Wait until Mysql is up
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

DATABASES=("database1" "database2")
declare -A USERS=(["user1"]="pass1" ["user2"]="pass2")
ADMINS=("user1")

# Create databases
for DB in ${DATABASES[*]}; do
    mysql -uroot -e "CREATE DATABASE $DB;"
done

# Create users and grant in created databases
for USER in "${!USERS[@]}"; do
    PASS=${USERS["$USER"]}

    mysql -uroot -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';"
    for DB in $DATABASES; do
        mysql -uroot -e "GRANT ALL PRIVILEGES ON $DB.* TO '$USER'@'%';"
    done
done

for ADMIN in "${ADMINS[*]}"; do
    mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$ADMIN'@'%';"
done

mysqladmin -uroot shutdown