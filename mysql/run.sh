#!/bin/bash

VOLUME_HOME="/data"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"  
    /create_first_admin_user.sh
else
    echo "=> Using an existing volume of MySQL"
fi

exec mysqld_safe