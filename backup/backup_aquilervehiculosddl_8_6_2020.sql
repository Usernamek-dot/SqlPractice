-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: alquilervehiculosddl
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
  `codigo` int(4) NOT NULL AUTO_INCREMENT,
  `cliente` varchar(12) NOT NULL,
  `formaPago` varchar(3) NOT NULL,
  `observaciones` mediumtext DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tblAlquiler_tblCliente` (`cliente`),
  KEY `FK_tblAlquiler_tblFormaPago` (`formaPago`),
  CONSTRAINT `FK_tblAlquiler_tblCliente` FOREIGN KEY (`cliente`) REFERENCES `tblcliente` (`id`),
  CONSTRAINT `FK_tblAlquiler_tblFormaPago` FOREIGN KEY (`formaPago`) REFERENCES `tblformapago` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblalquiler`
--

LOCK TABLES `tblalquiler` WRITE;
/*!40000 ALTER TABLE `tblalquiler` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblalquiler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblalquilervehiculo`
--

DROP TABLE IF EXISTS `tblalquilervehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblalquilervehiculo` (
  `codigoAlquiler` int(4) NOT NULL,
  `codigoVehiculo` varchar(19) NOT NULL,
  `kilometroinicial` int(4) DEFAULT NULL,
  `kilometrofinal` int(4) DEFAULT NULL,
  `FechaDevolucion` date DEFAULT NULL,
  `valorcargofijo` int(6) DEFAULT NULL,
  `valorkilometro` int(6) DEFAULT NULL,
  PRIMARY KEY (`codigoAlquiler`,`codigoVehiculo`),
  KEY `FK_tblAlquilerVehiculo_tblVehiculo` (`codigoVehiculo`),
  CONSTRAINT `FK_tblAlquilerVehiculo_tblAlquiler` FOREIGN KEY (`codigoAlquiler`) REFERENCES `tblalquiler` (`codigo`),
  CONSTRAINT `FK_tblAlquilerVehiculo_tblVehiculo` FOREIGN KEY (`codigoVehiculo`) REFERENCES `tblvehiculo` (`placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblalquilervehiculo`
--

LOCK TABLES `tblalquilervehiculo` WRITE;
/*!40000 ALTER TABLE `tblalquilervehiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblalquilervehiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcliente`
--

DROP TABLE IF EXISTS `tblcliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcliente` (
  `id` varchar(12) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(70) DEFAULT NULL,
  `telefonoFijo` varchar(20) DEFAULT NULL,
  `telefonoMovil` varchar(15) DEFAULT NULL,
  `codeudor` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tblCliente_tblCoudeudor` (`codeudor`),
  CONSTRAINT `FK_tblCliente_tblCoudeudor` FOREIGN KEY (`codeudor`) REFERENCES `tblcoudeudor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcliente`
--

LOCK TABLES `tblcliente` WRITE;
/*!40000 ALTER TABLE `tblcliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcolor`
--

DROP TABLE IF EXISTS `tblcolor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcolor` (
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcolor`
--

LOCK TABLES `tblcolor` WRITE;
/*!40000 ALTER TABLE `tblcolor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcolor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcoudeudor`
--

DROP TABLE IF EXISTS `tblcoudeudor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcoudeudor` (
  `id` varchar(12) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefonoFijo` varchar(20) DEFAULT NULL,
  `telefonoMovil` varchar(15) DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcoudeudor`
--

LOCK TABLES `tblcoudeudor` WRITE;
/*!40000 ALTER TABLE `tblcoudeudor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcoudeudor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblformapago`
--

DROP TABLE IF EXISTS `tblformapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblformapago` (
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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
  `codigo` varchar(8) NOT NULL,
  `nombre` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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
  `codigo` varchar(2) NOT NULL,
  `nombre` varchar(7) NOT NULL,
  `tipoVehiculo` varchar(3) DEFAULT NULL,
  `marca` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tblModelo_tblTipoVehiculo` (`tipoVehiculo`),
  KEY `FK_tblModelo_tblMarca` (`marca`),
  CONSTRAINT `FK_tblModelo_tblMarca` FOREIGN KEY (`marca`) REFERENCES `tblmarca` (`codigo`),
  CONSTRAINT `FK_tblModelo_tblTipoVehiculo` FOREIGN KEY (`tipoVehiculo`) REFERENCES `tbltipovehiculo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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
  `placa` varchar(19) NOT NULL,
  `modelo` varchar(2) DEFAULT NULL,
  `color` varchar(6) DEFAULT NULL,
  `numMotor` varchar(7) DEFAULT NULL,
  `numChasis` varchar(8) DEFAULT NULL,
  `caracteristicar` mediumtext DEFAULT NULL,
  `valorCargoFijo` int(6) DEFAULT NULL,
  `valorKilometroRecorrido` int(6) DEFAULT NULL,
  PRIMARY KEY (`placa`),
  KEY `FK_tblVehiculo_tblColor` (`color`),
  KEY `FK_tblVehiculo_tblModelo` (`modelo`),
  CONSTRAINT `FK_tblVehiculo_tblColor` FOREIGN KEY (`color`) REFERENCES `tblcolor` (`codigo`),
  CONSTRAINT `FK_tblVehiculo_tblModelo` FOREIGN KEY (`modelo`) REFERENCES `tblmodelo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
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

-- Dump completed on 2020-06-08 13:00:52
