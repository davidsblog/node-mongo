var db = require('../db');

var Comment = db.model('Comment', {
  body: { type: String, required: true },
  date: { type: Date, required: true, default: Date.now }
});

module.exports = Comment