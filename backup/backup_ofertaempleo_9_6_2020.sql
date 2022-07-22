-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: ofertaempleo
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
-- Table structure for table `tblcargo`
--

DROP TABLE IF EXISTS `tblcargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcargo` (
  `Codigo` int(5) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`Codigo`)
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
-- Table structure for table `tblciudad`
--

DROP TABLE IF EXISTS `tblciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblciudad` (
  `Codigo` varchar(6) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Departamento` varchar(3) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblCiudad_tblDepartamento1_idx` (`Departamento`),
  CONSTRAINT `fk_tblCiudad_tblDepartamento1` FOREIGN KEY (`Departamento`) REFERENCES `tbldepartamento` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblciudad`
--

LOCK TABLES `tblciudad` WRITE;
/*!40000 ALTER TABLE `tblciudad` DISABLE KEYS */;
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
  `Nombre` varchar(30) NOT NULL,
  `Pais` varchar(3) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblDepartamento_tblPais1_idx` (`Pais`),
  CONSTRAINT `fk_tblDepartamento_tblPais1` FOREIGN KEY (`Pais`) REFERENCES `tblpais` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldepartamento`
--

LOCK TABLES `tbldepartamento` WRITE;
/*!40000 ALTER TABLE `tbldepartamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldepartamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempresa`
--

DROP TABLE IF EXISTS `tblempresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblempresa` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Nombre de contacto` varchar(60) NOT NULL,
  `Email de contacto` varchar(50) NOT NULL,
  `Telefono de contacto` varchar(20) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempresa`
--

LOCK TABLES `tblempresa` WRITE;
/*!40000 ALTER TABLE `tblempresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblempresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempresapersona`
--

DROP TABLE IF EXISTS `tblempresapersona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblempresapersona` (
  `CodigoEmpresa` varchar(4) NOT NULL,
  `Idpersona` varchar(12) NOT NULL,
  `Cargo` int(5) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaTerminacion` date NOT NULL,
  PRIMARY KEY (`CodigoEmpresa`,`Idpersona`),
  KEY `fk_tblEmpresaPersona_tblEmpresa1_idx` (`CodigoEmpresa`),
  KEY `fk_tblEmpresaPersona_tblPersona1_idx` (`Idpersona`),
  KEY `fk_tblEmpresaPersona_tblCargo1_idx` (`Cargo`),
  CONSTRAINT `fk_tblEmpresaPersona_tblCargo1` FOREIGN KEY (`Cargo`) REFERENCES `tblcargo` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpresaPersona_tblEmpresa1` FOREIGN KEY (`CodigoEmpresa`) REFERENCES `tblempresa` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpresaPersona_tblPersona1` FOREIGN KEY (`Idpersona`) REFERENCES `tblpersona` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempresapersona`
--

LOCK TABLES `tblempresapersona` WRITE;
/*!40000 ALTER TABLE `tblempresapersona` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblempresapersona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblinstitucion`
--

DROP TABLE IF EXISTS `tblinstitucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblinstitucion` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblinstitucion`
--

LOCK TABLES `tblinstitucion` WRITE;
/*!40000 ALTER TABLE `tblinstitucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblinstitucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbloferta`
--

DROP TABLE IF EXISTS `tbloferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbloferta` (
  `Codigo` int(4) NOT NULL AUTO_INCREMENT,
  `Titular` varchar(50) NOT NULL,
  `Descripcion del Cargo` varchar(225) NOT NULL,
  `Numero de vacantes` int(3) DEFAULT NULL,
  `FechaCierre` date NOT NULL,
  `Ciudad` varchar(6) NOT NULL,
  `Salario` int(8) NOT NULL,
  `Tipo de Contrato` varchar(3) NOT NULL,
  `Empresa` varchar(4) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblOferta_tblCiudad_idx` (`Ciudad`),
  KEY `fk_tblOferta_tblTipoContrato1_idx` (`Tipo de Contrato`),
  KEY `fk_tblOferta_tblEmpresa1_idx` (`Empresa`),
  CONSTRAINT `fk_tblOferta_tblCiudad` FOREIGN KEY (`Ciudad`) REFERENCES `tblciudad` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblOferta_tblEmpresa1` FOREIGN KEY (`Empresa`) REFERENCES `tblempresa` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblOferta_tblTipoContrato1` FOREIGN KEY (`Tipo de Contrato`) REFERENCES `tbltipocontrato` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbloferta`
--

LOCK TABLES `tbloferta` WRITE;
/*!40000 ALTER TABLE `tbloferta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbloferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblofertatituloprofesional`
--

DROP TABLE IF EXISTS `tblofertatituloprofesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblofertatituloprofesional` (
  `CodigoOferta` int(4) NOT NULL,
  `CodigoTituloProfesional` varchar(12) NOT NULL,
  PRIMARY KEY (`CodigoOferta`,`CodigoTituloProfesional`),
  KEY `fk_tblOfertaTituloProfesional_tblOferta1_idx` (`CodigoOferta`),
  KEY `fk_tblOfertaTituloProfesional_tblTituloProfesional1_idx` (`CodigoTituloProfesional`),
  CONSTRAINT `fk_tblOfertaTituloProfesional_tblOferta1` FOREIGN KEY (`CodigoOferta`) REFERENCES `tbloferta` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblOfertaTituloProfesional_tblTituloProfesional1` FOREIGN KEY (`CodigoTituloProfesional`) REFERENCES `tbltituloprofesional` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblofertatituloprofesional`
--

LOCK TABLES `tblofertatituloprofesional` WRITE;
/*!40000 ALTER TABLE `tblofertatituloprofesional` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblofertatituloprofesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpais`
--

DROP TABLE IF EXISTS `tblpais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpais` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(75) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpais`
--

LOCK TABLES `tblpais` WRITE;
/*!40000 ALTER TABLE `tblpais` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpersona`
--

DROP TABLE IF EXISTS `tblpersona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpersona` (
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `TelefonoFijo` varchar(20) DEFAULT NULL,
  `TelefonoMovil` varchar(15) DEFAULT NULL,
  `Email` varchar(70) DEFAULT NULL,
  `Fotografia` blob DEFAULT NULL,
  `FechaNacimiento` datetime NOT NULL,
  `Direccion` varchar(70) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpersona`
--

LOCK TABLES `tblpersona` WRITE;
/*!40000 ALTER TABLE `tblpersona` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpersona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpersonatitulo`
--

DROP TABLE IF EXISTS `tblpersonatitulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpersonatitulo` (
  `IdPersona` varchar(12) NOT NULL,
  `CodigoTitulo` varchar(12) NOT NULL,
  `Institucion` varchar(4) NOT NULL,
  `Año de grado` date NOT NULL,
  PRIMARY KEY (`IdPersona`,`CodigoTitulo`,`Año de grado`),
  KEY `fk_tblPersonaTitulo_tblPersona1_idx` (`IdPersona`),
  KEY `fk_tblPersonaTitulo_tblTituloProfesional1_idx` (`CodigoTitulo`),
  KEY `fk_tblPersonaTitulo_tblInstitucion1_idx` (`Institucion`),
  CONSTRAINT `fk_tblPersonaTitulo_tblInstitucion1` FOREIGN KEY (`Institucion`) REFERENCES `tblinstitucion` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPersonaTitulo_tblPersona1` FOREIGN KEY (`IdPersona`) REFERENCES `tblpersona` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPersonaTitulo_tblTituloProfesional1` FOREIGN KEY (`CodigoTitulo`) REFERENCES `tbltituloprofesional` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpersonatitulo`
--

LOCK TABLES `tblpersonatitulo` WRITE;
/*!40000 ALTER TABLE `tblpersonatitulo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpersonatitulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpostulacion`
--

DROP TABLE IF EXISTS `tblpostulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpostulacion` (
  `Codigo` int(4) NOT NULL AUTO_INCREMENT,
  `IdPersona` varchar(12) NOT NULL,
  `CodigoOferta` int(4) NOT NULL,
  `Fecha` datetime NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblPostulacion_tblPersona1_idx` (`IdPersona`),
  KEY `fk_tblPostulacion_tblOferta1_idx` (`CodigoOferta`),
  CONSTRAINT `fk_tblPostulacion_tblOferta1` FOREIGN KEY (`CodigoOferta`) REFERENCES `tbloferta` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPostulacion_tblPersona1` FOREIGN KEY (`IdPersona`) REFERENCES `tblpersona` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpostulacion`
--

LOCK TABLES `tblpostulacion` WRITE;
/*!40000 ALTER TABLE `tblpostulacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpostulacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipocontrato`
--

DROP TABLE IF EXISTS `tbltipocontrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltipocontrato` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(35) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipocontrato`
--

LOCK TABLES `tbltipocontrato` WRITE;
/*!40000 ALTER TABLE `tbltipocontrato` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltipocontrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipoeducacionminima`
--

DROP TABLE IF EXISTS `tbltipoeducacionminima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltipoeducacionminima` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(12) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipoeducacionminima`
--

LOCK TABLES `tbltipoeducacionminima` WRITE;
/*!40000 ALTER TABLE `tbltipoeducacionminima` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltipoeducacionminima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltituloprofesional`
--

DROP TABLE IF EXISTS `tbltituloprofesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltituloprofesional` (
  `Codigo` varchar(12) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `TipoEducacionMinima` varchar(4) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblTituloProfesional_tblTipoEducacionMinima1_idx` (`TipoEducacionMinima`),
  CONSTRAINT `fk_tblTituloProfesional_tblTipoEducacionMinima1` FOREIGN KEY (`TipoEducacionMinima`) REFERENCES `tbltipoeducacionminima` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltituloprofesional`
--

LOCK TABLES `tbltituloprofesional` WRITE;
/*!40000 ALTER TABLE `tbltituloprofesional` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltituloprofesional` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-09 12:34:47
