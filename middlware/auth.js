const jwt = require ('jsonwebtoken')

const auth = (req, res, next) => {
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(" ")[1];
  
    if (!token) {
      return res.status(401).json({ message: "Token manquant" });
    }
  
    jwt.verify(
      token,
      process.env.JWT_SECRET || "your-secret-key",
      (err, user) => {
        if (err) {
          return res.status(403).json({ message: "Token invalide" });
        }
        //console.log(user);
        
        req.user = user;
        next();
      }
    );
  };

  module.exports= {auth}