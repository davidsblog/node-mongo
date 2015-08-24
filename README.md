# node-mongo

##Work in progress

A docker container running node and mongo

##Using this container:

Test the container:

``docker run -d -p 8080:8888 node-mongo``

Run a node project **from the host** (in the current directory):

``docker run -d -v ${PWD}:/vol/node/start -p 8080:8888 node-mongo``

Or ... use it to run a container-volume:

https://github.com/davidsblog/nm-app-demo
