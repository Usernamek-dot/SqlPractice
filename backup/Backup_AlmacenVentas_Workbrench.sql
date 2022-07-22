CREATE DATABASE  IF NOT EXISTS `almacenventas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci */;
USE `almacenventas`;
-- MySQL dump 10.13  Distrib 5.6.10, for Win32 (x86)
--
-- Host: localhost    Database: almacenventas
-- ------------------------------------------------------
-- Server version	5.6.10

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
-- Table structure for table `tblcliente`
--

DROP TABLE IF EXISTS `tblcliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcliente` (
  `docid` varchar(15) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombres` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellidos` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `direccion` varchar(50) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcliente`
--

LOCK TABLES `tblcliente` WRITE;
/*!40000 ALTER TABLE `tblcliente` DISABLE KEYS */;
INSERT INTO `tblcliente` VALUES ('123','db63be45433b6a9e931565099f554e4e','b','48','51','yu'),('15420350','Juan','Perez','5616161','Calle 28 No.10-50','jp@gmail.com'),('25136150','Pedro','Ayala','3202020','Cra 8 No. 16-38','pa@hotmail.com'),('39426514','Maria','García','5313131','Calle 45 No. 20-10',NULL);
/*!40000 ALTER TABLE `tblcliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfactura`
--

DROP TABLE IF EXISTS `tblfactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfactura` (
  `numero` int(11) NOT NULL,
  `cliente` varchar(15) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fechafact` datetime NOT NULL,
  `fechapago` date DEFAULT NULL,
  `formapago` varchar(3) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_tblfactura_tblformapago1_idx` (`formapago`),
  KEY `fk_tblfactura_tblcliente1_idx` (`cliente`),
  CONSTRAINT `fk_tblfactura_tblcliente1` FOREIGN KEY (`cliente`) REFERENCES `tblcliente` (`docid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblfactura_tblformapago1` FOREIGN KEY (`formapago`) REFERENCES `tblformapago` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfactura`
--

LOCK TABLES `tblfactura` WRITE;
/*!40000 ALTER TABLE `tblfactura` DISABLE KEYS */;
INSERT INTO `tblfactura` VALUES (1,'15420350','2013-05-02 08:04:02',NULL,'1'),(2,'25136150','2013-04-29 13:05:00','2013-05-01','4'),(3,'15420350','2013-04-15 20:02:16','2013-04-18','2'),(4,'25136150','2013-04-05 11:12:25','2013-04-20','1');
/*!40000 ALTER TABLE `tblfactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblformapago`
--

DROP TABLE IF EXISTS `tblformapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblformapago` (
  `codigo` varchar(3) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblformapago`
--

LOCK TABLES `tblformapago` WRITE;
/*!40000 ALTER TABLE `tblformapago` DISABLE KEYS */;
INSERT INTO `tblformapago` VALUES ('1','Efectivo'),('2','Tarjeta Crédito'),('3','Tarjeta Débito'),('4','Cheque');
/*!40000 ALTER TABLE `tblformapago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproducto`
--

DROP TABLE IF EXISTS `tblproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproducto` (
  `codigo` varchar(6) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  `costo` int(11) NOT NULL,
  `existencia` int(11) NOT NULL,
  `unidadmedida` varchar(3) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_tblproducto_tblunidadmedida1_idx` (`unidadmedida`),
  CONSTRAINT `fk_tblproducto_tblunidadmedida1` FOREIGN KEY (`unidadmedida`) REFERENCES `tblunidadmedida` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproducto`
--

LOCK TABLES `tblproducto` WRITE;
/*!40000 ALTER TABLE `tblproducto` DISABLE KEYS */;
INSERT INTO `tblproducto` VALUES ('1','Yuca',1000,10,'1'),('2','Papa',2000,15,'1'),('3','Arroz',1500,12,'5'),('4','Avena',600,50,'4'),('5','Café',10000,35,'5');
/*!40000 ALTER TABLE `tblproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproductofactura`
--

DROP TABLE IF EXISTS `tblproductofactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproductofactura` (
  `numfactura` int(11) NOT NULL,
  `codproducto` varchar(6) COLLATE utf8mb4_spanish_ci NOT NULL,
  `cantidad` int(11) NOT NULL,
  `valor` int(11) NOT NULL,
  PRIMARY KEY (`numfactura`,`codproducto`),
  KEY `fk_tblproductofactura_tblproducto1_idx` (`codproducto`),
  KEY `fk_tblproductofactura_tblfactura_idx` (`numfactura`),
  CONSTRAINT `fk_tblproductofactura_tblfactura` FOREIGN KEY (`numfactura`) REFERENCES `tblfactura` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblproductofactura_tblproducto1` FOREIGN KEY (`codproducto`) REFERENCES `tblproducto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproductofactura`
--

LOCK TABLES `tblproductofactura` WRITE;
/*!40000 ALTER TABLE `tblproductofactura` DISABLE KEYS */;
INSERT INTO `tblproductofactura` VALUES (1,'1',3,4000),(1,'2',2,5000),(1,'3',8,3000),(2,'4',3,8000),(2,'5',2,15000),(3,'1',5,4000),(3,'4',10,4000),(4,'1',5,4000),(4,'2',5,5000),(4,'3',12,3000),(4,'5',28,15000);
/*!40000 ALTER TABLE `tblproductofactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblunidadmedida`
--

DROP TABLE IF EXISTS `tblunidadmedida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblunidadmedida` (
  `codigo` varchar(3) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblunidadmedida`
--

LOCK TABLES `tblunidadmedida` WRITE;
/*!40000 ALTER TABLE `tblunidadmedida` DISABLE KEYS */;
INSERT INTO `tblunidadmedida` VALUES ('1','Kilo'),('4','Gramo'),('5','Libra');
/*!40000 ALTER TABLE `tblunidadmedida` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-05-17  8:24:23
