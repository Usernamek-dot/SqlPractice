-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: clinica_veterinaria_ddl
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
-- Table structure for table `color_paciente`
--

DROP TABLE IF EXISTS `color_paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `color_paciente` (
  `codigo_color` varchar(6) NOT NULL,
  `codigo_paciente` varchar(10) NOT NULL,
  PRIMARY KEY (`codigo_color`,`codigo_paciente`),
  KEY `FK_color_paciente_tbl_paciente` (`codigo_paciente`),
  CONSTRAINT `FK_color_paciente_tbl_color` FOREIGN KEY (`codigo_color`) REFERENCES `tbl_color` (`codigo`),
  CONSTRAINT `FK_color_paciente_tbl_paciente` FOREIGN KEY (`codigo_paciente`) REFERENCES `tbl_paciente` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color_paciente`
--

LOCK TABLES `color_paciente` WRITE;
/*!40000 ALTER TABLE `color_paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `color_paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_servicio`
--

DROP TABLE IF EXISTS `factura_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_servicio` (
  `codigo_factura` int(4) NOT NULL,
  `codigo_servicio` varchar(4) NOT NULL,
  `cantidad` int(2) NOT NULL,
  `valor_unidad` int(6) DEFAULT NULL,
  PRIMARY KEY (`codigo_factura`,`codigo_servicio`),
  KEY `FK_factura_servicio_tbl_servicio` (`codigo_servicio`),
  CONSTRAINT `FK_factura_servicio_tbl_factura` FOREIGN KEY (`codigo_factura`) REFERENCES `tbl_factura` (`codigo`),
  CONSTRAINT `FK_factura_servicio_tbl_servicio` FOREIGN KEY (`codigo_servicio`) REFERENCES `tbl_servicio` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_servicio`
--

LOCK TABLES `factura_servicio` WRITE;
/*!40000 ALTER TABLE `factura_servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_color`
--

DROP TABLE IF EXISTS `tbl_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_color` (
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_color`
--

LOCK TABLES `tbl_color` WRITE;
/*!40000 ALTER TABLE `tbl_color` DISABLE KEYS */;
INSERT INTO `tbl_color` VALUES ('123','negro'),('123456','marrón'),('222','cafe'),('333','morado'),('456','azul'),('543897','rosa'),('975004','negro');
/*!40000 ALTER TABLE `tbl_color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_consulta`
--

DROP TABLE IF EXISTS `tbl_consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_consulta` (
  `codigo` int(4) NOT NULL AUTO_INCREMENT,
  `paciente` varchar(10) NOT NULL,
  `fecha` datetime NOT NULL,
  `medico` varchar(12) DEFAULT NULL,
  `motivo` varchar(40) DEFAULT NULL,
  `recomendaciones` mediumtext DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tbl_consulta_tbl_paciente` (`paciente`),
  KEY `FK_tbl_consulta_tbl_medico` (`medico`),
  CONSTRAINT `FK_tbl_consulta_tbl_medico` FOREIGN KEY (`medico`) REFERENCES `tbl_medico` (`id`),
  CONSTRAINT `FK_tbl_consulta_tbl_paciente` FOREIGN KEY (`paciente`) REFERENCES `tbl_paciente` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_consulta`
--

LOCK TABLES `tbl_consulta` WRITE;
/*!40000 ALTER TABLE `tbl_consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_diagnostico`
--

DROP TABLE IF EXISTS `tbl_diagnostico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_diagnostico` (
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_diagnostico`
--

LOCK TABLES `tbl_diagnostico` WRITE;
/*!40000 ALTER TABLE `tbl_diagnostico` DISABLE KEYS */;
INSERT INTO `tbl_diagnostico` VALUES ('111','nombrediagnostico'),('12333','nombrediagnostico3'),('234456','nombrediagnostico2'),('584960','diagnostico leve');
/*!40000 ALTER TABLE `tbl_diagnostico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_diagnostico_consulta`
--

DROP TABLE IF EXISTS `tbl_diagnostico_consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_diagnostico_consulta` (
  `codigo_diagnostico` varchar(6) NOT NULL,
  `codigo_consulta` int(4) NOT NULL,
  PRIMARY KEY (`codigo_diagnostico`,`codigo_consulta`),
  KEY `FK_tbl_diagnostico_consulta_tbl_consulta` (`codigo_consulta`),
  CONSTRAINT `FK_tbl_diagnostico_consulta_tbl_consulta` FOREIGN KEY (`codigo_consulta`) REFERENCES `tbl_consulta` (`codigo`),
  CONSTRAINT `FK_tbl_diagnostico_consulta_tbl_diagnostico` FOREIGN KEY (`codigo_diagnostico`) REFERENCES `tbl_diagnostico` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_diagnostico_consulta`
--

LOCK TABLES `tbl_diagnostico_consulta` WRITE;
/*!40000 ALTER TABLE `tbl_diagnostico_consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_diagnostico_consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_especie`
--

DROP TABLE IF EXISTS `tbl_especie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_especie` (
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_especie`
--

LOCK TABLES `tbl_especie` WRITE;
/*!40000 ALTER TABLE `tbl_especie` DISABLE KEYS */;
INSERT INTO `tbl_especie` VALUES ('156','avena loca'),('222','bromo'),('234','manzanilla loca'),('dd','ddkgh'),('tre','jdhf');
/*!40000 ALTER TABLE `tbl_especie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_factura`
--

DROP TABLE IF EXISTS `tbl_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_factura` (
  `codigo` int(4) NOT NULL AUTO_INCREMENT,
  `consulta` int(4) DEFAULT NULL,
  `forma_pago` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tbl_factura_tbl_consulta` (`consulta`),
  KEY `FK_tbl_factura_tbl_forma_pago` (`forma_pago`),
  CONSTRAINT `FK_tbl_factura_tbl_consulta` FOREIGN KEY (`consulta`) REFERENCES `tbl_consulta` (`codigo`),
  CONSTRAINT `FK_tbl_factura_tbl_forma_pago` FOREIGN KEY (`forma_pago`) REFERENCES `tbl_forma_pago` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_factura`
--

LOCK TABLES `tbl_factura` WRITE;
/*!40000 ALTER TABLE `tbl_factura` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_forma_pago`
--

DROP TABLE IF EXISTS `tbl_forma_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_forma_pago` (
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_forma_pago`
--

LOCK TABLES `tbl_forma_pago` WRITE;
/*!40000 ALTER TABLE `tbl_forma_pago` DISABLE KEYS */;
INSERT INTO `tbl_forma_pago` VALUES ('123','condimento'),('344','credito'),('456','debito');
/*!40000 ALTER TABLE `tbl_forma_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_medicamento`
--

DROP TABLE IF EXISTS `tbl_medicamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_medicamento` (
  `codigo` varchar(4) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_medicamento`
--

LOCK TABLES `tbl_medicamento` WRITE;
/*!40000 ALTER TABLE `tbl_medicamento` DISABLE KEYS */;
INSERT INTO `tbl_medicamento` VALUES ('1222','asetaminofe'),('4321','aspirina'),('4444','jarabe');
/*!40000 ALTER TABLE `tbl_medicamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_medicamento_consulta`
--

DROP TABLE IF EXISTS `tbl_medicamento_consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_medicamento_consulta` (
  `codigo_medicamento` varchar(4) NOT NULL,
  `codigo_consulta` int(4) NOT NULL,
  `cantidad` int(3) NOT NULL,
  `dosificacion` int(2) NOT NULL,
  PRIMARY KEY (`codigo_medicamento`,`codigo_consulta`),
  KEY `FK_tbl_medicamento_consulta_tbl_consulta` (`codigo_consulta`),
  CONSTRAINT `FK_tbl_medicamento_consulta_tbl_consulta` FOREIGN KEY (`codigo_consulta`) REFERENCES `tbl_consulta` (`codigo`),
  CONSTRAINT `FK_tbl_medicamento_consulta_tbl_medicamento` FOREIGN KEY (`codigo_medicamento`) REFERENCES `tbl_medicamento` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_medicamento_consulta`
--

LOCK TABLES `tbl_medicamento_consulta` WRITE;
/*!40000 ALTER TABLE `tbl_medicamento_consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_medicamento_consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_medico`
--

DROP TABLE IF EXISTS `tbl_medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_medico` (
  `id` varchar(12) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_medico`
--

LOCK TABLES `tbl_medico` WRITE;
/*!40000 ALTER TABLE `tbl_medico` DISABLE KEYS */;
INSERT INTO `tbl_medico` VALUES ('111111143','ramiro','jirafales'),('123456789012','josefina','ramirez'),('354637285977','pepe','torres');
/*!40000 ALTER TABLE `tbl_medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_paciente`
--

DROP TABLE IF EXISTS `tbl_paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_paciente` (
  `codigo` varchar(10) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `raza` varchar(3) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `vacunas` varchar(3) DEFAULT NULL,
  `rasgos` varchar(100) DEFAULT NULL,
  `propietario` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tbl_paciente_tbl_raza` (`raza`),
  KEY `FK_tbl_paciente_tbl_propietario` (`propietario`),
  CONSTRAINT `FK_tbl_paciente_tbl_propietario` FOREIGN KEY (`propietario`) REFERENCES `tbl_propietario` (`id`),
  CONSTRAINT `FK_tbl_paciente_tbl_raza` FOREIGN KEY (`raza`) REFERENCES `tbl_raza` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_paciente`
--

LOCK TABLES `tbl_paciente` WRITE;
/*!40000 ALTER TABLE `tbl_paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_paciente_vacuna`
--

DROP TABLE IF EXISTS `tbl_paciente_vacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_paciente_vacuna` (
  `codigo_paciente` varchar(10) NOT NULL,
  `codigo_vacuna` varchar(3) NOT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`codigo_paciente`,`codigo_vacuna`),
  KEY `FK_tbl_paciente_vacuna_tbl_vacuna` (`codigo_vacuna`),
  CONSTRAINT `FK_tbl_paciente_vacuna_tbl_paciente` FOREIGN KEY (`codigo_paciente`) REFERENCES `tbl_paciente` (`codigo`),
  CONSTRAINT `FK_tbl_paciente_vacuna_tbl_vacuna` FOREIGN KEY (`codigo_vacuna`) REFERENCES `tbl_vacuna` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_paciente_vacuna`
--

LOCK TABLES `tbl_paciente_vacuna` WRITE;
/*!40000 ALTER TABLE `tbl_paciente_vacuna` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_paciente_vacuna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_propietario`
--

DROP TABLE IF EXISTS `tbl_propietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_propietario` (
  `id` varchar(12) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono_fijo` varchar(20) DEFAULT NULL,
  `telefono_movil` varchar(15) DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_propietario`
--

LOCK TABLES `tbl_propietario` WRITE;
/*!40000 ALTER TABLE `tbl_propietario` DISABLE KEYS */;
INSERT INTO `tbl_propietario` VALUES ('111111111111','mimi','push','3333354','98857938','mimi@hotmail.com'),('222222222222','fabio','pic','947594','984598','fab@hotmail.com');
/*!40000 ALTER TABLE `tbl_propietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_raza`
--

DROP TABLE IF EXISTS `tbl_raza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_raza` (
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL,
  `especie` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_tbl_raza_tbl_especie` (`especie`),
  CONSTRAINT `FK_tbl_raza_tbl_especie` FOREIGN KEY (`especie`) REFERENCES `tbl_especie` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_raza`
--

LOCK TABLES `tbl_raza` WRITE;
/*!40000 ALTER TABLE `tbl_raza` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_raza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_servicio`
--

DROP TABLE IF EXISTS `tbl_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_servicio` (
  `codigo` varchar(4) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_servicio`
--

LOCK TABLES `tbl_servicio` WRITE;
/*!40000 ALTER TABLE `tbl_servicio` DISABLE KEYS */;
INSERT INTO `tbl_servicio` VALUES ('12','hospitalizacion'),('33','diagnostico'),('56','urgencias');
/*!40000 ALTER TABLE `tbl_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_vacuna`
--

DROP TABLE IF EXISTS `tbl_vacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_vacuna` (
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_vacuna`
--

LOCK TABLES `tbl_vacuna` WRITE;
/*!40000 ALTER TABLE `tbl_vacuna` DISABLE KEYS */;
INSERT INTO `tbl_vacuna` VALUES ('22','papi'),('45','vamp'),('46','amor');
/*!40000 ALTER TABLE `tbl_vacuna` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-19 10:37:42
