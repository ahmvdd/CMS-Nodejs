// var express = require('express');
// var router = express.Router();

// /* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

// module.exports = router;
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const connection = require('../Connection'); // Votre connexion MySQL2

// Route d'inscription
router.post("/register", async (req, res) => {
  const { Name, Prenom, Email, password } = req.body;

  // Validation des champs
  if (!Name || !Prenom || !Email || !password) {
      return res.status(400).json({ message: "Tous les champs sont requis." });
  }

  try {
      // Vérifier si l'email existe déjà
      const [results] = await connection.promise().query(
          "SELECT * FROM user WHERE Email = ?",
          [Email]
      );

      if (results.length > 0) {
          return res.status(400).json({ message: "Cet email est déjà utilisé." });
      }

      // Hacher le mot de passe
      const hashedPassword = await bcrypt.hash(password, 10);

      // Insérer dans la base de données
      const Role = "user"; // ou admin selon vos besoins
      const Date_inscription = new Date().toISOString().split("T")[0];

      await connection.promise().query(
          "INSERT INTO user (Name, Prenom, Email, password, Role, Date_inscription) VALUES (?, ?, ?, ?, ?, ?)",
          [Name, Prenom, Email, hashedPassword, Role, Date_inscription]
      );

      // Redirection vers la page d'accueil après une inscription réussie
     res.json({message:"utulisateur cree"});

  } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Erreur lors de l'inscription." });
  }
});

module.exports = router; // Assurez-vous que ceci est présent
