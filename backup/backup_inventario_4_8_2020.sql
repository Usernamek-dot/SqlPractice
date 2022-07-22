-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: inventario
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
-- Table structure for table `tbl_cliente`
--

DROP TABLE IF EXISTS `tbl_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_cliente` (
  `documento` varchar(12) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `municipio` varchar(6) NOT NULL,
  PRIMARY KEY (`documento`),
  KEY `fk_tbl_clientes_tbl_municipio1_idx` (`municipio`),
  CONSTRAINT `fk_tbl_clientes_tbl_municipio1` FOREIGN KEY (`municipio`) REFERENCES `tblmunicipio` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cliente`
--

LOCK TABLES `tbl_cliente` WRITE;
/*!40000 ALTER TABLE `tbl_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcategoria`
--

DROP TABLE IF EXISTS `tblcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcategoria` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`codigo`)
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
-- Table structure for table `tbldepartamento`
--

DROP TABLE IF EXISTS `tbldepartamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbldepartamento` (
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`codigo`)
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
-- Table structure for table `tblfacturacompra`
--

DROP TABLE IF EXISTS `tblfacturacompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfacturacompra` (
  `numero` int(3) NOT NULL AUTO_INCREMENT,
  `proveedor` varchar(15) NOT NULL,
  `forma_pago` int(3) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_tbl_facturacompra_tbl_formapago1_idx` (`forma_pago`),
  KEY `fk_tbl_facturacompra_tbl_proveedor1_idx` (`proveedor`),
  CONSTRAINT `fk_tbl_facturacompra_tbl_formapago1` FOREIGN KEY (`forma_pago`) REFERENCES `tblformapago` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_facturacompra_tbl_proveedor1` FOREIGN KEY (`proveedor`) REFERENCES `tblproveedor` (`nit`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturacompra`
--

LOCK TABLES `tblfacturacompra` WRITE;
/*!40000 ALTER TABLE `tblfacturacompra` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfacturacompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfacturacompramateriaprima`
--

DROP TABLE IF EXISTS `tblfacturacompramateriaprima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfacturacompramateriaprima` (
  `materia_prima` varchar(15) NOT NULL,
  `factura_compra` int(3) NOT NULL,
  `cantidad` int(4) NOT NULL,
  `precio_unitario` int(6) NOT NULL,
  PRIMARY KEY (`materia_prima`,`factura_compra`),
  KEY `fk_tbl_facturacompra_materiaprima_tbl_facturacompra1_idx` (`factura_compra`),
  CONSTRAINT `fk_tbl_facturacompra_materiaprima_tbl_facturacompra1` FOREIGN KEY (`factura_compra`) REFERENCES `tblfacturacompra` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_facturacompra_materiaprima_tbl_materiaprima1` FOREIGN KEY (`materia_prima`) REFERENCES `tblmateriaprima` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturacompramateriaprima`
--

LOCK TABLES `tblfacturacompramateriaprima` WRITE;
/*!40000 ALTER TABLE `tblfacturacompramateriaprima` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfacturacompramateriaprima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfacturaventa`
--

DROP TABLE IF EXISTS `tblfacturaventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfacturaventa` (
  `numero` int(3) NOT NULL AUTO_INCREMENT,
  `cliente` varchar(12) NOT NULL,
  `fecha` date NOT NULL,
  `forma_pago` int(3) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_tblfacturaventa_tbl_formapago1_idx` (`forma_pago`),
  KEY `fk_tblfacturaventa_tbl_clientes1_idx` (`cliente`),
  CONSTRAINT `fk_tblfacturaventa_tbl_clientes1` FOREIGN KEY (`cliente`) REFERENCES `tbl_cliente` (`documento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblfacturaventa_tbl_formapago1` FOREIGN KEY (`forma_pago`) REFERENCES `tblformapago` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturaventa`
--

LOCK TABLES `tblfacturaventa` WRITE;
/*!40000 ALTER TABLE `tblfacturaventa` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfacturaventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfacturventaproducto`
--

DROP TABLE IF EXISTS `tblfacturventaproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfacturventaproducto` (
  `factura_venta` int(3) NOT NULL,
  `producto` varchar(15) NOT NULL,
  `cantidad` int(4) NOT NULL,
  `precio_unitario` int(6) NOT NULL,
  PRIMARY KEY (`factura_venta`,`producto`),
  KEY `fk_tblfacturaventa_producto_tblproducto1_idx` (`producto`),
  KEY `fk_tblfacturaventa_producto_tblfacturaventa1_idx` (`factura_venta`),
  CONSTRAINT `fk_tblfacturaventa_producto_tblfacturaventa1` FOREIGN KEY (`factura_venta`) REFERENCES `tblfacturaventa` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblfacturaventa_producto_tblproducto1` FOREIGN KEY (`producto`) REFERENCES `tblproductoterminado` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturventaproducto`
--

LOCK TABLES `tblfacturventaproducto` WRITE;
/*!40000 ALTER TABLE `tblfacturventaproducto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfacturventaproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblformapago`
--

DROP TABLE IF EXISTS `tblformapago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblformapago` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(35) NOT NULL,
  PRIMARY KEY (`codigo`)
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
-- Table structure for table `tblmateriaprima`
--

DROP TABLE IF EXISTS `tblmateriaprima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmateriaprima` (
  `codigo` varchar(15) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `unidad_medida` int(2) NOT NULL,
  `unidades_disponibles` int(5) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_tbl_materiaprima_tblunidadmedida1_idx` (`unidad_medida`),
  CONSTRAINT `fk_tbl_materiaprima_tblunidadmedida1` FOREIGN KEY (`unidad_medida`) REFERENCES `tblunidadmedida` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmateriaprima`
--

LOCK TABLES `tblmateriaprima` WRITE;
/*!40000 ALTER TABLE `tblmateriaprima` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmateriaprima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmateriaprimareceta`
--

DROP TABLE IF EXISTS `tblmateriaprimareceta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmateriaprimareceta` (
  `materia_prima` varchar(15) NOT NULL,
  `receta` int(3) NOT NULL,
  `cantidad` int(4) NOT NULL,
  PRIMARY KEY (`materia_prima`,`receta`),
  KEY `fk_tbl_materiaprima_receta_tbl_receta1_idx` (`receta`),
  CONSTRAINT `fk_tbl_materiaprima_receta_tbl_receta1` FOREIGN KEY (`receta`) REFERENCES `tblreceta` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblmateriaprima_receta_tbl_materiaprima1` FOREIGN KEY (`materia_prima`) REFERENCES `tblmateriaprima` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmateriaprimareceta`
--

LOCK TABLES `tblmateriaprimareceta` WRITE;
/*!40000 ALTER TABLE `tblmateriaprimareceta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmateriaprimareceta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmunicipio`
--

DROP TABLE IF EXISTS `tblmunicipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmunicipio` (
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `tbl_departamentos_codigo` varchar(3) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_tbl_municipio_tbl_departamentos1_idx` (`tbl_departamentos_codigo`),
  CONSTRAINT `fk_tbl_municipio_tbl_departamentos1` FOREIGN KEY (`tbl_departamentos_codigo`) REFERENCES `tbldepartamento` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmunicipio`
--

LOCK TABLES `tblmunicipio` WRITE;
/*!40000 ALTER TABLE `tblmunicipio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmunicipio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproduccion`
--

DROP TABLE IF EXISTS `tblproduccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproduccion` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `usuario` varchar(12) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproduccion`
--

LOCK TABLES `tblproduccion` WRITE;
/*!40000 ALTER TABLE `tblproduccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblproduccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproduccionreceta`
--

DROP TABLE IF EXISTS `tblproduccionreceta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproduccionreceta` (
  `cod_produccion` int(3) NOT NULL,
  `cod_receta` int(3) NOT NULL,
  `cantidad` int(4) NOT NULL,
  PRIMARY KEY (`cod_produccion`,`cod_receta`),
  KEY `fk_tblproduccionreceta_tblreceta1_idx` (`cod_receta`),
  KEY `fk_tblproduccionreceta_tblproduccion1_idx` (`cod_produccion`),
  CONSTRAINT `fk_tblproduccionreceta_tblproduccion1` FOREIGN KEY (`cod_produccion`) REFERENCES `tblproduccion` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblproduccionreceta_tblreceta1` FOREIGN KEY (`cod_receta`) REFERENCES `tblreceta` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproduccionreceta`
--

LOCK TABLES `tblproduccionreceta` WRITE;
/*!40000 ALTER TABLE `tblproduccionreceta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblproduccionreceta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproductoterminado`
--

DROP TABLE IF EXISTS `tblproductoterminado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproductoterminado` (
  `codigo` varchar(15) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `categoria` int(3) NOT NULL,
  `unidades_disponibles` int(5) NOT NULL,
  `unidad_medida` int(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_tblproducto_tblcategoria1_idx` (`categoria`),
  KEY `fk_tblproducto_tblunidadmedida1_idx` (`unidad_medida`),
  CONSTRAINT `fk_tblproducto_tblcategoria1` FOREIGN KEY (`categoria`) REFERENCES `tblcategoria` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblproducto_tblunidadmedida1` FOREIGN KEY (`unidad_medida`) REFERENCES `tblunidadmedida` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproductoterminado`
--

LOCK TABLES `tblproductoterminado` WRITE;
/*!40000 ALTER TABLE `tblproductoterminado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblproductoterminado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproveedor`
--

DROP TABLE IF EXISTS `tblproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproveedor` (
  `nit` varchar(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(60) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `municipio` varchar(6) NOT NULL,
  PRIMARY KEY (`nit`),
  KEY `fk_tbl_proveedor_tbl_municipio1_idx` (`municipio`),
  CONSTRAINT `fk_tbl_proveedor_tbl_municipio1` FOREIGN KEY (`municipio`) REFERENCES `tblmunicipio` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproveedor`
--

LOCK TABLES `tblproveedor` WRITE;
/*!40000 ALTER TABLE `tblproveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblproveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblreceta`
--

DROP TABLE IF EXISTS `tblreceta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreceta` (
  `codigo` int(3) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `producto` varchar(15) NOT NULL,
  `usuario` varchar(12) NOT NULL,
  `descripcion` varchar(5000) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_tbl_ajusteinventario_tbl_usuarios1_idx` (`usuario`),
  KEY `fk_tbl_receta_tbl_productoterminado1_idx` (`producto`),
  CONSTRAINT `fk_tbl_ajusteinventario_tbl_usuarios10` FOREIGN KEY (`usuario`) REFERENCES `tblusuario` (`documento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_receta_tbl_productoterminado1` FOREIGN KEY (`producto`) REFERENCES `tblproductoterminado` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreceta`
--

LOCK TABLES `tblreceta` WRITE;
/*!40000 ALTER TABLE `tblreceta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblreceta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipousuario`
--

DROP TABLE IF EXISTS `tbltipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltipousuario` (
  `id` int(2) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipousuario`
--

LOCK TABLES `tbltipousuario` WRITE;
/*!40000 ALTER TABLE `tbltipousuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblunidadmedida`
--

DROP TABLE IF EXISTS `tblunidadmedida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblunidadmedida` (
  `codigo` int(2) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblunidadmedida`
--

LOCK TABLES `tblunidadmedida` WRITE;
/*!40000 ALTER TABLE `tblunidadmedida` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblunidadmedida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblusuario`
--

DROP TABLE IF EXISTS `tblusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblusuario` (
  `documento` varchar(12) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(60) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `clave` varchar(10) NOT NULL,
  `tipo_usuario` int(2) NOT NULL,
  `municipio` varchar(6) NOT NULL,
  PRIMARY KEY (`documento`),
  KEY `fk_tbl_usuarios_tbl_municipio1_idx` (`municipio`),
  KEY `fk_tbl_usuarios_tbl_tipo_usuario1_idx` (`tipo_usuario`),
  CONSTRAINT `fk_tbl_usuarios_tbl_municipio1` FOREIGN KEY (`municipio`) REFERENCES `tblmunicipio` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_usuarios_tbl_tipo_usuario1` FOREIGN KEY (`tipo_usuario`) REFERENCES `tbltipousuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblusuario`
--

LOCK TABLES `tblusuario` WRITE;
/*!40000 ALTER TABLE `tblusuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblusuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-04 12:07:51
