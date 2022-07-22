-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: empleadosddl
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
-- Table structure for table `tblarea`
--

DROP TABLE IF EXISTS `tblarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblarea` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblarea`
--

LOCK TABLES `tblarea` WRITE;
/*!40000 ALTER TABLE `tblarea` DISABLE KEYS */;
INSERT INTO `tblarea` VALUES (1,'financiero'),(2,'administracion'),(3,'produccion'),(4,'direccion general'),(5,'Administración y Recursos Humanos'),(6,'Informática.');
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
  `Nombre` varchar(50) NOT NULL,
  `area` int(3) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `FK_tblCargo_tblArea` (`area`),
  CONSTRAINT `FK_tblCargo_tblArea` FOREIGN KEY (`area`) REFERENCES `tblarea` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcargo`
--

LOCK TABLES `tblcargo` WRITE;
/*!40000 ALTER TABLE `tblcargo` DISABLE KEYS */;
INSERT INTO `tblcargo` VALUES (1,'cajero',1),(2,'gerente',2),(3,'operario',3),(5,'gerente',2),(7,'ceo',NULL),(8,'cmo',NULL),(9,'cco',NULL);
/*!40000 ALTER TABLE `tblcargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblciudad`
--

DROP TABLE IF EXISTS `tblciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblciudad` (
  `Codigo` varchar(6) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Departamento` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `FK_tblCiudad_tblDepartamento` (`Departamento`),
  CONSTRAINT `FK_tblCiudad_tblDepartamento` FOREIGN KEY (`Departamento`) REFERENCES `tbldepartamento` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblciudad`
--

LOCK TABLES `tblciudad` WRITE;
/*!40000 ALTER TABLE `tblciudad` DISABLE KEYS */;
INSERT INTO `tblciudad` VALUES ('123456','rionegro','123'),('124556','ceja','123'),('458399','armenia','789'),('465839','puerto rico','345'),('678954','carmen','123'),('778574','medellin','123');
/*!40000 ALTER TABLE `tblciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldepartamento`
--

DROP TABLE IF EXISTS `tbldepartamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbldepartamento` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldepartamento`
--

LOCK TABLES `tbldepartamento` WRITE;
/*!40000 ALTER TABLE `tbldepartamento` DISABLE KEYS */;
INSERT INTO `tbldepartamento` VALUES ('123','antioquia'),('345','cundinamarca'),('777','antioquia'),('789','risaralda');
/*!40000 ALTER TABLE `tbldepartamento` ENABLE KEYS */;
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
  `Direccion` varchar(70) NOT NULL,
  `Ciudad` varchar(6) NOT NULL,
  `EmailPersonal` varchar(70) DEFAULT NULL,
  `EmailInstitucional` varchar(70) DEFAULT NULL,
  `telefonoFijo` varchar(20) DEFAULT NULL,
  `telefonoMovil` varchar(15) DEFAULT NULL,
  `salarioBasico` int(9) DEFAULT NULL,
  `fechaNacimiento` date NOT NULL,
  `cargo` int(3) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_tblEmpleado_tblCiudad` (`Ciudad`),
  KEY `FK_tblEmpleado_tblCargo` (`cargo`),
  CONSTRAINT `FK_tblEmpleado_tblCargo` FOREIGN KEY (`cargo`) REFERENCES `tblcargo` (`Codigo`),
  CONSTRAINT `FK_tblEmpleado_tblCiudad` FOREIGN KEY (`Ciudad`) REFERENCES `tblciudad` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempleado`
--

LOCK TABLES `tblempleado` WRITE;
/*!40000 ALTER TABLE `tblempleado` DISABLE KEYS */;
INSERT INTO `tblempleado` VALUES ('12345556','jose','peña','calle a carr a','123456',NULL,NULL,'7475333',NULL,120000,'2004-10-10',2),('143','juan','torres','calle-a','123456','juan@hotmial.com',NULL,'3455',NULL,100000,'0000-00-00',3),('1555','tomas','ramires','calle-b','124556','tomas@hotmial.com',NULL,'1111','6554433',8900000,'1974-09-02',5);
/*!40000 ALTER TABLE `tblempleado` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-19 10:39:01
