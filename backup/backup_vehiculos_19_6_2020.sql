-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: vehiculos
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
-- Table structure for table `tblalquiler`
--

DROP TABLE IF EXISTS `tblalquiler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblalquiler` (
  `Codigo` int(4) NOT NULL AUTO_INCREMENT,
  `Cliente` varchar(12) NOT NULL,
  `Forma de Pago` varchar(3) NOT NULL,
  `Observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblAlquiler_tblCliente_idx` (`Cliente`),
  CONSTRAINT `fk_tblAlquiler_tblCliente` FOREIGN KEY (`Cliente`) REFERENCES `tblcliente` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblalquiler`
--

LOCK TABLES `tblalquiler` WRITE;
/*!40000 ALTER TABLE `tblalquiler` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblalquiler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcliente`
--

DROP TABLE IF EXISTS `tblcliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcliente` (
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Email` varchar(70) DEFAULT NULL,
  `Telefono Fijo` varchar(20) DEFAULT NULL,
  `Telefono Movil` varchar(15) DEFAULT NULL,
  `Codeudor` varchar(12) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcliente`
--

LOCK TABLES `tblcliente` WRITE;
/*!40000 ALTER TABLE `tblcliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcodeudor`
--

DROP TABLE IF EXISTS `tblcodeudor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcodeudor` (
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Telefono Fijo` varchar(20) DEFAULT NULL,
  `Telefono Movil` varchar(15) NOT NULL,
  `Email` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcodeudor`
--

LOCK TABLES `tblcodeudor` WRITE;
/*!40000 ALTER TABLE `tblcodeudor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcodeudor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcolor`
--

DROP TABLE IF EXISTS `tblcolor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcolor` (
  `Codigo` varchar(6) NOT NULL,
  `Nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcolor`
--

LOCK TABLES `tblcolor` WRITE;
/*!40000 ALTER TABLE `tblcolor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcolor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblformapago`
--

DROP TABLE IF EXISTS `tblformapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblformapago` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblformapago`
--

LOCK TABLES `tblformapago` WRITE;
/*!40000 ALTER TABLE `tblformapago` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblformapago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmarca`
--

DROP TABLE IF EXISTS `tblmarca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmarca` (
  `Codigo` varchar(8) NOT NULL,
  `Marca` varchar(7) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmarca`
--

LOCK TABLES `tblmarca` WRITE;
/*!40000 ALTER TABLE `tblmarca` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmarca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmodelo`
--

DROP TABLE IF EXISTS `tblmodelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmodelo` (
  `Codigo` varchar(2) NOT NULL,
  `Nombre` varchar(7) NOT NULL,
  `Tipo de Vehiculo` varchar(3) NOT NULL,
  `Marca` varchar(8) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmodelo`
--

LOCK TABLES `tblmodelo` WRITE;
/*!40000 ALTER TABLE `tblmodelo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmodelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipovehiculo`
--

DROP TABLE IF EXISTS `tbltipovehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltipovehiculo` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipovehiculo`
--

LOCK TABLES `tbltipovehiculo` WRITE;
/*!40000 ALTER TABLE `tbltipovehiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltipovehiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblvehiculo`
--

DROP TABLE IF EXISTS `tblvehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblvehiculo` (
  `Placa` varchar(19) NOT NULL,
  `Modelo` varchar(2) NOT NULL,
  `Color` varchar(6) NOT NULL,
  `Num de Motor` varchar(7) NOT NULL,
  `Num de Chasis` varchar(8) NOT NULL,
  `Caracteristicas` varchar(200) DEFAULT NULL,
  `Valor cargo fijo` int(6) DEFAULT NULL,
  `Valor kilometro recorrido` int(6) DEFAULT NULL,
  PRIMARY KEY (`Placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblvehiculo`
--

LOCK TABLES `tblvehiculo` WRITE;
/*!40000 ALTER TABLE `tblvehiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblvehiculo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-19 10:45:32
