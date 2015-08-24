# See: http://phusion.github.io/baseimage-docker/

# Use a specific version to be repeatable
FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

RUN mkdir -p /etc/service/nodestart && \
    mkdir -p /etc/service/mongod

# Add a script to run the Mongo daemon
ADD mongod.sh /etc/service/mongod/run

# Add a script to run the a Node app
ADD nodestart.sh /etc/service/nodestart/run

# Install Node.js and Express
RUN apt-get -y update && \
    apt-get -y install wget && \
    apt-get -y install npm && \
    npm install -g n && \
    n stable && \
    npm install express -g && \
    npm install body-parser -g && \
    mkdir -p /vol/node/start && \
    chmod +x /etc/service/nodestart/run

ADD server.js package.json /vol/node/start/

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  mkdir -p /vol/data/db && \
  chmod +x /etc/service/mongod/run

# Define mountable directories for mongo and node
VOLUME ["/vol/data/db", "/vol/node/start"]

EXPOSE 27017 28017 8888

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*