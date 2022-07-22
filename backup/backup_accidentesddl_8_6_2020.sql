-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: accidentesddl
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
-- Table structure for table `tblaccidente`
--

DROP TABLE IF EXISTS `tblaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblaccidente` (
  `codigo` int(2) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `empleado` varchar(12) NOT NULL,
  `tipoAccidente` int(3) NOT NULL,
  `categoria` varchar(20) NOT NULL,
  `incapacidad` varchar(30) NOT NULL,
  `fechaInicial` date NOT NULL,
  `fechaFinal` date NOT NULL,
  `observaciones` mediumtext DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tblAccidente_tblEmpleado` (`empleado`),
  KEY `FK_tblAccidente_tbltipoAccidente` (`tipoAccidente`),
  KEY `FK_tblAccidente_tblCategoria` (`categoria`),
  CONSTRAINT `FK_tblAccidente_tblCategoria` FOREIGN KEY (`categoria`) REFERENCES `tblcategoria` (`codigo`),
  CONSTRAINT `FK_tblAccidente_tblEmpleado` FOREIGN KEY (`empleado`) REFERENCES `tblempleado` (`id`),
  CONSTRAINT `FK_tblAccidente_tbltipoAccidente` FOREIGN KEY (`tipoAccidente`) REFERENCES `tbltipoaccidente` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaccidente`
--

LOCK TABLES `tblaccidente` WRITE;
/*!40000 ALTER TABLE `tblaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblaccidente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblaccionpreventiva`
--

DROP TABLE IF EXISTS `tblaccionpreventiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblaccionpreventiva` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaccionpreventiva`
--

LOCK TABLES `tblaccionpreventiva` WRITE;
/*!40000 ALTER TABLE `tblaccionpreventiva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblaccionpreventiva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblaccionpreventivaaccidente`
--

DROP TABLE IF EXISTS `tblaccionpreventivaaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblaccionpreventivaaccidente` (
  `codigoAccionPreventiva` int(3) NOT NULL,
  `codigoAccidente` int(2) NOT NULL,
  PRIMARY KEY (`codigoAccionPreventiva`,`codigoAccidente`),
  KEY `FK_tblAccionpreventivaAccidente_tblAccidente` (`codigoAccidente`),
  CONSTRAINT `FK_tblAccionpreventivaAccidente_tblAccidente` FOREIGN KEY (`codigoAccidente`) REFERENCES `tblaccidente` (`codigo`),
  CONSTRAINT `FK_tblAccionpreventivaAccidente_tblAccionPreventiva` FOREIGN KEY (`codigoAccionPreventiva`) REFERENCES `tblaccionpreventiva` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaccionpreventivaaccidente`
--

LOCK TABLES `tblaccionpreventivaaccidente` WRITE;
/*!40000 ALTER TABLE `tblaccionpreventivaaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblaccionpreventivaaccidente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblarea`
--

DROP TABLE IF EXISTS `tblarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblarea` (
  `codigo` int(6) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblarea`
--

LOCK TABLES `tblarea` WRITE;
/*!40000 ALTER TABLE `tblarea` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcargo`
--

DROP TABLE IF EXISTS `tblcargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcargo` (
  `codigo` int(5) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) DEFAULT NULL,
  `area` int(3) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tblCargo_tblArea` (`area`),
  CONSTRAINT `FK_tblCargo_tblArea` FOREIGN KEY (`area`) REFERENCES `tblarea` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcargo`
--

LOCK TABLES `tblcargo` WRITE;
/*!40000 ALTER TABLE `tblcargo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcategoria`
--

DROP TABLE IF EXISTS `tblcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcategoria` (
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcategoria`
--

LOCK TABLES `tblcategoria` WRITE;
/*!40000 ALTER TABLE `tblcategoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcategoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempleado`
--

DROP TABLE IF EXISTS `tblempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblempleado` (
  `id` varchar(12) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `cargo` int(5) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `genero` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tblEmpleado_tblCargo` (`cargo`),
  KEY `FK_tblEmpleado_tblGenero` (`genero`),
  CONSTRAINT `FK_tblEmpleado_tblCargo` FOREIGN KEY (`cargo`) REFERENCES `tblcargo` (`codigo`),
  CONSTRAINT `FK_tblEmpleado_tblGenero` FOREIGN KEY (`genero`) REFERENCES `tblgenero` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempleado`
--

LOCK TABLES `tblempleado` WRITE;
/*!40000 ALTER TABLE `tblempleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempleadoobra`
--

DROP TABLE IF EXISTS `tblempleadoobra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblempleadoobra` (
  `codigoEmpleado` varchar(12) NOT NULL,
  `codigoObra` int(3) NOT NULL,
  `fechaInicial` date NOT NULL,
  `fechaFinal` date NOT NULL,
  PRIMARY KEY (`codigoEmpleado`,`codigoObra`),
  KEY `FK_tblEmpleadoObra_tblObra` (`codigoObra`),
  CONSTRAINT `FK_tblEmpleadoObra_tblEmpleado` FOREIGN KEY (`codigoEmpleado`) REFERENCES `tblempleado` (`id`),
  CONSTRAINT `FK_tblEmpleadoObra_tblObra` FOREIGN KEY (`codigoObra`) REFERENCES `tblobra` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempleadoobra`
--

LOCK TABLES `tblempleadoobra` WRITE;
/*!40000 ALTER TABLE `tblempleadoobra` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblempleadoobra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblenfermedad`
--

DROP TABLE IF EXISTS `tblenfermedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblenfermedad` (
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblenfermedad`
--

LOCK TABLES `tblenfermedad` WRITE;
/*!40000 ALTER TABLE `tblenfermedad` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblenfermedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblenfermedadaccidente`
--

DROP TABLE IF EXISTS `tblenfermedadaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblenfermedadaccidente` (
  `codigoEnfermedad` varchar(6) NOT NULL,
  `codigoAccidente` int(2) NOT NULL,
  PRIMARY KEY (`codigoEnfermedad`,`codigoAccidente`),
  KEY `FK_tblEnfermedadAccidente_tblAccidente` (`codigoAccidente`),
  CONSTRAINT `FK_tblEnfermedadAccidente_tblAccidente` FOREIGN KEY (`codigoAccidente`) REFERENCES `tblaccidente` (`codigo`),
  CONSTRAINT `FK_tblEnfermedadAccidente_tblEnfermedad` FOREIGN KEY (`codigoEnfermedad`) REFERENCES `tblenfermedad` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblenfermedadaccidente`
--

LOCK TABLES `tblenfermedadaccidente` WRITE;
/*!40000 ALTER TABLE `tblenfermedadaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblenfermedadaccidente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblgenero`
--

DROP TABLE IF EXISTS `tblgenero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblgenero` (
  `codigo` varchar(15) NOT NULL,
  `nombre` varchar(17) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblgenero`
--

LOCK TABLES `tblgenero` WRITE;
/*!40000 ALTER TABLE `tblgenero` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblgenero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbllesion`
--

DROP TABLE IF EXISTS `tbllesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbllesion` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbllesion`
--

LOCK TABLES `tbllesion` WRITE;
/*!40000 ALTER TABLE `tbllesion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbllesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbllesionaccidente`
--

DROP TABLE IF EXISTS `tbllesionaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbllesionaccidente` (
  `codigoLesion` int(3) NOT NULL,
  `codigoAccidente` int(2) NOT NULL,
  PRIMARY KEY (`codigoLesion`,`codigoAccidente`),
  KEY `FK_tblLesionAccidente_tblAccidente` (`codigoAccidente`),
  CONSTRAINT `FK_tblLesionAccidente_tblAccidente` FOREIGN KEY (`codigoAccidente`) REFERENCES `tblaccidente` (`codigo`),
  CONSTRAINT `FK_tblLesionAccidente_tblLesion` FOREIGN KEY (`codigoLesion`) REFERENCES `tbllesion` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbllesionaccidente`
--

LOCK TABLES `tbllesionaccidente` WRITE;
/*!40000 ALTER TABLE `tbllesionaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbllesionaccidente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblobra`
--

DROP TABLE IF EXISTS `tblobra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblobra` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `encargado` varchar(12) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblobra`
--

LOCK TABLES `tblobra` WRITE;
/*!40000 ALTER TABLE `tblobra` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblobra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpartecuerpo`
--

DROP TABLE IF EXISTS `tblpartecuerpo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpartecuerpo` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpartecuerpo`
--

LOCK TABLES `tblpartecuerpo` WRITE;
/*!40000 ALTER TABLE `tblpartecuerpo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpartecuerpo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpartecuerpoaccidente`
--

DROP TABLE IF EXISTS `tblpartecuerpoaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpartecuerpoaccidente` (
  `codigoParteCuerpo` int(3) NOT NULL,
  `codigoAccidente` int(2) NOT NULL,
  PRIMARY KEY (`codigoParteCuerpo`,`codigoAccidente`),
  KEY `FK_tblPartecuerpoAccidente_tblAccidente` (`codigoAccidente`),
  CONSTRAINT `FK_tblPartecuerpoAccidente_tblAccidente` FOREIGN KEY (`codigoAccidente`) REFERENCES `tblaccidente` (`codigo`),
  CONSTRAINT `FK_tblPartecuerpoAccidente_tblParteCuerpo` FOREIGN KEY (`codigoParteCuerpo`) REFERENCES `tblpartecuerpo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpartecuerpoaccidente`
--

LOCK TABLES `tblpartecuerpoaccidente` WRITE;
/*!40000 ALTER TABLE `tblpartecuerpoaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpartecuerpoaccidente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipoaccidente`
--

DROP TABLE IF EXISTS `tbltipoaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltipoaccidente` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipoaccidente`
--

LOCK TABLES `tbltipoaccidente` WRITE;
/*!40000 ALTER TABLE `tbltipoaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltipoaccidente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08 12:56:14
