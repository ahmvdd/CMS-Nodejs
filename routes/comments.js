const express = require('express');
const connection = require('../Connection');
const router = express.Router();

// recuperer les commentaires 
router.get('/', async (req, res) => {
    try {
        const [results] = await connection.promise().query("SELECT * FROM comment");
        res.json(results);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Erreur lors de la récupération des commentaires." });
    }
});

//ajouter un commentaire
router.post('/ajouter', async (req, res) => {
    const { Content, id_article, id_user } = req.body;

    // Validation  
    if (!Content || !id_article || !id_user) {
        return res.status(400).json({ message: "Le contenu, l'ID de l'article et l'ID de l'utilisateur sont requis." });
    }

    try {
        // Insérer un nouveau commentaire  
        await connection.promise().query(
            "INSERT INTO comment (Content, Date_creation, Date_modification, id_article, id_user) VALUES (?, NOW(), NOW(), ?, ?)",
            [Content, id_article, id_user]
        );

        res.status(201).json({ message: "Commentaire ajouté avec succès." });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Erreur lors de l'ajout du commentaire." });
    }
});

// supprimer un commentaire par son id
router.delete('/supprimer/:id', async (req, res) => {
    const { id } = req.params;

    try {
        // Vérifier si le commentaire existe
        const [comments] = await connection.promise().query(
            "SELECT * FROM comment WHERE id_comment = ?",
            [id]
        );

        if (comments.length === 0) {
            return res.status(404).json({ message: "Le commentaire n'a pas été trouvé." });
        }

        // Supprimer le commentaire
        await connection.promise().query(
            "DELETE FROM comment WHERE id_comment = ?",
            [id]
        );

        res.json({ message: "Le commentaire a été supprimé avec succès." });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Erreur lors de la suppression du commentaire." });
    }
});

module.exports = router;
