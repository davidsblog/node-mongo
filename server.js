var express = require('express');

var app = express();
app.get('/', function(req, res) {
   res.status(200).send('This was sent from Express running in Node');
});

app.listen(8888);