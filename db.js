var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/demo', function () {
  console.log('connected to mongodb');
})

module.exports = mongoose;