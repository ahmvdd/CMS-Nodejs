/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.6.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: cms_db
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `Id_article` int NOT NULL AUTO_INCREMENT,
  `Titre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Contenu` text COLLATE utf8mb4_general_ci NOT NULL,
  `Date_publication` date NOT NULL,
  `Id_user` int DEFAULT NULL,
  PRIMARY KEY (`Id_article`),
  KEY `Id_user` (`Id_user`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`Id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES
(1,'Titre de l\'article 1','Contenu de l\'article 1.','2024-12-01',1),
(2,'Titre de l\'article 2','Contenu de l\'article 2.','2024-12-02',2),
(3,'Titre de l\'article 3','Contenu de l\'article 3.','2024-12-03',1),
(4,'Titre de l\'article 4','Contenu de l\'article 4.','2024-12-04',3),
(5,'Titre de l\'article 5','Contenu de l\'article 5.','2024-12-05',2),
(6,'Titre de l\'article 6','Contenu de l\'article 6.','2024-12-06',1),
(7,'Titre de l\'article 7','Contenu de l\'article 7.','2024-12-07',3),
(8,'Titre de l\'article 8','Contenu de l\'article 8.','2024-12-08',2),
(9,'Titre de l\'article 9','Contenu de l\'article 9.','2024-12-09',1),
(10,'Titre de l\'article 10','Contenu de l\'article 10.','2024-12-10',3);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_category`
--

DROP TABLE IF EXISTS `article_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_category` (
  `Id_article` int DEFAULT NULL,
  `Id_category` int DEFAULT NULL,
  KEY `Id_article` (`Id_article`),
  KEY `Id_category` (`Id_category`),
  CONSTRAINT `article_category_ibfk_1` FOREIGN KEY (`Id_article`) REFERENCES `article` (`Id_article`) ON DELETE CASCADE,
  CONSTRAINT `article_category_ibfk_2` FOREIGN KEY (`Id_category`) REFERENCES `category` (`Id_category`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_category`
--

LOCK TABLES `article_category` WRITE;
/*!40000 ALTER TABLE `article_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `Id_category` int NOT NULL AUTO_INCREMENT,
  `Name_category` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Content` text COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `Id_comment` int NOT NULL AUTO_INCREMENT,
  `Content` text COLLATE utf8mb4_general_ci NOT NULL,
  `Date_creation` datetime NOT NULL,
  `Date_modification` datetime NOT NULL,
  `Id_article` int DEFAULT NULL,
  `Id_user` int DEFAULT NULL,
  PRIMARY KEY (`Id_comment`),
  KEY `Id_article` (`Id_article`),
  KEY `Id_user` (`Id_user`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`Id_article`) REFERENCES `article` (`Id_article`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`Id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES
(1,'Ceci est un premier commentaire.','2024-12-13 12:00:00','2024-12-13 12:00:00',2,1),
(2,'Un deuxième commentaire intéressant.','2024-12-13 12:05:00','2024-12-13 12:05:00',1,2),
(3,'Merci pour cet article très utile.','2024-12-13 12:10:00','2024-12-13 12:10:00',6,3),
(4,'J\'ai quelques questions concernant le sujet.','2024-12-13 12:15:00','2024-12-13 12:15:00',9,7),
(5,'Ceci est un autre commentaire.','2024-12-13 12:20:00','2024-12-13 12:20:00',8,5);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `Prenom` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `Date_inscription` datetime DEFAULT CURRENT_TIMESTAMP,
  `Email` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `Role` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'user',
  `password` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'Dupont','Jean','2023-01-01 00:00:00','jean.dupont@example.com','admin','123456'),
(2,'TEST','test','2024-12-06 00:00:00','test@gmail.com','user','$2a$10$4xZeEJ6YANnanR8rYnTbMuhEm2Zb2j3GUj4g6YxhHUOdTpyq02dP6'),
(3,'MMM','test','2024-12-07 00:00:00','MMM@gmail.com','user','$2a$10$0xG2NTmsEnKCM5LUtK8.g.zPYlKA5r.Kh1omIaBjiPcrNDoqvB1jm'),
(5,'RMM','vkdfklvdf','2024-12-07 00:00:00','jean.@example.com','user','$2a$10$efqwO0cbVGJJ4i21gJC2EODboHNQSl9HOxd4M3JCbji0sY4B4Mhlu'),
(6,'RMM','vkdfklvdf','2024-12-07 00:00:00',' jbjkbjean.@example.com','user','$2a$10$5x6iAZHWx/FyI5YLND95Vut4hrNe03KNcxpdzVVeFiw5wcjpt6POm'),
(7,'sayeh','ahmed','0000-00-00 00:00:00','ahmed.sayeh67@gmail.com','','$2a$10$hAieNeWzyvppg0/HMr.XA.o1ivgrYKYr1Y9F1mVWGMMwfEuxzzzzW'),
(8,'Sayeh','Ahmed','0000-00-00 00:00:00','fvfdvjdnfjndf@gmail.com','','$2a$10$rBxSIkX0e2ipH.kUGhYUjuVVGTfAockiwbYRfNlMYfBh6L4JIh6fm'),
(9,'vdfvfvdfv','test','0000-00-00 00:00:00','sdcdkfvdfv@gmail.com','','$2a$10$5FLoeNNe.PKemc3aylQvde5Dcw8d3fcfzG023pjqYmm88gSZ45fDu'),
(10,'testtttt','cestuntestt','2024-12-13 14:59:33','jean.dup@example.com','user','$2a$10$03FXPMka7GVrsNm1BeWx4.7c/PAUx53GORLsGZUCabL1Gfwmmd3rG'),
(11,'kjfvdfkjv','vjkndmf','2024-12-19 22:03:16','svkjdfvd@gmail.com','user','$2a$10$JKjY7tQc8/wE4Z5mmapD4uuo1vBi.Mn7mEapbQLr.gaG8zMYrspAC'),
(12,'kjfvdfkjv','vjkndmf','2024-12-19 22:04:43','tlkdflvkdfv@gmail.com','user','$2a$10$gzhmDn9KBeCxCSv3Nhv0zehCSKOc5kBUVyS6IbL3ATesnRD33fq1S'),
(13,'kjfvdfkjv','vjkndmf','2024-12-19 22:08:23','csdcsdcs@gmail.com','user','$2a$10$aWzeYYRJ7i1TUwq6QSF8FuhkuwHi7Jl6RzUm7tNjtjczCV5ss7z1q');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-12-20 21:11:06
