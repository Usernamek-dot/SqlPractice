-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: reserva_ddl
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
-- Table structure for table `tbl_ciudad`
--

DROP TABLE IF EXISTS `tbl_ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_ciudad` (
  `codigo` varchar(4) NOT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  `departamento` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tbl_ciudad_tbl_departamento` (`departamento`),
  CONSTRAINT `FK_tbl_ciudad_tbl_departamento` FOREIGN KEY (`departamento`) REFERENCES `tbl_departamento` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ciudad`
--

LOCK TABLES `tbl_ciudad` WRITE;
/*!40000 ALTER TABLE `tbl_ciudad` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_cliente`
--

DROP TABLE IF EXISTS `tbl_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_cliente` (
  `codigo` varchar(5) NOT NULL,
  `doc_id` varchar(15) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellido` varchar(30) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `ciudad` varchar(4) DEFAULT NULL,
  `correo_electronico` varchar(70) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado_usuario` varchar(2) DEFAULT NULL,
  `tipo_usuario` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tbl_usuario_tbl_ciudad` (`ciudad`),
  KEY `FK_tbl_usuario_tbl_estado_usuario` (`estado_usuario`),
  KEY `FK_tbl_usuario_tbl_tipo_usuario` (`tipo_usuario`),
  CONSTRAINT `FK_tbl_usuario_tbl_ciudad` FOREIGN KEY (`ciudad`) REFERENCES `tbl_ciudad` (`codigo`),
  CONSTRAINT `FK_tbl_usuario_tbl_estado_usuario` FOREIGN KEY (`estado_usuario`) REFERENCES `tbl_cliente` (`codigo`),
  CONSTRAINT `FK_tbl_usuario_tbl_tipo_usuario` FOREIGN KEY (`tipo_usuario`) REFERENCES `tbl_tipo_usuario` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cliente`
--

LOCK TABLES `tbl_cliente` WRITE;
/*!40000 ALTER TABLE `tbl_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_departamento`
--

DROP TABLE IF EXISTS `tbl_departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_departamento` (
  `codigo` varchar(2) NOT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_departamento`
--

LOCK TABLES `tbl_departamento` WRITE;
/*!40000 ALTER TABLE `tbl_departamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_estado_reserva`
--

DROP TABLE IF EXISTS `tbl_estado_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_estado_reserva` (
  `codigo` varchar(5) NOT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_estado_reserva`
--

LOCK TABLES `tbl_estado_reserva` WRITE;
/*!40000 ALTER TABLE `tbl_estado_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_estado_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_estado_usuario`
--

DROP TABLE IF EXISTS `tbl_estado_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_estado_usuario` (
  `codigo` varchar(12) NOT NULL,
  `descripcion` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_estado_usuario`
--

LOCK TABLES `tbl_estado_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_estado_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_estado_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_reserva`
--

DROP TABLE IF EXISTS `tbl_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_reserva` (
  `consecutivo` int(11) NOT NULL,
  `fecha_reserva` date DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `usuario` varchar(5) DEFAULT NULL,
  `tipo_reserva` varchar(5) DEFAULT NULL,
  `estado_reserva` varchar(3) DEFAULT NULL,
  `costo` int(11) NOT NULL,
  PRIMARY KEY (`consecutivo`),
  KEY `FK_tbl_reserva_tbl_usuario` (`usuario`),
  KEY `FK_tbl_reserva_tbl_tipo_reserva` (`tipo_reserva`),
  KEY `FK_tbl_reserva_tbl_estado_reserva` (`estado_reserva`),
  CONSTRAINT `FK_tbl_reserva_tbl_estado_reserva` FOREIGN KEY (`estado_reserva`) REFERENCES `tbl_tipo_reserva` (`codigo`),
  CONSTRAINT `FK_tbl_reserva_tbl_usuario` FOREIGN KEY (`usuario`) REFERENCES `tbl_cliente` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_reserva`
--

LOCK TABLES `tbl_reserva` WRITE;
/*!40000 ALTER TABLE `tbl_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_reserva`
--

DROP TABLE IF EXISTS `tbl_tipo_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_tipo_reserva` (
  `codigo` varchar(5) NOT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_reserva`
--

LOCK TABLES `tbl_tipo_reserva` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tipo_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_usuario`
--

DROP TABLE IF EXISTS `tbl_tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_tipo_usuario` (
  `codigo` varchar(2) NOT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_usuario`
--

LOCK TABLES `tbl_tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08 13:05:51
