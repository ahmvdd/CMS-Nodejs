const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const connection = require('../Connection'); // Connexion MySQL

// Route d'inscription
router.post('/register', async (req, res) => {
  const { Name, Prenom, Email, password } = req.body;

  if (!Name || !Prenom || !Email || !password) {
    return res.status(400).json({ message: "Tous les champs sont requis." });
  }

  try {
    const [results] = await connection.promise().query(
      "SELECT * FROM user WHERE Email = ?",
      [Email]
    );

    if (results.length > 0) {
      return res.status(400).json({ message: "Cet email est déjà utilisé." });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    await connection.promise().query(
      "INSERT INTO user (Name, Prenom, Email, password) VALUES (?, ?, ?, ?)",
      [Name, Prenom, Email, hashedPassword]
    );

    res.status(201).json({ message: "Inscription réussie." });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Erreur lors de l'inscription." });
  }
});

// Route de connexion
router.post('/login', async (req, res) => {
  const { Email, password } = req.body;

  if (!Email || !password) {
    return res.status(400).json({ message: "L'email et le mot de passe sont requis." });
  }

  try {
    const [results] = await connection.promise().query(
      "SELECT * FROM user WHERE Email = ?",
      [Email]
    );

    if (results.length === 0) {
      return res.status(401).json({ message: "Identifiants incorrects." });
    }

    const user = results[0];
    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      return res.status(401).json({ message: "Identifiants incorrects." });
    }

    res.json({
      message: "Connexion réussie.",
      user: {
        id: user.id,
        Name: user.Name,
        Prenom: user.Prenom,
        Email: user.Email,
        Role: user.Role,
      },
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Erreur lors de la tentative de connexion." });
  }
});

// Route pour récupérer les articles
router.get('/article', async (req, res) => {
  try {
    const [results] = await connection.promise().query("SELECT * FROM article");
    res.json(results); // Renvoie les articles en JSON
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Erreur lors de la récupération des articles." });
  }
});

// Exportation des routes
module.exports = router;
