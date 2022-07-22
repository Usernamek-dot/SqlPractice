-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: areasdeportivasddl
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
-- Table structure for table `tblareadeportiva`
--

DROP TABLE IF EXISTS `tblareadeportiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblareadeportiva` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `caracteristicas` mediumtext DEFAULT NULL,
  `valorTurno` int(6) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblareadeportiva`
--

LOCK TABLES `tblareadeportiva` WRITE;
/*!40000 ALTER TABLE `tblareadeportiva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblareadeportiva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblareadeportivaartdeportivo`
--

DROP TABLE IF EXISTS `tblareadeportivaartdeportivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblareadeportivaartdeportivo` (
  `codigoArea` int(3) NOT NULL,
  `codigoArticulo` int(4) NOT NULL,
  PRIMARY KEY (`codigoArea`,`codigoArticulo`),
  KEY `FK_tblAreaDeportivaArtdeportivo_tblArtDeportivo` (`codigoArticulo`),
  CONSTRAINT `FK_tblAreaDeportivaArtdeportivo_tblArtDeportivo` FOREIGN KEY (`codigoArticulo`) REFERENCES `tblartdeportivo` (`codigo`),
  CONSTRAINT `FK_tblAreadeportivaArtdeportivo_codigoArea` FOREIGN KEY (`codigoArea`) REFERENCES `tblareadeportiva` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblareadeportivaartdeportivo`
--

LOCK TABLES `tblareadeportivaartdeportivo` WRITE;
/*!40000 ALTER TABLE `tblareadeportivaartdeportivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblareadeportivaartdeportivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblartdeportivo`
--

DROP TABLE IF EXISTS `tblartdeportivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblartdeportivo` (
  `codigo` int(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `valorArt` int(6) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblartdeportivo`
--

LOCK TABLES `tblartdeportivo` WRITE;
/*!40000 ALTER TABLE `tblartdeportivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblartdeportivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcategoria`
--

DROP TABLE IF EXISTS `tblcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcategoria` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
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
-- Table structure for table `tbldeporte`
--

DROP TABLE IF EXISTS `tbldeporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbldeporte` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `area` int(3) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tblDeporte_tblAreaDeportiva` (`area`),
  CONSTRAINT `FK_tblDeporte_tblAreaDeportiva` FOREIGN KEY (`area`) REFERENCES `tblareadeportiva` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldeporte`
--

LOCK TABLES `tbldeporte` WRITE;
/*!40000 ALTER TABLE `tbldeporte` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldeporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblhorarioareadeportiva`
--

DROP TABLE IF EXISTS `tblhorarioareadeportiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblhorarioareadeportiva` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `area` int(3) NOT NULL,
  `dia` varchar(9) NOT NULL,
  `horario` varchar(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tblHorarioAreadeportiva_tblAreaDeportiva` (`area`),
  CONSTRAINT `FK_tblHorarioAreadeportiva_tblAreaDeportiva` FOREIGN KEY (`area`) REFERENCES `tblareadeportiva` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblhorarioareadeportiva`
--

LOCK TABLES `tblhorarioareadeportiva` WRITE;
/*!40000 ALTER TABLE `tblhorarioareadeportiva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblhorarioareadeportiva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpersonalaseo`
--

DROP TABLE IF EXISTS `tblpersonalaseo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpersonalaseo` (
  `id` varchar(12) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `labores` mediumtext NOT NULL,
  `areaDeportiva` int(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tblPersonalAseo_tblAreaDeportiva` (`areaDeportiva`),
  CONSTRAINT `FK_tblPersonalAseo_tblAreaDeportiva` FOREIGN KEY (`areaDeportiva`) REFERENCES `tblareadeportiva` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpersonalaseo`
--

LOCK TABLES `tblpersonalaseo` WRITE;
/*!40000 ALTER TABLE `tblpersonalaseo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpersonalaseo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblreserva`
--

DROP TABLE IF EXISTS `tblreserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreserva` (
  `codigo` int(6) NOT NULL AUTO_INCREMENT,
  `socio` varchar(12) DEFAULT NULL,
  `areaDeportiva` int(3) NOT NULL,
  `fecha` date NOT NULL,
  `horaInicio` time NOT NULL,
  `horaFin` time NOT NULL,
  `valorTurno` int(6) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tblReserva_tblSocio` (`socio`),
  KEY `FK_tblReserva_tblAreaDeportiva` (`areaDeportiva`),
  CONSTRAINT `FK_tblReserva_tblAreaDeportiva` FOREIGN KEY (`areaDeportiva`) REFERENCES `tblareadeportiva` (`codigo`),
  CONSTRAINT `FK_tblReserva_tblSocio` FOREIGN KEY (`socio`) REFERENCES `tblsocio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreserva`
--

LOCK TABLES `tblreserva` WRITE;
/*!40000 ALTER TABLE `tblreserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblreserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblreservaartdeportivo`
--

DROP TABLE IF EXISTS `tblreservaartdeportivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreservaartdeportivo` (
  `codigoReserva` int(6) NOT NULL,
  `codigoArticulo` int(4) NOT NULL,
  `valorArticulo` int(6) NOT NULL,
  PRIMARY KEY (`codigoReserva`,`codigoArticulo`),
  KEY `FK_tblReservaArtdeportivo_tblArtDeportivo` (`codigoArticulo`),
  CONSTRAINT `FK_tblReservaArtdeportivo_tblArtDeportivo` FOREIGN KEY (`codigoArticulo`) REFERENCES `tblartdeportivo` (`codigo`),
  CONSTRAINT `FK_tblReservaArtdeportivo_tblReserva` FOREIGN KEY (`codigoReserva`) REFERENCES `tblreserva` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreservaartdeportivo`
--

LOCK TABLES `tblreservaartdeportivo` WRITE;
/*!40000 ALTER TABLE `tblreservaartdeportivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblreservaartdeportivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsocio`
--

DROP TABLE IF EXISTS `tblsocio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsocio` (
  `id` varchar(12) NOT NULL,
  `nombre` varchar(70) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefonoFijo` varchar(20) DEFAULT NULL,
  `telefonoMovil` varchar(15) DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  `categoria` int(3) NOT NULL,
  `valorCargoFijoMes` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tblSocio_tblCategoria` (`categoria`),
  CONSTRAINT `FK_tblSocio_tblCategoria` FOREIGN KEY (`categoria`) REFERENCES `tblcategoria` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsocio`
--

LOCK TABLES `tblsocio` WRITE;
/*!40000 ALTER TABLE `tblsocio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblsocio` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08 13:04:18
