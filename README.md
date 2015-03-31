docker-mysql
============

Docker mysql with data only container approach

Step one (Build the data container):

    docker build -t slok/mysql-data ./mysql-data

Step two (Build the mysql container):

    docker build -t slok/mysql ./mysql

Step three (Run the data container):

    docker run slok/mysql-data

Step four (Run the mysql container with data volumes):

    docker run --volumes-from mysql-data slok/mysql

# Backups

enter or run a command in the data container as a normal container:

    docker run -it --volumes-from mysql-data busybox /bin/sh

# Databases & users

Add databases and users with pass to ``create_Database_and_users.sh`` on lines:

    DATABASES=("database1" "database2")
    declare -A USERS=(["user1"]="pass1" ["user2"]="pass2")
