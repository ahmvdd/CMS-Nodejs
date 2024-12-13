const express = require('express');
const connection = require('../Connection');
const router = express.Router();

// La route pour afficher

router.get('/', async (req, res) => {
    try {
      const [results] = await connection.promise().query("SELECT * FROM article");
      res.json(results); 
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Erreur lors de la récupération des articles." });
    }
  });


  // Route pour ajouter un article
router.post('/ajouter', async (req, res) => {
    const { Title, Content } = req.body;

    // Validation des champs
    if (!Title || !Content) {
        return res.status(400).json({ message: "Le titre et le contenu sont requis." });
    }

    try {
        // Insérer un nouvel article dans la base de données
        await connection.promise().query(
            "INSERT INTO article (Titre, Contenu) VALUES (?, ?)",
            [Title, Content]
        );

        res.status(201).json({ message: "Article ajouté avec succès." });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Erreur lors de l'ajout de l'article." });
    }
});

// Route pour supprimer un article par ID
router.delete('/supprimer/:id', async (req, res) => {
    const { id } = req.params;

    try {
        // Vérifier si l'article existe
        const [articles] = await connection.promise().query(
            "SELECT * FROM article WHERE id = ?",
            [id]
        );

        if (articles.length === 0) {
            return res.status(404).json({ message: "L'article n'a pas été trouvé." });
        }

        // Supprimer l'article
        await connection.promise().query(
            "DELETE FROM article WHERE id = ?",
            [id]
        );

        res.json({ message: "L'article a été supprimé avec succès." });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Erreur lors de la suppression de l'article." });
    }
});



  module.exports = router;