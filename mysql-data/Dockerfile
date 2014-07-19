FROM busybox
MAINTAINER Xabier Larrakoetxea <slok69@gmail.com>


# Create data directory
RUN mkdir /data

# Mysql UID = 102 & GID = 105
RUN chown 102:105 /data
RUN chmod 700 /data

# Create
VOLUME /data