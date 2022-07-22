-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: almacenes
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_almacen`
--

DROP TABLE IF EXISTS `tbl_almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_almacen` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `lugar` varchar(100) NOT NULL,
  `capacidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_almacen`
--

LOCK TABLES `tbl_almacen` WRITE;
/*!40000 ALTER TABLE `tbl_almacen` DISABLE KEYS */;
INSERT INTO `tbl_almacen` VALUES (1,'Los Andes',NULL),(2,'pereira',12),(3,'las bahamas',NULL);
/*!40000 ALTER TABLE `tbl_almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_caja`
--

DROP TABLE IF EXISTS `tbl_caja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_caja` (
  `num_referencia` char(5) NOT NULL,
  `contenido` varchar(100) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `almacen` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_referencia`),
  KEY `FK_tbl_caja_tbl_almacen` (`almacen`),
  CONSTRAINT `FK_tbl_caja_tbl_almacen` FOREIGN KEY (`almacen`) REFERENCES `tbl_almacen` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_caja`
--

LOCK TABLES `tbl_caja` WRITE;
/*!40000 ALTER TABLE `tbl_caja` DISABLE KEYS */;
INSERT INTO `tbl_caja` VALUES ('123','contiene dulces',13000,2),('566','contiene chocolates',4000,1);
/*!40000 ALTER TABLE `tbl_caja` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-24 14:23:11
