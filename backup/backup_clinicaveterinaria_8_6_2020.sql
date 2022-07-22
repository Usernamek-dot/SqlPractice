-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: clinicaveterinaria
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
-- Table structure for table `tblcolorpaciente`
--

DROP TABLE IF EXISTS `tblcolorpaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcolorpaciente` (
  `CodigoColor` varchar(6) NOT NULL,
  `CodigoPaciente` varchar(10) NOT NULL,
  PRIMARY KEY (`CodigoColor`,`CodigoPaciente`),
  KEY `fk_tblColorPaciente_tblColor1_idx` (`CodigoColor`),
  KEY `fk_tblColorPaciente_tblPaciente1_idx` (`CodigoPaciente`),
  CONSTRAINT `fk_tblColorPaciente_tblColor1` FOREIGN KEY (`CodigoColor`) REFERENCES `tblcolor` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblColorPaciente_tblPaciente1` FOREIGN KEY (`CodigoPaciente`) REFERENCES `tblpaciente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcolorpaciente`
--

LOCK TABLES `tblcolorpaciente` WRITE;
/*!40000 ALTER TABLE `tblcolorpaciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcolorpaciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconsulta`
--

DROP TABLE IF EXISTS `tblconsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblconsulta` (
  `Codigo` int(4) NOT NULL AUTO_INCREMENT,
  `Paciente` varchar(10) NOT NULL,
  `Fecha` datetime NOT NULL,
  `Medico` varchar(12) NOT NULL,
  `Motivo` varchar(40) NOT NULL,
  `Recomendaciones` varchar(150) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblConsulta_tblPaciente1_idx` (`Paciente`),
  KEY `fk_tblConsulta_tblMedico1_idx` (`Medico`),
  CONSTRAINT `fk_tblConsulta_tblMedico1` FOREIGN KEY (`Medico`) REFERENCES `tblmedico` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblConsulta_tblPaciente1` FOREIGN KEY (`Paciente`) REFERENCES `tblpaciente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconsulta`
--

LOCK TABLES `tblconsulta` WRITE;
/*!40000 ALTER TABLE `tblconsulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblconsulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldiagnostico`
--

DROP TABLE IF EXISTS `tbldiagnostico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbldiagnostico` (
  `Codigo` varchar(6) NOT NULL,
  `Nombre` varchar(25) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldiagnostico`
--

LOCK TABLES `tbldiagnostico` WRITE;
/*!40000 ALTER TABLE `tbldiagnostico` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldiagnostico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldiagnosticoconsulta`
--

DROP TABLE IF EXISTS `tbldiagnosticoconsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbldiagnosticoconsulta` (
  `CodigoDiagostico` varchar(6) NOT NULL,
  `CodigoConsulta` int(4) NOT NULL,
  PRIMARY KEY (`CodigoDiagostico`,`CodigoConsulta`),
  KEY `fk_tblDiagnosticoConsulta_tblDiagnostico1_idx` (`CodigoDiagostico`),
  KEY `fk_tblDiagnosticoConsulta_tblConsulta1_idx` (`CodigoConsulta`),
  CONSTRAINT `fk_tblDiagnosticoConsulta_tblConsulta1` FOREIGN KEY (`CodigoConsulta`) REFERENCES `tblconsulta` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblDiagnosticoConsulta_tblDiagnostico1` FOREIGN KEY (`CodigoDiagostico`) REFERENCES `tbldiagnostico` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldiagnosticoconsulta`
--

LOCK TABLES `tbldiagnosticoconsulta` WRITE;
/*!40000 ALTER TABLE `tbldiagnosticoconsulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldiagnosticoconsulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblespecie`
--

DROP TABLE IF EXISTS `tblespecie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblespecie` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblespecie`
--

LOCK TABLES `tblespecie` WRITE;
/*!40000 ALTER TABLE `tblespecie` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblespecie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfactura`
--

DROP TABLE IF EXISTS `tblfactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfactura` (
  `Codigo` int(4) NOT NULL AUTO_INCREMENT,
  `Consulta` int(4) NOT NULL,
  `FormaPago` varchar(3) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblFactura_tblConsulta1_idx` (`Consulta`),
  KEY `fk_tblFactura_tblFomaPago1_idx` (`FormaPago`),
  CONSTRAINT `fk_tblFactura_tblConsulta1` FOREIGN KEY (`Consulta`) REFERENCES `tblconsulta` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblFactura_tblFomaPago1` FOREIGN KEY (`FormaPago`) REFERENCES `tblfomapago` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfactura`
--

LOCK TABLES `tblfactura` WRITE;
/*!40000 ALTER TABLE `tblfactura` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfacturaservicio`
--

DROP TABLE IF EXISTS `tblfacturaservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfacturaservicio` (
  `CodigoFactura` int(4) NOT NULL,
  `CodigoServicio` varchar(4) NOT NULL,
  `Cantidad` int(2) NOT NULL,
  `ValorUnidad` int(6) NOT NULL,
  PRIMARY KEY (`CodigoFactura`,`CodigoServicio`),
  KEY `fk_tblFacturaServicio_tblFactura1_idx` (`CodigoFactura`),
  KEY `fk_tblFacturaServicio_tblServicio1_idx` (`CodigoServicio`),
  CONSTRAINT `fk_tblFacturaServicio_tblFactura1` FOREIGN KEY (`CodigoFactura`) REFERENCES `tblfactura` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblFacturaServicio_tblServicio1` FOREIGN KEY (`CodigoServicio`) REFERENCES `tblservicio` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturaservicio`
--

LOCK TABLES `tblfacturaservicio` WRITE;
/*!40000 ALTER TABLE `tblfacturaservicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfacturaservicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfomapago`
--

DROP TABLE IF EXISTS `tblfomapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfomapago` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfomapago`
--

LOCK TABLES `tblfomapago` WRITE;
/*!40000 ALTER TABLE `tblfomapago` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfomapago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmedicamento`
--

DROP TABLE IF EXISTS `tblmedicamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmedicamento` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmedicamento`
--

LOCK TABLES `tblmedicamento` WRITE;
/*!40000 ALTER TABLE `tblmedicamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmedicamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmedicamentoconsulta`
--

DROP TABLE IF EXISTS `tblmedicamentoconsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmedicamentoconsulta` (
  `CodigoMedicamento` varchar(4) NOT NULL,
  `CodigoConsulta` int(4) NOT NULL,
  `Cantidad` int(3) NOT NULL,
  `Dosificacion` int(2) NOT NULL,
  PRIMARY KEY (`CodigoMedicamento`,`CodigoConsulta`),
  KEY `fk_tblMedicamentoConsulta_tblMedicamento1_idx` (`CodigoMedicamento`),
  KEY `fk_tblMedicamentoConsulta_tblConsulta1_idx` (`CodigoConsulta`),
  CONSTRAINT `fk_tblMedicamentoConsulta_tblConsulta1` FOREIGN KEY (`CodigoConsulta`) REFERENCES `tblconsulta` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblMedicamentoConsulta_tblMedicamento1` FOREIGN KEY (`CodigoMedicamento`) REFERENCES `tblmedicamento` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmedicamentoconsulta`
--

LOCK TABLES `tblmedicamentoconsulta` WRITE;
/*!40000 ALTER TABLE `tblmedicamentoconsulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmedicamentoconsulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmedico`
--

DROP TABLE IF EXISTS `tblmedico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmedico` (
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmedico`
--

LOCK TABLES `tblmedico` WRITE;
/*!40000 ALTER TABLE `tblmedico` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmedico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpaciente`
--

DROP TABLE IF EXISTS `tblpaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpaciente` (
  `Codigo` varchar(10) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Raza` varchar(3) NOT NULL,
  `Fecha Nacimiento` date NOT NULL,
  `Vacunas` varchar(3) DEFAULT NULL,
  `Rasgos` varchar(100) DEFAULT NULL,
  `Propietario` varchar(12) NOT NULL,
  PRIMARY KEY (`Codigo`),
  UNIQUE KEY `Fecha Nacimiento_UNIQUE` (`Fecha Nacimiento`),
  KEY `fk_tblPaciente_tblRaza_idx` (`Raza`),
  KEY `fk_tblPaciente_tblPropietario1_idx` (`Propietario`),
  CONSTRAINT `fk_tblPaciente_tblPropietario1` FOREIGN KEY (`Propietario`) REFERENCES `tblpropietario` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPaciente_tblRaza` FOREIGN KEY (`Raza`) REFERENCES `tblraza` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpaciente`
--

LOCK TABLES `tblpaciente` WRITE;
/*!40000 ALTER TABLE `tblpaciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpaciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpacientevacuna`
--

DROP TABLE IF EXISTS `tblpacientevacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpacientevacuna` (
  `CodigoPaciente` varchar(10) NOT NULL,
  `CodigoVacuna` varchar(3) NOT NULL,
  `Fecha` date NOT NULL,
  PRIMARY KEY (`CodigoPaciente`,`CodigoVacuna`),
  KEY `fk_tblPacienteVacuna_tblPaciente1_idx` (`CodigoPaciente`),
  KEY `fk_tblPacienteVacuna_tblVacuna1_idx` (`CodigoVacuna`),
  CONSTRAINT `fk_tblPacienteVacuna_tblPaciente1` FOREIGN KEY (`CodigoPaciente`) REFERENCES `tblpaciente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPacienteVacuna_tblVacuna1` FOREIGN KEY (`CodigoVacuna`) REFERENCES `tblvacuna` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpacientevacuna`
--

LOCK TABLES `tblpacientevacuna` WRITE;
/*!40000 ALTER TABLE `tblpacientevacuna` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpacientevacuna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpropietario`
--

DROP TABLE IF EXISTS `tblpropietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpropietario` (
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `TelefonoFijo` varchar(20) DEFAULT NULL,
  `TelefonMovil` varchar(15) DEFAULT NULL,
  `Email` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpropietario`
--

LOCK TABLES `tblpropietario` WRITE;
/*!40000 ALTER TABLE `tblpropietario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpropietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblraza`
--

DROP TABLE IF EXISTS `tblraza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblraza` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Especie` varchar(3) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblRaza_tblEspecie1_idx` (`Especie`),
  CONSTRAINT `fk_tblRaza_tblEspecie1` FOREIGN KEY (`Especie`) REFERENCES `tblespecie` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblraza`
--

LOCK TABLES `tblraza` WRITE;
/*!40000 ALTER TABLE `tblraza` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblraza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblservicio`
--

DROP TABLE IF EXISTS `tblservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblservicio` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblservicio`
--

LOCK TABLES `tblservicio` WRITE;
/*!40000 ALTER TABLE `tblservicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblservicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblvacuna`
--

DROP TABLE IF EXISTS `tblvacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblvacuna` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblvacuna`
--

LOCK TABLES `tblvacuna` WRITE;
/*!40000 ALTER TABLE `tblvacuna` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblvacuna` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08 12:51:33
