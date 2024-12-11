const mysql = require("mysql2");

const connection = mysql.createConnection({
  host: process.env.HOST,
  user: "root",
  password: process.env.PASSWORD,
  database: process.env.DATABASE_NAME,
  waitForConnections: true,
  queueLimit: 0,
});

connection.connect((err) => {
  if (err) {
    console.error("Erreur de connexion à la base de données :", err);
    return;
  }
  console.log("Connexion à la base de données avec succès.");
});
module.exports = connection; 