# See: http://phusion.github.io/baseimage-docker/

# Use a specific version to be repeatable
FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add a script to run the Mongo daemon
ADD mongod.sh /etc/service/mongod/run

# Add a script to run the a Node app
ADD nodestart.sh /etc/service/nodestart/run

# Install Node.js v 0.12.7
RUN apt-get -y update && \
    apt-get -y install wget && \
    apt-get -y install npm && \
    npm install -g n && \
    npm install -g nodemon &&\
    n 0.12.7 && \
    mkdir -p /vol/node/start

# Set up a default app
ADD server.js package.json /vol/node/start/
ADD node_modules /vol/node/start/node_modules

# Install MongoDB v 2.6.11
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org mongodb-org=2.6.11 mongodb-org-server=2.6.11 mongodb-org-shell=2.6.11 mongodb-org-mongos=2.6.11 mongodb-org-tools=2.6.11 && \
  mkdir -p /vol/data/db

# Define mountable directories for mongo and node
VOLUME ["/vol/data/db", "/vol/node/start"]

EXPOSE 27017 28017 8888

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
