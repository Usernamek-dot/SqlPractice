-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: accidentes
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
  `Codigo` int(2) NOT NULL AUTO_INCREMENT,
  `Fecha` datetime NOT NULL,
  `Empleado` varchar(12) NOT NULL,
  `TipoAccidente` int(3) NOT NULL,
  `Categoria` varchar(20) NOT NULL,
  `Incapacidad` varchar(30) NOT NULL,
  `FechaInicial` date NOT NULL,
  `FechaFinal` date NOT NULL,
  `Observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblAccidente_tblTipoAccidente1_idx` (`TipoAccidente`),
  KEY `fk_tblAccidente_tblEmpleado1_idx` (`Empleado`),
  CONSTRAINT `fk_tblAccidente_tblEmpleado1` FOREIGN KEY (`Empleado`) REFERENCES `tblempleado` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblAccidente_tblTipoAccidente1` FOREIGN KEY (`TipoAccidente`) REFERENCES `tbltipoaccidente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` int(3) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodigoAccidente` int(2) NOT NULL,
  `CodigoAccionPreventiva` int(3) NOT NULL,
  PRIMARY KEY (`CodigoAccidente`,`CodigoAccionPreventiva`),
  KEY `fk_tblAccionPreventivaAccidente_tblAccidente1_idx` (`CodigoAccidente`),
  KEY `fk_tblAccionPreventivaAccidente_tblAccionPreventiva1_idx` (`CodigoAccionPreventiva`),
  CONSTRAINT `fk_tblAccionPreventivaAccidente_tblAccidente1` FOREIGN KEY (`CodigoAccidente`) REFERENCES `tblaccidente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblAccionPreventivaAccidente_tblAccionPreventiva1` FOREIGN KEY (`CodigoAccionPreventiva`) REFERENCES `tblaccionpreventiva` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` int(3) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` int(5) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(60) NOT NULL,
  `Area` int(3) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblCargo_tblArea1_idx` (`Area`),
  CONSTRAINT `fk_tblCargo_tblArea1` FOREIGN KEY (`Area`) REFERENCES `tblarea` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` int(6) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcategoria`
--

LOCK TABLES `tblcategoria` WRITE;
/*!40000 ALTER TABLE `tblcategoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcategoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcategoriaaccidente`
--

DROP TABLE IF EXISTS `tblcategoriaaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcategoriaaccidente` (
  `Accidente` int(2) NOT NULL,
  `Categoria` int(6) NOT NULL,
  PRIMARY KEY (`Accidente`,`Categoria`),
  KEY `fk_tblCategoriaAccidente_tblAccidente1_idx` (`Accidente`),
  KEY `fk_tblCategoriaAccidente_tblCategoria1_idx` (`Categoria`),
  CONSTRAINT `fk_tblCategoriaAccidente_tblAccidente1` FOREIGN KEY (`Accidente`) REFERENCES `tblaccidente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblCategoriaAccidente_tblCategoria1` FOREIGN KEY (`Categoria`) REFERENCES `tblcategoria` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcategoriaaccidente`
--

LOCK TABLES `tblcategoriaaccidente` WRITE;
/*!40000 ALTER TABLE `tblcategoriaaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcategoriaaccidente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempleado`
--

DROP TABLE IF EXISTS `tblempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblempleado` (
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Cargo` int(5) NOT NULL,
  `Fecha Nacimiento` date NOT NULL,
  `Genero` varchar(15) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_tblEmpleado_tblGenero_idx` (`Genero`),
  KEY `fk_tblEmpleado_tblCargo1_idx` (`Cargo`),
  CONSTRAINT `fk_tblEmpleado_tblCargo1` FOREIGN KEY (`Cargo`) REFERENCES `tblcargo` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpleado_tblGenero` FOREIGN KEY (`Genero`) REFERENCES `tblgenero` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Empleado` varchar(12) NOT NULL,
  `Obra` int(3) NOT NULL,
  `Fecha inicial` date NOT NULL,
  `Fecha final` date NOT NULL,
  PRIMARY KEY (`Empleado`,`Obra`),
  KEY `fk_tblEmpleadoObra_tblEmpleado1_idx` (`Empleado`),
  KEY `fk_tblEmpleadoObra_tblObra1_idx` (`Obra`),
  CONSTRAINT `fk_tblEmpleadoObra_tblEmpleado1` FOREIGN KEY (`Empleado`) REFERENCES `tblempleado` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpleadoObra_tblObra1` FOREIGN KEY (`Obra`) REFERENCES `tblobra` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` varchar(6) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodigoAccidente` int(2) NOT NULL,
  `CodigoEnfermedad` varchar(6) NOT NULL,
  PRIMARY KEY (`CodigoAccidente`,`CodigoEnfermedad`),
  KEY `fk_tblEnfermedadAccidente_tblAccidente1_idx` (`CodigoAccidente`),
  KEY `fk_tblEnfermedadAccidente_tblEnfermedad1_idx` (`CodigoEnfermedad`),
  CONSTRAINT `fk_tblEnfermedadAccidente_tblAccidente1` FOREIGN KEY (`CodigoAccidente`) REFERENCES `tblaccidente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEnfermedadAccidente_tblEnfermedad1` FOREIGN KEY (`CodigoEnfermedad`) REFERENCES `tblenfermedad` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` varchar(15) NOT NULL,
  `Nombre` varchar(17) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` int(3) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(70) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodigoAccidente` int(2) NOT NULL,
  `CodigoLesion` int(3) NOT NULL,
  PRIMARY KEY (`CodigoAccidente`,`CodigoLesion`),
  KEY `fk_tblLesionAccidente_tblAccidente1_idx` (`CodigoAccidente`),
  KEY `fk_tblLesionAccidente_tblLesion1_idx` (`CodigoLesion`),
  CONSTRAINT `fk_tblLesionAccidente_tblAccidente1` FOREIGN KEY (`CodigoAccidente`) REFERENCES `tblaccidente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblLesionAccidente_tblLesion1` FOREIGN KEY (`CodigoLesion`) REFERENCES `tbllesion` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Codigo` int(3) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Encargado` varchar(12) NOT NULL,
  `Direccion` varchar(70) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblobra`
--

LOCK TABLES `tblobra` WRITE;
/*!40000 ALTER TABLE `tblobra` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblobra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpartedecuerpo`
--

DROP TABLE IF EXISTS `tblpartedecuerpo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpartedecuerpo` (
  `Codigo` int(3) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpartedecuerpo`
--

LOCK TABLES `tblpartedecuerpo` WRITE;
/*!40000 ALTER TABLE `tblpartedecuerpo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpartedecuerpo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpartedecuerpoaccidente`
--

DROP TABLE IF EXISTS `tblpartedecuerpoaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpartedecuerpoaccidente` (
  `CodigoAccidente` int(2) NOT NULL,
  `CodigoPartedeCuerpo` int(3) NOT NULL,
  PRIMARY KEY (`CodigoAccidente`,`CodigoPartedeCuerpo`),
  KEY `fk_tblParteDeCuerpoAccidente_tblAccidente1_idx` (`CodigoAccidente`),
  KEY `fk_tblParteDeCuerpoAccidente_tblParteDeCuerpo1_idx` (`CodigoPartedeCuerpo`),
  CONSTRAINT `fk_tblParteDeCuerpoAccidente_tblAccidente1` FOREIGN KEY (`CodigoAccidente`) REFERENCES `tblaccidente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblParteDeCuerpoAccidente_tblParteDeCuerpo1` FOREIGN KEY (`CodigoPartedeCuerpo`) REFERENCES `tblpartedecuerpo` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpartedecuerpoaccidente`
--

LOCK TABLES `tblpartedecuerpoaccidente` WRITE;
/*!40000 ALTER TABLE `tblpartedecuerpoaccidente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpartedecuerpoaccidente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipoaccidente`
--

DROP TABLE IF EXISTS `tbltipoaccidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltipoaccidente` (
  `Codigo` int(3) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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

-- Dump completed on 2020-06-05 10:02:00
