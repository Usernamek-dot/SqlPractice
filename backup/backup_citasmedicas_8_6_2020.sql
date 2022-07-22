-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: citasmedicas
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
-- Table structure for table `tblalergia`
--

DROP TABLE IF EXISTS `tblalergia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblalergia` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblalergia`
--

LOCK TABLES `tblalergia` WRITE;
/*!40000 ALTER TABLE `tblalergia` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblalergia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcitas`
--

DROP TABLE IF EXISTS `tblcitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcitas` (
  `Codigo` int(5) NOT NULL AUTO_INCREMENT,
  `Paciente` varchar(45) NOT NULL,
  `Fecha` datetime NOT NULL,
  `Medico` varchar(12) NOT NULL,
  `Ips` varchar(6) NOT NULL,
  `Temperatura` int(3) NOT NULL,
  `Presion arterial` int(3) NOT NULL,
  `Frecuencia Cardiaca` int(3) NOT NULL,
  `Peso` int(3) NOT NULL,
  `Estatura` int(4) NOT NULL,
  `Sintomatologia` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblCitas_tblPaciente1_idx` (`Paciente`),
  KEY `fk_tblCitas_tblIps1_idx` (`Ips`),
  KEY `fk_tblCitas_tblMedico1_idx` (`Medico`),
  CONSTRAINT `fk_tblCitas_tblIps1` FOREIGN KEY (`Ips`) REFERENCES `tblips` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblCitas_tblMedico1` FOREIGN KEY (`Medico`) REFERENCES `tblmedico` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblCitas_tblPaciente1` FOREIGN KEY (`Paciente`) REFERENCES `tblpaciente` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcitas`
--

LOCK TABLES `tblcitas` WRITE;
/*!40000 ALTER TABLE `tblcitas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcitasdiagnostico`
--

DROP TABLE IF EXISTS `tblcitasdiagnostico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcitasdiagnostico` (
  `Citas` int(5) NOT NULL,
  `Diagnostico` varchar(4) NOT NULL,
  PRIMARY KEY (`Citas`,`Diagnostico`),
  KEY `fk_tblCitasDiagnostico_tblDiagnostico1_idx` (`Diagnostico`),
  KEY `fk_tblCitasDiagnostico_tblCitas1_idx` (`Citas`),
  CONSTRAINT `fk_tblCitasDiagnostico_tblCitas1` FOREIGN KEY (`Citas`) REFERENCES `tblcitas` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblCitasDiagnostico_tblDiagnostico1` FOREIGN KEY (`Diagnostico`) REFERENCES `tbldiagnostico` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcitasdiagnostico`
--

LOCK TABLES `tblcitasdiagnostico` WRITE;
/*!40000 ALTER TABLE `tblcitasdiagnostico` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcitasdiagnostico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldiagnostico`
--

DROP TABLE IF EXISTS `tbldiagnostico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbldiagnostico` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(75) NOT NULL,
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
-- Table structure for table `tbleps`
--

DROP TABLE IF EXISTS `tbleps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbleps` (
  `Codigo` varchar(6) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbleps`
--

LOCK TABLES `tbleps` WRITE;
/*!40000 ALTER TABLE `tbleps` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbleps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblespecialidad`
--

DROP TABLE IF EXISTS `tblespecialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblespecialidad` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(47) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblespecialidad`
--

LOCK TABLES `tblespecialidad` WRITE;
/*!40000 ALTER TABLE `tblespecialidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblespecialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfactura`
--

DROP TABLE IF EXISTS `tblfactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfactura` (
  `Codigo` varchar(8) NOT NULL,
  `Cita` int(5) NOT NULL,
  `Fecha` date NOT NULL,
  `Foma Pago` varchar(15) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_tblFactura_tblCitas1_idx` (`Cita`),
  KEY `fk_tblFactura_tblFormaPago1_idx` (`Foma Pago`),
  CONSTRAINT `fk_tblFactura_tblCitas1` FOREIGN KEY (`Cita`) REFERENCES `tblcitas` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblFactura_tblFormaPago1` FOREIGN KEY (`Foma Pago`) REFERENCES `tblformapago` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  `Factura` varchar(8) NOT NULL,
  `Servicio` varchar(4) NOT NULL,
  `Cantidad` int(2) NOT NULL,
  `Valor Unidad` int(6) NOT NULL,
  PRIMARY KEY (`Factura`,`Servicio`),
  KEY `fk_tblFacturaServicio_tblServicio1_idx` (`Servicio`),
  KEY `fk_tblFacturaServicio_tblFactura1_idx` (`Factura`),
  CONSTRAINT `fk_tblFacturaServicio_tblFactura1` FOREIGN KEY (`Factura`) REFERENCES `tblfactura` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblFacturaServicio_tblServicio1` FOREIGN KEY (`Servicio`) REFERENCES `tblservicio` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
-- Table structure for table `tblformapago`
--

DROP TABLE IF EXISTS `tblformapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblformapago` (
  `Codigo` varchar(15) NOT NULL,
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
-- Table structure for table `tblgenero`
--

DROP TABLE IF EXISTS `tblgenero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblgenero` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(7) NOT NULL,
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
-- Table structure for table `tblips`
--

DROP TABLE IF EXISTS `tblips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblips` (
  `Codigo` varchar(6) NOT NULL,
  `Nombre` varchar(25) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblips`
--

LOCK TABLES `tblips` WRITE;
/*!40000 ALTER TABLE `tblips` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmedicamento`
--

DROP TABLE IF EXISTS `tblmedicamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmedicamento` (
  `Codigo` varchar(3) NOT NULL,
  `Nombre` varchar(35) NOT NULL,
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
-- Table structure for table `tblmedico`
--

DROP TABLE IF EXISTS `tblmedico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmedico` (
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Email` varchar(70) NOT NULL,
  `Especialidad` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_tblMedico_tblEspecialidad1_idx` (`Especialidad`),
  CONSTRAINT `fk_tblMedico_tblEspecialidad1` FOREIGN KEY (`Especialidad`) REFERENCES `tblespecialidad` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  `Id` varchar(12) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `FechaNacimiento` datetime NOT NULL,
  `Genero` varchar(3) NOT NULL,
  `Eps` varchar(6) NOT NULL,
  `Antecedentes` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_tblPaciente_tblGenero_idx` (`Genero`),
  KEY `fk_tblPaciente_tblEps1_idx` (`Eps`),
  CONSTRAINT `fk_tblPaciente_tblEps1` FOREIGN KEY (`Eps`) REFERENCES `tbleps` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPaciente_tblGenero` FOREIGN KEY (`Genero`) REFERENCES `tblgenero` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
-- Table structure for table `tblpacientealergia`
--

DROP TABLE IF EXISTS `tblpacientealergia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpacientealergia` (
  `Paciente` varchar(12) NOT NULL,
  `Alergia` varchar(4) NOT NULL,
  PRIMARY KEY (`Paciente`,`Alergia`),
  KEY `fk_tblPacienteAlergia_tblPaciente1_idx` (`Paciente`),
  KEY `fk_tblPacienteAlergia_tblAlergia1_idx` (`Alergia`),
  CONSTRAINT `fk_tblPacienteAlergia_tblAlergia1` FOREIGN KEY (`Alergia`) REFERENCES `tblalergia` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPacienteAlergia_tblPaciente1` FOREIGN KEY (`Paciente`) REFERENCES `tblpaciente` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpacientealergia`
--

LOCK TABLES `tblpacientealergia` WRITE;
/*!40000 ALTER TABLE `tblpacientealergia` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpacientealergia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpacientemedicamento`
--

DROP TABLE IF EXISTS `tblpacientemedicamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpacientemedicamento` (
  `IdPaciente` varchar(12) NOT NULL,
  `CodigoMedicamento` varchar(3) NOT NULL,
  PRIMARY KEY (`IdPaciente`,`CodigoMedicamento`),
  KEY `fk_tblPacienteMedicamento_tblPaciente1_idx` (`IdPaciente`),
  KEY `fk_tblPacienteMedicamento_tblMedicamento1_idx` (`CodigoMedicamento`),
  CONSTRAINT `fk_tblPacienteMedicamento_tblMedicamento1` FOREIGN KEY (`CodigoMedicamento`) REFERENCES `tblmedicamento` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblPacienteMedicamento_tblPaciente1` FOREIGN KEY (`IdPaciente`) REFERENCES `tblpaciente` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpacientemedicamento`
--

LOCK TABLES `tblpacientemedicamento` WRITE;
/*!40000 ALTER TABLE `tblpacientemedicamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpacientemedicamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblservicio`
--

DROP TABLE IF EXISTS `tblservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblservicio` (
  `Codigo` varchar(4) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Valor` varchar(6) NOT NULL,
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08 12:44:51
