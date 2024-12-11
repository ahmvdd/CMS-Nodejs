const express = require('express');

const router = express.Router();



router.get('/article', async (req, res) => {
    try {
      const [results] = await connection.promise().query("SELECT * FROM article");
      res.json(results); 
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Erreur lors de la récupération des articles." });
    }
  });


  


  module.exports = router;