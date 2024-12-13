require("dotenv").config();  // initialisation de dotenv + configuration
require("./Connection");
const cors = require('cors');


var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
const articlesRouter = require('./routes/article');
// const commentsRouter = require('./routes/comment');
const commentRoutes = require('./routes/comments');



var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/users', usersRouter);
app.use('/article', articlesRouter);
// app.use('/comment', commentsRouter);
app.use('/comment', commentRoutes);


module.exports = app;
