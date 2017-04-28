# node-mongo

A docker container running node and mongo.  **Since I'm using this for development/testing the node apps are started through nodemon, so you can edit the source without needing to restart anything.**

## Using this container:

Test the container:

``docker run --rm -p 8080:8888 davidsblog/node-mongo``

Run a node project **from the host** (in the current directory):

``docker run --rm -v ${PWD}:/vol/node/start -p 8080:8888 davidsblog/node-mongo``

Or ... use it to run a container-volume:

https://github.com/davidsblog/nm-app-demo
