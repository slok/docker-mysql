FROM ubuntu:14.04
MAINTAINER Xabier Larrakoetxea <slok69@gmail.com>

# Some Environment Variables
ENV    DEBIAN_FRONTEND noninteractive

# MySQL Installation
RUN apt-get update
RUN echo "mysql-server mysql-server/root_password password " | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password " | debconf-set-selections
RUN apt-get install -y mysql-server

# Set the configuration
ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 644 /etc/mysql/conf.d/my.cnf
ADD run.sh /run.sh
ADD create_first_admin_user.sh /create_first_admin_user.sh
ADD create_database_and_users.sh /create_database_and_users.sh
RUN chmod 755 /*.sh

# Expose port and volumes
EXPOSE 3306
VOLUME ["/var/log/mysql", "/etc/mysqld", "/var/run/mysqld"]

# Start the magic
CMD ["/run.sh"]