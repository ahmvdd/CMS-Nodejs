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
const commentRoutes = require('./routes/comments');

var app = express();

// Activez CORS pour toutes les origines
app.use(cors());

// Middleware pour analyser le JSON
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

// Middleware pour servir les fichiers statiques de votre application React
app.use(express.static(path.join(__dirname, 'build')));

// Routes pour l'API
app.use('/users', usersRouter);
app.use('/article', articlesRouter);
app.use('/comments', commentRoutes);

// Route pour servir l'application React
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});
const corsOptions = {
    origin: 'http://34.207.133.175', // Remplacez par l'URL de votre frontend
    methods: ['GET', 'POST', 'PUT', 'DELETE'], // Méthodes autorisées
    allowedHeaders: ['Content-Type', 'Authorization'], // En-têtes autorisés
};

app.use(cors(corsOptions));

module.exports = app;


// require("dotenv").config();  // initialisation de dotenv + configuration
// require("./Connection");
// const cors = require('cors');

// var express = require('express');
// var path = require('path');
// var cookieParser = require('cookie-parser');
// var logger = require('morgan');

// var indexRouter = require('./routes/index');
// var usersRouter = require('./routes/users');
// const articlesRouter = require('./routes/article');
// const commentRoutes = require('./routes/comments');

// var app = express();

// // Options CORS
// const corsOptions = {
//     origin: 'http://34.207.133.175', // Remplacez par l'URL de votre frontend
//     methods: ['GET', 'POST', 'PUT', 'DELETE'], // Méthodes autorisées
//     allowedHeaders: ['Content-Type', 'Authorization'], // En-têtes autorisés
// };

// // Activez CORS pour l'origine spécifiée
// app.use(cors(corsOptions));

// // Middleware pour analyser le JSON
// app.use(express.json());
// app.use(express.urlencoded({ extended: false }));
// app.use(cookieParser());

// // Middleware pour servir les fichiers statiques de votre application React
// app.use(express.static(path.join(__dirname, 'build')));

// // Routes pour l'API
// app.use('/users', usersRouter);
// app.use('/article', articlesRouter);
// app.use('/comments', commentRoutes);

// // Route pour servir l'application React
// app.get('*', (req, res) => {
//   res.sendFile(path.join(__dirname, 'build', 'index.html'));
// });

// module.exports = app;
