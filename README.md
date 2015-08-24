# node-mongo

##Work in progress

A docker container running node and mongo

##Using this container:

Test the container:
``docker run -d -p 8080:8888 node-mongo``

Run a node project in the current directory:
``docker run -d -v ${PWD}:/vol/node/start -p 8080:8888 node-mongo``
