// from inside the code directory you can run this with:
// docker run --rm -v ${PWD}:/vol/node/start -p 8080:8888 davidsblog/node-mongo

var express = require('express')
var bodyParser = require('body-parser')
var Comment = require('./model/comment')
var app = express()
app.use(bodyParser.json())

bootstrap()
app.listen(8888)

app.get('/', function(req, res)
{
    res.sendFile('layouts/comments.html', { root : __dirname})
})

app.post('/api/comments', function (req, res, next) {
  var comment = new Comment({ body: req.body.body }); 
  comment.save(function (err, comment) {
    if (err) { return next(err) }
    res.status(201).json(comment)
  })
})

app.get('/api/comments', function (req, res, next)
{
    Comment.find().sort('-date').exec(function(err, comments)
    {
        if (err) { return next(err) }
        res.status(200).json(comments)
    })
})

function bootstrap()
{
    Comment.find().limit(1).exec(function(err, firstComment) {
        if (firstComment.length < 1) {
            new Comment({ body: 'Hello, world!' }).save();    
        }
    })
}