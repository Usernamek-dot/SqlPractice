-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: ejercicio
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
-- Table structure for table `domicilio`
--

DROP TABLE IF EXISTS `domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domicilio` (
  `cod_domicilio` varchar(3) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`cod_domicilio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domicilio`
--

LOCK TABLES `domicilio` WRITE;
/*!40000 ALTER TABLE `domicilio` DISABLE KEYS */;
/*!40000 ALTER TABLE `domicilio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleado` (
  `dni_empleado` varchar(12) NOT NULL,
  `nombre` varchar(70) DEFAULT NULL,
  `domicilio` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`dni_empleado`),
  KEY `FK_empleado_domicilio` (`domicilio`),
  CONSTRAINT `FK_empleado_domicilio` FOREIGN KEY (`domicilio`) REFERENCES `domicilio` (`cod_domicilio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `existencias`
--

DROP TABLE IF EXISTS `existencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `existencias` (
  `cod_articulo` varchar(20) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `cantidad` int(3) DEFAULT NULL,
  `precio` int(6) DEFAULT NULL,
  `cod_pub` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`cod_articulo`),
  KEY `FK_existencias_pub` (`cod_pub`),
  CONSTRAINT `FK_existencias_pub` FOREIGN KEY (`cod_pub`) REFERENCES `pub` (`cod_pub`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `existencias`
--

LOCK TABLES `existencias` WRITE;
/*!40000 ALTER TABLE `existencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `existencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcion`
--

DROP TABLE IF EXISTS `funcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcion` (
  `cod_funcion` varchar(3) NOT NULL,
  `nombre` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`cod_funcion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcion`
--

LOCK TABLES `funcion` WRITE;
/*!40000 ALTER TABLE `funcion` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localidad`
--

DROP TABLE IF EXISTS `localidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localidad` (
  `cod_localidad` int(3) NOT NULL,
  `nombre` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`cod_localidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localidad`
--

LOCK TABLES `localidad` WRITE;
/*!40000 ALTER TABLE `localidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pub`
--

DROP TABLE IF EXISTS `pub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub` (
  `cod_pub` varchar(2) NOT NULL,
  `nombre` varchar(10) DEFAULT NULL,
  `licencia_fiscal` varchar(12) DEFAULT NULL,
  `domicilio` varchar(70) DEFAULT NULL,
  `fecha_apertura` date DEFAULT NULL,
  `horario` datetime DEFAULT NULL,
  `cod_localidad` int(3) DEFAULT NULL,
  PRIMARY KEY (`cod_pub`),
  KEY `FK_pub_localidad` (`cod_localidad`),
  KEY `FK_pub_domicilio` (`domicilio`),
  CONSTRAINT `FK_pub_domicilio` FOREIGN KEY (`domicilio`) REFERENCES `domicilio` (`cod_domicilio`),
  CONSTRAINT `FK_pub_localidad` FOREIGN KEY (`cod_localidad`) REFERENCES `localidad` (`cod_localidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pub`
--

LOCK TABLES `pub` WRITE;
/*!40000 ALTER TABLE `pub` DISABLE KEYS */;
/*!40000 ALTER TABLE `pub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pub_empleado`
--

DROP TABLE IF EXISTS `pub_empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_empleado` (
  `cod_pub` varchar(2) NOT NULL,
  `dni_empleado` varchar(12) NOT NULL,
  `funcion` varchar(9) NOT NULL,
  PRIMARY KEY (`cod_pub`,`dni_empleado`,`funcion`),
  KEY `FK_pub_empleado_empleado` (`dni_empleado`),
  KEY `FK_pub_empleado_funcion` (`funcion`),
  CONSTRAINT `FK_pub_empleado_empleado` FOREIGN KEY (`dni_empleado`) REFERENCES `empleado` (`dni_empleado`),
  CONSTRAINT `FK_pub_empleado_funcion` FOREIGN KEY (`funcion`) REFERENCES `funcion` (`cod_funcion`),
  CONSTRAINT `FK_pub_empleado_pub` FOREIGN KEY (`cod_pub`) REFERENCES `pub` (`cod_pub`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pub_empleado`
--

LOCK TABLES `pub_empleado` WRITE;
/*!40000 ALTER TABLE `pub_empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `pub_empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titular`
--

DROP TABLE IF EXISTS `titular`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titular` (
  `dni_titular` varchar(10) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `domicilio` varchar(70) DEFAULT NULL,
  `cod_pub` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`dni_titular`),
  KEY `FK_titular_pub` (`cod_pub`),
  KEY `FK_titular_domicilio` (`domicilio`),
  CONSTRAINT `FK_titular_domicilio` FOREIGN KEY (`domicilio`) REFERENCES `domicilio` (`cod_domicilio`),
  CONSTRAINT `FK_titular_pub` FOREIGN KEY (`cod_pub`) REFERENCES `pub` (`cod_pub`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titular`
--

LOCK TABLES `titular` WRITE;
/*!40000 ALTER TABLE `titular` DISABLE KEYS */;
/*!40000 ALTER TABLE `titular` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-11 13:52:20
