-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-11-2020 a las 21:24:27
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rp_precioTotalProducto` (IN `p_mes` DATE)  begin
select sum(fvpt.cantidad * fvpt.precio_unitario) as 'preciototal' ,  pt.nombre as 'producto',
month(fv.fecha) as 'mes' 
from  tblfacturventaproducto as fvpt  inner join tblfacturaventa as fv ON fv.numero = fvpt.factura_venta
inner join tblproductoterminado as pt on fvpt.producto = pt.codigo
where  month(fv.fecha) = p_mes ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Rp_PromedioVentas` (IN `p_mes` DATE, IN `p_año` DATE)  begin
select 
    avg(vp.Cantidad * vp.precio_unitario) as 'Valor promedio de ventas',
    month(v.fecha) as 'mes',
    year(v.fecha) as 'Año'
from
    tblfacturventaproducto as vp
        inner join
    tblfacturaventa as v ON vp.factura_venta = v.numero
group by month(v.fecha) , year(v.fecha);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Rp_recetasEnProduccion` ()  BEGIN
select p.fecha as 'Fecha de orden de producción' ,
u.documento AS 'Documento del empleado',
concat(u.nombres ,'  ', u.apellidos) as 'Nombre del Empleado' , 
e.nombre as 'Estado del empleado' ,
count(pr.cod_receta)  as 'Cantidad de veces usadas' , pr.cod_receta as 'receta' 
from  tblreceta as r inner join tblproduccionreceta as pr ON r.codigo = pr.cod_receta
inner join tblproduccion as p on pr.cod_produccion = p.codigo
inner join tblusuario as u on p.usuario = u.documento
inner join tblestado as e on e.codigo = u.estado
where e.nombre = 'Activo'
group by pr.cod_receta
order by p.fecha desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RP_UsuarioInactivo` ()  begin
select u.documento,CONCAT (u.nombres, '  ' , u.apellidos ) as 'usuario',
 u.correo,u.telefono,u.direccion, m.nombre as 'municipio',et.nombre, tu.nombre 
as rol from tblusuario as u INNER JOIN tbltipousuario as tu ON u.tipo_usuario = tu.id 
INNER JOIN  tblestado as et ON u.estado=et.codigo inner join tblmunicipio as m ON u.municipio
 = m.codigo where  et.nombre= 'inactivo' GROUP BY m.nombre  ORDER BY documento ASC;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RP_usuariossinrol` ()  begin
SELECT
u.documento,
CONCAT (u.nombres, ' ' , u.apellidos ) as 'usuario',
u.correo,
u.telefono,
u.direccion,
u.clave,
tp.nombre as 'rol',
m.nombre as 'municipio',
u.estado
FROM
tblusuario as u
   left JOIN
tbltipousuario as tp ON u.tipo_usuario = tp.id
inner join
tblmunicipio as m ON u.municipio = m.codigo
WHERE u.tipo_usuario IS NULL;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Rp_ValorVentas` (IN `p_nombre` VARCHAR(30), IN `p_cantidad` INT(4), IN `p_precio_unitario` INT(6))  begin

select 
    sum(vp.Cantidad * vp.precio_unitario) as 'Valor total facturado',
    p.nombre as 'producto'
from
    tblproductoterminado as p
        inner join
     tblfacturventaproducto as vp ON p.codigo = vp.factura_venta
group by p.nombre
order by 'Valor total facturado' desc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarCategoria` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(40))  begin

UPDATE  tblcategoria SET
codigo= p_codigo,
nombre=p_nombre
WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarCliente` (IN `p_documento` VARCHAR(12), IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(60), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(70), IN `p_direccion` VARCHAR(45), IN `p_municipio` VARCHAR(6))  begin
UPDATE tbl_cliente SET nombres=p_nombres,
apellidos= p_apellidos ,telefono=p_telefono,correo=p_correo,
direccion=p_direccion , municipio=p_municipio  WHERE documento=p_documento;
 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarDepartamento` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(60))  begin

UPDATE tbldepartamento SET 
codigo= p_codigo,
nombre=p_nombre
WHERE codigo=p_codigo;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarEstado` (IN `p_codigo` INT(1), IN `p_nombre` VARCHAR(8))  begin

UPDATE tblestado SET codigo= p_codigo ,nombre=p_nombre WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarFacturacompra` (IN `p_numero` INT(3), IN `p_proveedor` VARCHAR(15), IN `p_formapago` INT(3), IN `p_fecha` DATE)  begin

UPDATE tblfacturacompra SET 
numero= p_numero,
proveedor=p_proveedor,
formapago=p_formapago,
fecha=p_fecha
WHERE numero=p_numero;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarFacturacompramateriaprima` (IN `p_materia_prima` VARCHAR(15), IN `p_factura_compra` INT(3), IN `p_cantidad` INT(4), IN `p_precio_unitario` INT(6))  begin

UPDATE tblfacturacompramateriaprima SET 
materia_prima= p_materia_prima,
factura_compra=p_fatura_compra,
cantidad=p_cantidad,
precio_unitario=p_precio_unitario

WHERE materia_prima=p_materia_prima;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarFacturaventa` (IN `p_numero` INT(3), IN `p_cliente` VARCHAR(12), IN `p_fecha` DATE, IN `p_forma_pago` INT(3))  begin

UPDATE tblfacturaventa SET 
numero= p_numero,
cliente=p_cliente,
fecha=p_fecha,
forma_pago=p_forma_pago

WHERE numero=p_numero;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarFacturventaproducto` (IN `p_factura_venta` INT(3), IN `p_producto` VARCHAR(15), IN `p_cantidad` INT(4), IN `p_precio_unitario` INT(6))  begin

UPDATE tblfacturaventaproducto SET 
factura_venta= p_factura_venta,
producto=p_producto,
cantidad=p_cantidad,
precio_unitario=p_precio_unitario

WHERE factura_venta=p_factura_venta;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarFormaPago` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(35))  begin

UPDATE tblformapago SET codigo= p_codigo, nombre=p_nombre  WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarMateriaPrima` (IN `p_codigo` VARCHAR(15), IN `p_nombre` VARCHAR(30), IN `p_unidad_medida` INT(2), IN `p_unidades_disponibles` INT(5), IN `p_fecha_vencimiento` DATE)  begin

UPDATE tblmateriaprima SET codigo=p_codigo,nombre=p_nombre, unidad_medida=p_unidad_medida, unidades_disponibles=p_unidades_disponibles, fecha_vencimiento= p_fecha_vencimiento  WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarMateriaPrimaReceta` (IN `p_materia_prima` VARCHAR(15), IN `p_receta` INT(3), IN `p_cantidad` INT(4))  begin

UPDATE tblmateriaprimareceta SET materia_prima=p_materia_prima, receta=p_receta, cantidad=p_cantidad WHERE materia_prima=p_materia_prima and receta=p_receta;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarMunicipio` (IN `p_codigo` VARCHAR(6), IN `p_nombre` VARCHAR(60), IN `p_departamento` VARCHAR(3))  begin

UPDATE tblmunicipio SET codigo= p_codigo, nombre=p_nombre, tbl_departamento_codigo=p_departamento WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarProduccion` (IN `p_codigo` INT(3), IN `p_fecha` DATE, IN `p_usuario` VARCHAR(12))  begin

UPDATE  tblproduccion SET codigo=p_codigo,fecha=p_fecha,usuario=p_usuario WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarProduccionReceta` (IN `p_produccion` INT(3), IN `p_receta` INT(3), IN `p_cantidad` INT(4))  begin

UPDATE tblproduccionreceta SET cod_produccion=p_produccion, cod_receta=p_receta, cantidad=p_cantidad WHERE cod_produccion=p_produccion and cod_receta=p_receta;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarProducto` (IN `p_codigo` VARCHAR(15), IN `p_nombre` VARCHAR(30), IN `p_fecha_creacion` DATE, IN `p_fecha_vencimiento` DATE, IN `p_categoria` INT(3), IN `p_unidades_disponibles` INT(5), IN `p_unidad_medida` INT(2))  begin
UPDATE tblproductoterminado SET codigo=p_codigo,nombre=p_nombre,fecha_creacion=p_fecha_creacion,
fecha_vencimiento=p_fecha_vencimiento,categoria=p_categoria,
unidades_disponibles=p_unidades_disponibles, 
unidad_medida = p_unidad_medida  WHERE codigo=p_codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarProveedor` (IN `p_nit` VARCHAR(15), IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(60), IN `p_direccion` VARCHAR(45), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(70), IN `p_municipio` VARCHAR(6))  begin
UPDATE tblproveedor SET nit = p_nit, nombre=p_nombre ,apellido=p_apellido,direccion=p_direccion,telefono=p_telefono,correo=p_correo,municipio=p_municipio
WHERE nit=p_nit;
 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarReceta` (IN `p_codigo` INT(3), IN `p_fecha` DATE, IN `p_producto` VARCHAR(15), IN `p_usuario` VARCHAR(12), IN `p_descripcion` VARCHAR(5000))  begin
UPDATE tblreceta SET fecha=p_fecha,producto=p_producto ,usuario=p_usuario,
descripcion=p_descripcion WHERE codigo= p_codigo;
 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarTipoUsuario` (IN `p_id` INT(2), IN `p_nombre` VARCHAR(20))  begin
UPDATE tbltipousuario SET id= p_id , nombre= p_nombre  WHERE id=p_id;
 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarUnidadMedida` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(15))  begin
UPDATE tblunidadmedida SET codigo= p_codigo , nombre= p_nombre  WHERE codigo= p_codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarUsuario` (IN `p_documento` VARCHAR(12), IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(60), IN `p_correo` VARCHAR(60), IN `p_telefono` VARCHAR(20), IN `p_direccion` VARCHAR(45), IN `p_clave` VARCHAR(10), IN `p_municipio` VARCHAR(6))  begin

UPDATE tblusuario SET documento= p_documento,nombres=p_nombres,
apellidos=p_apellidos, correo=p_correo, telefono=p_telefono,
direccion=p_direccion , clave=p_clave ,municipio=p_municipio  WHERE documento= p_documento;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategoria` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(40))  begin


SELECT
codigo,
nombre
FROM
tblcategoria 
where codigo= p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategorias` ()  begin


SELECT
codigo,
nombre
FROM
tblcategoria ;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCliente` (IN `p_documento` VARCHAR(12), IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(60), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(70), IN `p_direccion` VARCHAR(45), IN `p_municipio` VARCHAR(6))  begin
SELECT
cl.documento,
cl.nombres as 'nombres',
cl.apellidos as 'apellidos',
cl.correo,
cl.telefono,
cl.direccion,
m.nombre as 'municipio'
FROM
tbl_cliente as cl
inner join
tblmunicipio as m ON cl.municipio = m.codigo
where
documento=p_documento ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDepartamento` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(60))  begin


SELECT
codigo,
nombre
FROM
tbldepartamento 
where codigo= p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDepartamentos` ()  begin


SELECT
codigo,
nombre
FROM
tbldepartamento;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEstado` (IN `p_codigo` INT(1), IN `p_nombre` VARCHAR(8))  begin

SELECT * FROM
tblestado  where codigo = p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFacturacompra` (IN `p_numero` INT(3), IN `p_proveedor` VARCHAR(15), IN `p_formapago` INT(3), IN `p_fecha` DATE)  Begin

SELECT fa.numero , 
CONCAT(p.nombre, ' ' , p.apellido ) as 'proveedor' , 
fp.nombre as 'formapago' ,
fa.fecha  
FROM tblfacturacompra       as fa
INNER JOIN tblproveedor    as p   ON fa.proveedor = p.nit
INNER JOIN tblformapago   as fp  ON fa.forma_pago = fp.codigo
where numero= p_numero;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFacturacompramateriaprima` (IN `p_materia_prima` VARCHAR(15), IN `p_factura_compra` INT(3), IN `p_cantidad` INT(4), IN `p_precio_unitario` INT(6))  begin
SELECT m.nombre, fm.factura_compra , fm.cantidad , fm.precio_unitario
FROM tblfacturacompramateriaprima as fm
INNER JOIN tblmateriaprima as m on fm.materia_prima = m.codigo
Where materia_prima = p_materia_prima;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFacturacompramateriasprimas` ()  begin
SELECT m.nombre, fm.factura_compra , fm.cantidad , fm.precio_unitario
FROM tblfacturacompramateriaprima as fm
INNER JOIN tblmateriaprima as m on fm.materia_prima = m.codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFacturasventas` ()  Begin

SELECT fv.numero ,
CONCAT(c.nombres, ' ' , c.apellidos ) as 'cliente' ,
fv.fecha,
fp.nombre
FROM tblfacturaventa as fv
INNER JOIN tbl_cliente  as c ON fv.cliente = c.documento
INNER JOIN tblformapago  as fp ON fv.forma_pago = fp.codigo
ORDER BY fv.numero ASC;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFacturasventasproductos` ()  Begin

SELECT fvp.fatura_venta , 
pt.nombre as ‘producto’ ,
fvp.fecha , 
fvp.precio_unitario

FROM tblfacturventaproducto as fvp 
INNER JOIN tblfacturaventa as fv ON fvp.factura_venta = fv.numero  
INNER JOIN tblproductoterminado as pt on fvp.producto = pt.codigo
ORDER BY fv.numero ASC;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFacturaventa` (IN `p_numero` INT(3), IN `p_cliente` VARCHAR(12), IN `p_fecha` DATE, IN `p_forma_pago` INT(3))  Begin

SELECT fv.numero ,
CONCAT(c.nombres, ' ' , c.apellidos ) as 'cliente' ,
fv.fecha,
fp.nombre
FROM tblfacturaventa as fv
INNER JOIN tbl_cliente  as c ON fv.cliente = c.documento
INNER JOIN tblformapago  as fp ON fv.forma_pago = fp.codigo
where numero= p_numero;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFacturventaproducto` (IN `p_factura_venta` INT(3), IN `p_producto` VARCHAR(15), IN `p_cantidad` INT(4), IN `p_precio_unitario` INT(6))  Begin

SELECT fvp.fatura_venta , 
pt.nombre as ‘producto’ ,
fvp.fecha , 
fvp.precio_unitario

FROM tblfacturventaproducto as fvp 
INNER JOIN tblfacturaventa as fv ON fvp.factura_venta = fv.numero  
INNER JOIN tblproductoterminado as pt on fvp.producto = pt.codigo

where factura_venta= p_factura_venta;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarFormaPago` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(35))  begin

SELECT * FROM tblformapago where codigo = p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMateriaPrima` (IN `p_codigo` VARCHAR(15), IN `p_nombre` VARCHAR(30), IN `p_unidad_medida` INT(2), IN `p_unidades_disponibles` INT(5), IN `p_fecha_vencimiento` DATE)  begin

SELECT mp.codigo as 'codigo', mp.nombre as 'nombre', mp.unidades_disponibles as 'cantidad', mp.fecha_vencimiento, um.nombre as 'unidad_medida'  FROM tblmateriaprima as mp INNER JOIN tblunidadmedida as um ON mp.unidad_medida=um.codigo 

WHERE codigo = p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMateriaPrimaReceta` (IN `p_materia_prima` VARCHAR(15), IN `p_receta` INT(3), IN `p_cantidad` INT(4))  begin

SELECT mp.nombre  as 'materia prima',mpr.receta as 'receta', mpr.cantidad 
FROM tblmateriaprimareceta as mpr INNER JOIN tblmateriaprima as mp ON mp.codigo=mpr.materia_prima 
WHERE materia_prima=p_materia_prima AND receta=p_receta;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMunicipio` (IN `p_codigo` VARCHAR(6), IN `p_nombre` VARCHAR(60), IN `p_departamento` VARCHAR(3))  begin

SELECT mp.codigo, mp.nombre as ‘municipio’, dp.nombre as ‘departamento’ FROM tblmunicipio as mp INNER JOIN tbldepartamento as dp On mp.tbl_departamento_codigo=dp.codigo where mp.codigo = p_codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProduccion` (IN `p_codigo` INT(3), IN `p_fecha` DATE, IN `p_usuario` VARCHAR(12))  begin

SELECT pdc.codigo, pdc.fecha , CONCAT(u.nombres, ' ' , u.apellidos ) as 'empleado'
FROM tblproduccion as pdc INNER JOIN tblusuario as u ON u.documento = pdc.usuario

WHERE codigo = p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProduccionReceta` (IN `p_produccion` INT(3), IN `p_receta` INT(3), IN `p_cantidad` INT(4))  begin

SELECT * FROM tblproduccionreceta 

WHERE cod_produccion  = p_produccion and cod_receta=p_receta;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProducto` (IN `p_codigo` VARCHAR(15), IN `p_nombre` VARCHAR(30), IN `p_fecha_creacion` DATE, IN `p_fecha_vencimiento` DATE, IN `p_categoria` INT(3), IN `p_unidades_disponibles` INT(5), IN `p_unidad_medida` INT(2))  begin
SELECT c.nombre as 'categoria',um.nombre as 'unidad_medida',pt.codigo,pt.nombre,
pt.unidades_disponibles,pt.fecha_vencimiento,pt.fecha_creacion FROM tblproductoterminado
 as pt INNER JOIN tblunidadmedida as um ON 
pt.unidad_medida = um.codigo INNER JOIN tblcategoria as c ON pt.categoria = c.codigo
where pt.codigo = p_codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProveedor` (IN `p_nit` VARCHAR(15), IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(60), IN `p_direccion` VARCHAR(45), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(70), IN `p_municipio` VARCHAR(6))  begin
SELECT
p.nit,
p.nombre as 'nombre',
p.apellido as 'apellido',
p.direccion,
p.telefono,
p.correo,
m.nombre as 'municipio'
FROM
tblproveedor as p INNER JOIN
tblmunicipio as m ON p.municipio = m.codigo 
where nit = p_nit;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarReceta` (IN `p_codigo` INT(3), IN `p_fecha` DATE, IN `p_producto` VARCHAR(15), IN `p_usuario` VARCHAR(12), IN `p_descripcion` VARCHAR(5000))  begin

SELECT 
    r.codigo,
    r.fecha,
    CONCAT(u.nombres, ' ', u.apellidos) as 'Empleado',
    p.nombre as 'producto',
    r.descripcion
FROM
    tblreceta as r
        INNER JOIN
    tblusuario as u ON r.usuario = u.documento
        INNER JOIN
    tblproductoterminado as p ON r.producto = p.codigo
where
    r.codigo = p_codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTipoUsuario` (IN `p_id` INT(2), IN `p_nombre` VARCHAR(20))  begin
SELECT * FROM tbltipousuario where id=p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUnidadMedida` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(15))  begin
SELECT * FROM tblunidadmedida
where
codigo= p_codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUsuario` (IN `p_documento` VARCHAR(12), IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(60), IN `p_correo` VARCHAR(60), IN `p_telefono` VARCHAR(20), IN `p_direccion` VARCHAR(45), IN `p_clave` VARCHAR(10), IN `p_municipio` VARCHAR(6))  begin

SELECT
u.documento,
u.nombres as 'nombre',
u.apellidos as 'apellido',
u.correo,
u.telefono,
u.direccion,
u.clave,
tp.nombre as 'rol',
m.nombre as 'municipio',
u.estado as 'estado'
FROM
tblusuario as u
    left JOIN
tbltipousuario as tp ON u.tipo_usuario = tp.id
inner join
tblmunicipio as m ON u.municipio = m.codigo
where documento = p_documento;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariasFormaPago` ()  begin

SELECT * FROM tblformapago where codigo = p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariasMateriasPrimas` ()  begin

SELECT mp.codigo as 'codigo', mp.nombre as 'nombre', mp.unidades_disponibles as 'cantidad', mp.fecha_vencimiento, um.nombre as 'unidad_medida'  FROM tblmateriaprima as mp INNER JOIN tblunidadmedida as um ON mp.unidad_medida=um.codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariasMateriasPrimasRecetas` ()  begin

SELECT mp.nombre  as 'materia prima',rc.nombre as 'receta', mpr.cantidad 
FROM tblmateriaprimareceta as mpr INNER JOIN tblmateriaprima as mp ON mp.codigo=mpr.materia_prima;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariasOrdenesProduccion` ()  begin

SELECT pdc.codigo, pdc.fecha , CONCAT(u.nombres, ' ' , u.apellidos ) as 'empleado'
FROM tblproduccion as pdc INNER JOIN tblusuario as u ON u.documento = pdc.usuario;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariasRecetas` ()  begin
SELECT 
    r.codigo,
    r.fecha,
    CONCAT(u.nombres, ' ', u.apellidos) as 'Empleado',
    p.nombre as 'producto',
    r.descripcion
FROM
    tblreceta as r
        INNER JOIN
    tblusuario as u ON r.usuario = u.documento
        INNER JOIN
    tblproductoterminado as p ON r.producto = p.codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariasUnidadesMedida` ()  begin
SELECT * FROM tblunidadmedida;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosClientes` ()  begin
SELECT
cl.documento,
cl.nombres as 'nombres',
cl.apellidos as 'apellidos',
cl.correo,
cl.telefono,
cl.direccion,
m.nombre as 'municipio'
FROM
tbl_cliente as cl
inner join
tblmunicipio as m ON cl.municipio = m.codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosEstados` ()  begin

SELECT * FROM
tblestado  ;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosMunicipios` ()  begin

SELECT mp.codigo, mp.nombre as ‘municipio’, dp.nombre as ‘departamento’ FROM tblmunicipio as mp INNER JOIN tbldepartamento as dp On mp.tbl_departamento_codigo=dp.codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosProduccionRecetas` ()  begin

SELECT * FROM tblproduccionreceta;


end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosProductos` ()  begin
SELECT pt.codigo,pt.nombre,c.nombre as 'categoria',um.nombre as 'unidad_medida',
pt.unidades_disponibles,pt.fecha_vencimiento,pt.fecha_creacion FROM tblproductoterminado
 as pt INNER JOIN tblunidadmedida as um ON 
pt.unidad_medida = um.codigo INNER JOIN tblcategoria as c ON pt.categoria = c.codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosProveedores` ()  begin
SELECT
p.nit,
p.nombre as 'nombre',
p.apellido as 'apellido',
p.direccion,
p.telefono,
p.correo,
m.nombre as 'municipio'
FROM
tblproveedor as p INNER JOIN
tblmunicipio as m ON p.municipio = m.codigo ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosTiposUsuario` ()  begin
SELECT * FROM tbltipousuario;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarVariosUsuarios` ()  begin

SELECT
u.documento,
u.nombres as 'nombre',
u.apellidos as 'apellido',
u.correo,
u.telefono,
u.direccion,
u.clave,
tp.nombre as 'rol',
m.nombre as 'municipio',
e.nombre as 'estado'
FROM
tblusuario as u
    left JOIN
tbltipousuario as tp ON u.tipo_usuario = tp.id
inner join
tblmunicipio as m ON u.municipio = m.codigo
inner join
tblestado as e ON u.estado = e.codigo;


end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarCategoria` (IN `p_codigo` INT(3))  begin

DELETE  FROM tblcategoria   
WHERE codigo=p_codigo;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarCliente` (IN `p_documento` VARCHAR(12))  begin
DELETE FROM tbl_cliente WHERE  documento=p_documento ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarDepartamento` (IN `p_codigo` INT(3))  begin

DELETE FROM tbldepartamento
WHERE codigo=p_codigo;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarEstado` (IN `p_codigo` INT(1))  begin

DELETE  FROM tblestado   WHERE codigo = p_codigo ;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarFacturacompra` (IN `p_numero` INT(3))  begin

DELETE FROM  tblfacturacompra
WHERE numero=p_numero;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarFacturacompramateriaprima` (IN `p_materia_prima` VARCHAR(15), IN `p_factura_compra` INT(3))  begin

DELETE FROM  tblfacturacompramateriaprima
WHERE materia_prima=p_materia_prima;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarFacturaventa` (IN `p_numero` INT(3))  begin

DELETE FROM tblfacturaventa
WHERE numero=p_numero;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarFacturventaproducto` (IN `p_factura_venta` INT(3))  begin

DELETE FROM tblfacturaventaproducto
WHERE factura_venta=p_factura_venta;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarFormaPago` (IN `p_codigo` INT(3))  begin

DELETE  FROM  tblformapaqgo  WHERE codigo=p_codigo;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarMateriaPrima` (IN `p_codigo` VARCHAR(15))  begin

DELETE FROM tblmateriaprima   WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarMateriaPrimaReceta` (IN `p_materia_prima` VARCHAR(15), IN `p_receta` INT(3))  begin

DELETE FROM tblmateriaprimareceta   WHERE materia_prima=p_materia_prima and receta=p_receta;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarMunicipio` (IN `p_codigo` VARCHAR(6))  begin

DELETE FROM tblmunicipio  WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarProduccion` (IN `p_codigo` INT(3))  begin

DELETE FROM tblproduccion   WHERE codigo=p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarProduccionReceta` (IN `p_produccion` INT(3), IN `p_receta` INT(3))  begin

DELETE FROM tblproduccionreceta   WHERE cod_produccion = p_produccion and cod_receta=p_receta;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarProducto` (IN `p_codigo` VARCHAR(15))  begin
DELETE FROM tblproductoterminado WHERE codigo = p_codigo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarProveedor` (IN `p_nit` VARCHAR(15))  begin
DELETE FROM tblproveedor WHERE nit = p_nit;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarReceta` (IN `p_codigo` VARCHAR(15))  begin
DELETE FROM tblreceta WHERE codigo = p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarTipoUsuario` (IN `p_id` INT(2))  begin
DELETE FROM tbltipousuario WHERE id=p_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarUnidadMedida` (IN `p_codigo` INT(3))  begin
DELETE FROM tblunidadmedida WHERE codigo= p_codigo;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarUsuario` (IN `p_documento` VARCHAR(12))  begin

DELETE  FROM tblusuario   WHERE documento = p_documento ;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarCategoria` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(40))  begin

INSERT INTO tblcategoria(codigo,nombre)
VALUES (p_codigo , p_nombre);
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarCliente` (IN `p_documento` VARCHAR(12), IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(60), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(70), IN `p_direccion` VARCHAR(45), IN `p_municipio` VARCHAR(6))  begin
INSERT INTO tbl_cliente(documento,nombres,apellidos,telefono,correo,direccion,municipio)  
VALUES (p_documento,p_nombres,p_apellidos,p_telefono,p_correo,p_direccion,p_municipio) ; 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarDepartamento` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(60))  begin

INSERT INTO tbldepartamento(codigo,nombre)
VALUES (p_codigo , p_nombre);

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarEstado` (IN `p_codigo` INT(1), IN `p_nombre` VARCHAR(8))  begin

INSERT INTO tblestado(codigo,nombre)
VALUES (p_codigo , p_nombre);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarFacturacompra` (IN `p_numero` INT(3), IN `p_proveedor` VARCHAR(15), IN `p_formapago` INT(3), IN `p_fecha` DATE)  begin

INSERT INTO tblfacturacompra (numero,proveedor,formapago,fecha)
VALUES (p_numero , p_proveedor, p_formapago, p_fecha);

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarFacturacompramateriaprima` (IN `p_materia_prima` VARCHAR(15), IN `p_factura_compra` INT(3), IN `p_cantidad` INT(4), IN `p_precio_unitario` INT(6))  Begin

INSERT INTO tblfacturacompramateriaprima (materia_prima, factura_compra, cantidad, precio_unitario) 
VALUES (p_materia_prima , p_fatura_compra, p_cantidad, p_precio_unitario);

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarFacturaventa` (IN `p_numero` INT(3), IN `p_cliente` VARCHAR(12), IN `p_fecha` DATE, IN `p_forma_pago` INT(3))  Begin

INSERT INTO tblfacturaventa (numero, cliente, fecha, forma_pago) 
VALUES (p_numero , p_cliente, p_fecha, p_forma_pago);

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarFacturventaproducto` (IN `p_factura_venta` INT(3), IN `p_producto` VARCHAR(15), IN `p_cantidad` INT(4), IN `p_precio_unitario` INT(6))  Begin

INSERT INTO tblfacturventaproducto (factura_venta, producto, cantidad, precio_unitario) 
VALUES (p_factura_venta , p_producto, p_cantidad, p_precio_unitario);

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarFormaPago` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(35))  begin

INSERT INTO tblformapago(codigo,nombre)
VALUES (NULL , p_nombre);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarMateriaPrima` (IN `p_codigo` VARCHAR(15), IN `p_nombre` VARCHAR(30), IN `p_unidad_medida` INT(2), IN `p_unidades_disponibles` INT(5), IN `p_fecha_vencimiento` DATE)  begin

INSERT INTO tblmateriaprima(codigo,nombre,unidad_medida,unidades_disponibles,fecha_vencimiento)
VALUES (p_codigo , p_nombre , p_unidad_meida, p_unidades_disponibles, p_fecha_vencimiento );

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarMateriaPrimaReceta` (IN `p_materia_prima` VARCHAR(15), IN `p_receta` INT(3), IN `p_cantidad` INT(4))  begin

INSERT INTO tblmateriaprimareceta(materia_prima,receta,cantidad)
VALUES (p_materia_prima , p_receta , p_cantidad );

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarMunicipio` (IN `p_codigo` VARCHAR(6), IN `p_nombre` VARCHAR(60), IN `p_departamento` VARCHAR(3))  begin

INSERT INTO tblmunicipio(codigo,nombre,tbl_departamentos_codigo)
VALUES (p_codigo , p_nombre,p_departamento);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarProduccion` (IN `p_codigo` INT(3), IN `p_fecha` DATE, IN `p_usuario` VARCHAR(12))  begin

INSERT INTO tblproduccion(codigo,fecha,usuario)
VALUES (p_codigo , p_fecha , p_usuario);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarProduccionReceta` (IN `p_produccion` INT(3), IN `p_receta` INT(3), IN `p_cantidad` INT(4))  begin

INSERT INTO tblproduccionreceta(cod_produccion,cod_receta,cantidad)
VALUES (p_produccion , p_receta , p_cantidad );

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarProductoT` (IN `p_codigo` VARCHAR(15), IN `p_nombre` VARCHAR(30), IN `p_fecha_creacion` DATE, IN `p_fecha_vencimiento` DATE, IN `p_categoria` INT(3), IN `p_unidades_disponibles` INT(5), IN `p_unidad_medida` INT(2))  begin
INSERT INTO tblproductoterminado(codigo,nombre,fecha_creacion,fecha_vencimiento,
categoria,unidades_disponibles,unidad_medida) VALUES (p_codigo,p_nombre,
p_fecha_creacion,p_fecha_vencimiento,p_categoria,p_unidades_disponibles,p_unidad_medida);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarProveedor` (IN `p_nit` VARCHAR(15), IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(60), IN `p_direccion` VARCHAR(45), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(70), IN `p_municipio` VARCHAR(6))  begin
INSERT INTO tblproveedor(nit,nombre,apellido,direccion,telefono,correo,municipio) 
VALUES ( p_nit,p_nombre,p_apellido,p_direccion,p_telefono,p_correo,p_municipio);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarReceta` (IN `p_fecha` DATE, IN `p_producto` VARCHAR(15), IN `p_usuario` VARCHAR(12), IN `p_descripcion` VARCHAR(5000))  begin
INSERT INTO tblreceta(fecha,producto,usuario,descripcion) 
VALUES (p_fecha,p_producto,p_usuario,p_descripcion);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarTipoUsuario` (IN `p_id` INT(2), IN `p_nombre` VARCHAR(20))  begin
INSERT INTO tbltipousuario(id,nombre) 
VALUES (p_id,p_nombre);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarUnidadMedida` (IN `p_codigo` INT(3), IN `p_nombre` VARCHAR(15))  begin
INSERT INTO tblunidadmedida(codigo,nombre) 
VALUES (p_codigo,p_nombre);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarUsuario` (IN `p_documento` VARCHAR(12), IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(60), IN `p_correo` VARCHAR(60), IN `p_telefono` VARCHAR(20), IN `p_direccion` VARCHAR(45), IN `p_clave` VARCHAR(10), IN `p_municipio` VARCHAR(6))  begin

INSERT INTO tblusuario(documento,nombres,apellidos,correo,telefono,direccion,clave,municipio)
VALUES (p_documento , p_nombres , p_apellidos,p_correo,p_telefono,p_direccion,p_clave, p_municipio);

end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcategoria`
--

CREATE TABLE `tblcategoria` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblcategoria`
--

INSERT INTO `tblcategoria` (`codigo`, `nombre`) VALUES
(1, 'Grupo 1'),
(2, 'Grupo 2'),
(3, 'Grupo 3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldepartamento`
--

CREATE TABLE `tbldepartamento` (
  `codigo` varchar(3) NOT NULL,
  `nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbldepartamento`
--

INSERT INTO `tbldepartamento` (`codigo`, `nombre`) VALUES
('1', 'AMAZONAS'),
('10', 'CAQUETÁ'),
('11', 'CASANARE'),
('12', 'CAUCA'),
('13', 'CESAR'),
('14', 'CHOCÓ'),
('15', 'CÓRDOBA'),
('16', 'CUNDINAMARCA'),
('17', 'GUAINÍA'),
('18', 'GUAVIARE'),
('19', 'HUILA'),
('2', 'ANTIOQUIA'),
('20', 'LA GUAJIRA'),
('21', 'MAGDALENA'),
('22', 'META'),
('23', 'NARIÑO'),
('24', 'NORTE DE SANTANDER'),
('25', 'PUTUMAYO'),
('26', 'QUINDIO'),
('27', 'RISARALDA'),
('28', 'SANTANDER'),
('29', 'SUCRE'),
('3', 'ARAUCA'),
('30', 'TOLIMA'),
('31', 'VALLE DEL CAUCA'),
('32', 'VAUPÉS'),
('33', 'VICHADA'),
('4', 'ARCHIPIÉLAGO DE SAN ANDRÉS, PROVIDENCIA Y SANTA CATALINA'),
('5', 'ATLÁNTICO'),
('6', 'BOGOTÁ, D.C.'),
('7', 'BOLÍVAR'),
('8', 'BOYACÁ'),
('9', 'CALDAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblestado`
--

CREATE TABLE `tblestado` (
  `codigo` int(1) NOT NULL,
  `nombre` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblestado`
--

INSERT INTO `tblestado` (`codigo`, `nombre`) VALUES
(0, 'Activo'),
(1, 'Inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblfacturacompra`
--

CREATE TABLE `tblfacturacompra` (
  `numero` int(3) NOT NULL,
  `proveedor` varchar(15) NOT NULL,
  `forma_pago` int(3) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblfacturacompra`
--

INSERT INTO `tblfacturacompra` (`numero`, `proveedor`, `forma_pago`, `fecha`) VALUES
(67, '098405856', 1, '2020-11-10'),
(9879, '480856069', 1, '2020-11-18'),
(94569, '480856069', 1, '2020-11-30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblfacturacompramateriaprima`
--

CREATE TABLE `tblfacturacompramateriaprima` (
  `materia_prima` varchar(15) NOT NULL,
  `factura_compra` int(3) NOT NULL,
  `cantidad` int(4) NOT NULL,
  `precio_unitario` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblfacturacompramateriaprima`
--

INSERT INTO `tblfacturacompramateriaprima` (`materia_prima`, `factura_compra`, `cantidad`, `precio_unitario`) VALUES
('14', 67, 3, 3000),
('23', 67, 3, 8000),
('495086056', 9879, 12, 7000),
('78', 67, 89, 5000),
('79', 67, 8, 8000),
('84895896', 94569, 12, 8000),
('9375045', 9879, 8, 7000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblfacturaventa`
--

CREATE TABLE `tblfacturaventa` (
  `numero` int(3) NOT NULL,
  `cliente` varchar(12) DEFAULT NULL,
  `fecha` date NOT NULL,
  `forma_pago` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblfacturaventa`
--

INSERT INTO `tblfacturaventa` (`numero`, `cliente`, `fecha`, `forma_pago`) VALUES
(1, '903489058', '2020-10-29', 2),
(2, '903489058', '2020-11-09', 2),
(5, '903489058', '2020-12-03', 1),
(6, '903489058', '2020-11-10', 1),
(7, '903489058', '2020-11-13', 2),
(89, '903489058', '2020-12-09', 1),
(1000, '903489058', '2020-11-17', 2),
(7868, '903489058', '2020-11-13', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblfacturventaproducto`
--

CREATE TABLE `tblfacturventaproducto` (
  `factura_venta` int(3) NOT NULL,
  `producto` varchar(15) NOT NULL,
  `cantidad` int(4) NOT NULL,
  `precio_unitario` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblfacturventaproducto`
--

INSERT INTO `tblfacturventaproducto` (`factura_venta`, `producto`, `cantidad`, `precio_unitario`) VALUES
(1, '1', 8, 8000),
(1, '2', 89, 7000),
(1, '3', 89, 8788),
(2, '2', 8, 3000),
(2, '3', 3, 5000),
(2, '4', 89, 7000),
(5, '9058606', 8, 8788),
(5, 'er9t8095865', 89, 8788),
(6, 'er9t8095865', 8, 5000),
(7, '4', 89, 8000),
(7, '9058606', 89, 7000),
(7, 'er9t8095865', 12, 5000),
(89, '2', 89, 8788),
(89, '9058606', 12, 5000),
(1000, '9058606', 89, 8788),
(1000, 'er9t8095865', 12, 8788),
(7868, '04986056', 8, 5000),
(7868, '9058606', 12, 5000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblformapago`
--

CREATE TABLE `tblformapago` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblformapago`
--

INSERT INTO `tblformapago` (`codigo`, `nombre`) VALUES
(1, 'Debito'),
(2, 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmateriaprima`
--

CREATE TABLE `tblmateriaprima` (
  `codigo` varchar(15) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `unidad_medida` int(2) NOT NULL,
  `unidades_disponibles` int(5) NOT NULL,
  `fecha_vencimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblmateriaprima`
--

INSERT INTO `tblmateriaprima` (`codigo`, `nombre`, `unidad_medida`, `unidades_disponibles`, `fecha_vencimiento`) VALUES
('1', 'Gaseosaaaa', 4, 10, '2020-09-30'),
('1234', 'banano con crema', 4, 1234, '2020-11-04'),
('1324', 'cdasc', 2, 134, '2020-11-04'),
('14', 'Materia 4', 5, 3, '2020-12-02'),
('2', 'Bulto 1', 6, 23, '2020-11-18'),
('23', 'Materia 3', 3, 3, '2020-12-02'),
('3', 'papas', 5, 34, '2020-11-26'),
('495086056', 'cuchi', 4, 12, '2020-12-07'),
('666', 'cdasc', 3, 555, '2020-11-03'),
('78', 'Materia 1', 6, 89, '2020-11-24'),
('79', 'Materia 2', 3, 8, '2020-11-29'),
('84895896', 'Arepa de huevo', 3, 12, '2020-12-10'),
('9375045', 'lalala', 3, 8, '2020-11-06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmateriaprimareceta`
--

CREATE TABLE `tblmateriaprimareceta` (
  `materia_prima` varchar(15) NOT NULL,
  `receta` int(3) NOT NULL,
  `cantidad` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblmateriaprimareceta`
--

INSERT INTO `tblmateriaprimareceta` (`materia_prima`, `receta`, `cantidad`) VALUES
('1', 14, 13242),
('1', 35, 1),
('1234', 7882, 7),
('3', 7882, 3),
('78', 7883, 8),
('79', 7883, 8),
('84895896', 7882, 12),
('84895896', 7883, -1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmunicipio`
--

CREATE TABLE `tblmunicipio` (
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `tbl_departamentos_codigo` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblmunicipio`
--

INSERT INTO `tblmunicipio` (`codigo`, `nombre`, `tbl_departamentos_codigo`) VALUES
('1', 'EL ENCANTO', '1'),
('10', 'PUERTO SANTANDER', '1'),
('100', 'SAN ANDRÉS DE CUERQUÍA', '2'),
('1000', 'CHALÁN', '29'),
('1001', 'COLOSO', '29'),
('1002', 'COROZAL', '29'),
('1003', 'COVEÑAS', '29'),
('1004', 'EL ROBLE', '29'),
('1005', 'GALERAS', '29'),
('1006', 'GUARANDA', '29'),
('1007', 'LA UNIÓN', '29'),
('1008', 'LOS PALMITOS', '29'),
('1009', 'MAJAGUAL', '29'),
('101', 'SAN CARLOS', '2'),
('1010', 'MORROA', '29'),
('1011', 'OVEJAS', '29'),
('1012', 'PALMITO', '29'),
('1013', 'SAMPUÉS', '29'),
('1014', 'SAN BENITO ABAD', '29'),
('1015', 'SAN JUAN DE BETULIA', '29'),
('1016', 'SAN LUIS DE SINCÉ', '29'),
('1017', 'SAN MARCOS', '29'),
('1018', 'SAN ONOFRE', '29'),
('1019', 'SAN PEDRO', '29'),
('102', 'SAN FRANCISCO', '2'),
('1020', 'SANTIAGO DE TOLÚ', '29'),
('1021', 'SINCELEJO', '29'),
('1022', 'SUCRE', '29'),
('1023', 'TOLÚ VIEJO', '29'),
('1024', 'ALPUJARRA', '30'),
('1025', 'ALVARADO', '30'),
('1026', 'AMBALEMA', '30'),
('1027', 'ANZOÁTEGUI', '30'),
('1028', 'ARMERO GUAYABAL', '30'),
('1029', 'ATACO', '30'),
('103', 'SAN JERÓNIMO', '2'),
('1030', 'CAJAMARCA', '30'),
('1031', 'CARMEN DE APICALÁ', '30'),
('1032', 'CASABIANCA', '30'),
('1033', 'CHAPARRAL', '30'),
('1034', 'COELLO', '30'),
('1035', 'COYAIMA', '30'),
('1036', 'CUNDAY', '30'),
('1037', 'DOLORES', '30'),
('1038', 'ESPINAL', '30'),
('1039', 'FALAN', '30'),
('104', 'SAN JOSÉ DE LA MONTAÑA', '2'),
('1040', 'FLANDES', '30'),
('1041', 'FRESNO', '30'),
('1042', 'GUAMO', '30'),
('1043', 'HERVEO', '30'),
('1044', 'HONDA', '30'),
('1045', 'IBAGUÉ', '30'),
('1046', 'ICONONZO', '30'),
('1047', 'LÉRIDA', '30'),
('1048', 'LÍBANO', '30'),
('1049', 'MELGAR', '30'),
('105', 'SAN JUAN DE URABÁ', '2'),
('1050', 'MURILLO', '30'),
('1051', 'NATAGAIMA', '30'),
('1052', 'ORTEGA', '30'),
('1053', 'PALOCABILDO', '30'),
('1054', 'PIEDRAS', '30'),
('1055', 'PLANADAS', '30'),
('1056', 'PRADO', '30'),
('1057', 'PURIFICACIÓN', '30'),
('1058', 'RIOBLANCO', '30'),
('1059', 'RONCESVALLES', '30'),
('106', 'SAN LUIS', '2'),
('1060', 'ROVIRA', '30'),
('1061', 'SALDAÑA', '30'),
('1062', 'SAN ANTONIO', '30'),
('1063', 'SAN LUIS', '30'),
('1064', 'SAN SEBASTIÁN DE MARIQUITA', '30'),
('1065', 'SANTA ISABEL', '30'),
('1066', 'SUÁREZ', '30'),
('1067', 'VALLE DE SAN JUAN', '30'),
('1068', 'VENADILLO', '30'),
('1069', 'VILLAHERMOSA', '30'),
('107', 'SAN PEDRO DE LOS MILAGROS', '2'),
('1070', 'VILLARRICA', '30'),
('1071', 'ALCALÁ', '31'),
('1072', 'ANDALUCÍA', '31'),
('1073', 'ANSERMANUEVO', '31'),
('1074', 'ARGELIA', '31'),
('1075', 'BOLÍVAR', '31'),
('1076', 'BUENAVENTURA', '31'),
('1077', 'BUGALAGRANDE', '31'),
('1078', 'CAICEDONIA', '31'),
('1079', 'CALI', '31'),
('108', 'SAN PEDRO DE URABÁ', '2'),
('1080', 'CALIMA', '31'),
('1081', 'CANDELARIA', '31'),
('1082', 'CARTAGO', '31'),
('1083', 'DAGUA', '31'),
('1084', 'EL ÁGUILA', '31'),
('1085', 'EL CAIRO', '31'),
('1086', 'EL CERRITO', '31'),
('1087', 'EL DOVIO', '31'),
('1088', 'FLORIDA', '31'),
('1089', 'GINEBRA', '31'),
('109', 'SAN RAFAEL', '2'),
('1090', 'GUACARÍ', '31'),
('1091', 'GUADALAJARA DE BUGA', '31'),
('1092', 'JAMUNDÍ', '31'),
('1093', 'LA CUMBRE', '31'),
('1094', 'LA UNIÓN', '31'),
('1095', 'LA VICTORIA', '31'),
('1096', 'OBANDO', '31'),
('1097', 'PALMIRA', '31'),
('1098', 'PRADERA', '31'),
('1099', 'RESTREPO', '31'),
('11', 'TARAPACÁ', '1'),
('110', 'SAN ROQUE', '2'),
('1100', 'RIOFRÍO', '31'),
('1101', 'ROLDANILLO', '31'),
('1102', 'SAN PEDRO', '31'),
('1103', 'SEVILLA', '31'),
('1104', 'TORO', '31'),
('1105', 'TRUJILLO', '31'),
('1106', 'TULUÁ', '31'),
('1107', 'ULLOA', '31'),
('1108', 'VERSALLES', '31'),
('1109', 'VIJES', '31'),
('111', 'SAN VICENTE FERRER', '2'),
('1110', 'YOTOCO', '31'),
('1111', 'YUMBO', '31'),
('1112', 'ZARZAL', '31'),
('1113', 'CARURÚ', '32'),
('1114', 'MITÚ', '32'),
('1115', 'PACOA', '32'),
('1116', 'PAPUNAUA', '32'),
('1117', 'TARAIRA', '32'),
('1118', 'YAVARATÉ', '32'),
('1119', 'CUMARIBO', '33'),
('112', 'SANTA BÁRBARA', '2'),
('1120', 'LA PRIMAVERA', '33'),
('1121', 'PUERTO CARREÑO', '33'),
('1122', 'SANTA ROSALÍA', '33'),
('113', 'SANTA FÉ DE ANTIOQUIA', '2'),
('114', 'SANTA ROSA DE OSOS', '2'),
('115', 'SANTO DOMINGO', '2'),
('116', 'SEGOVIA', '2'),
('117', 'SONSÓN', '2'),
('118', 'SOPETRÁN', '2'),
('119', 'TÁMESIS', '2'),
('12', 'ABEJORRAL', '2'),
('120', 'TARAZÁ', '2'),
('121', 'TARSO', '2'),
('122', 'TITIRIBÍ', '2'),
('123', 'TOLEDO', '2'),
('124', 'TURBO', '2'),
('125', 'URAMITA', '2'),
('126', 'URRAO', '2'),
('127', 'VALDIVIA', '2'),
('128', 'VALPARAÍSO', '2'),
('129', 'VEGACHÍ', '2'),
('13', 'ABRIAQUÍ', '2'),
('130', 'VENECIA', '2'),
('131', 'VIGÍA DEL FUERTE', '2'),
('132', 'YALÍ', '2'),
('133', 'YARUMAL', '2'),
('134', 'YOLOMBÓ', '2'),
('135', 'YONDÓ', '2'),
('136', 'ZARAGOZA', '2'),
('137', 'ARAUCA', '3'),
('138', 'ARAUQUITA', '3'),
('139', 'CRAVO NORTE', '3'),
('14', 'ALEJANDRÍA', '2'),
('140', 'FORTUL', '3'),
('141', 'PUERTO RONDÓN', '3'),
('142', 'SARAVENA', '3'),
('143', 'TAME', '3'),
('144', 'PROVIDENCIA', '4'),
('145', 'SAN ANDRÉS', '4'),
('146', 'BARANOA', '5'),
('147', 'BARRANQUILLA', '5'),
('148', 'CAMPO DE LA CRUZ', '5'),
('149', 'CANDELARIA', '5'),
('15', 'AMAGÁ', '2'),
('150', 'GALAPA', '5'),
('151', 'JUAN DE ACOSTA', '5'),
('152', 'LURUACO', '5'),
('153', 'MALAMBO', '5'),
('154', 'MANATÍ', '5'),
('155', 'PALMAR DE VARELA', '5'),
('156', 'PIOJÓ', '5'),
('157', 'POLONUEVO', '5'),
('158', 'PONEDERA', '5'),
('159', 'PUERTO COLOMBIA', '5'),
('16', 'AMALFI', '2'),
('160', 'REPELÓN', '5'),
('161', 'SABANAGRANDE', '5'),
('162', 'SABANALARGA', '5'),
('163', 'SANTA LUCÍA', '5'),
('164', 'SANTO TOMÁS', '5'),
('165', 'SOLEDAD', '5'),
('166', 'SUAN', '5'),
('167', 'TUBARÁ', '5'),
('168', 'USIACURÍ', '5'),
('169', 'BOGOTÁ, D.C.', '6'),
('17', 'ANDES', '2'),
('170', 'ACHÍ', '7'),
('171', 'ALTOS DEL ROSARIO', '7'),
('172', 'ARENAL', '7'),
('173', 'ARJONA', '7'),
('174', 'ARROYOHONDO', '7'),
('175', 'BARRANCO DE LOBA', '7'),
('176', 'CALAMAR', '7'),
('177', 'CANTAGALLO', '7'),
('178', 'CARTAGENA DE INDIAS', '7'),
('179', 'CICUCO', '7'),
('18', 'ANGELÓPOLIS', '2'),
('180', 'CLEMENCIA', '7'),
('181', 'CÓRDOBA', '7'),
('182', 'EL CARMEN DE BOLÍVAR', '7'),
('183', 'EL GUAMO', '7'),
('184', 'EL PEÑÓN', '7'),
('185', 'HATILLO DE LOBA', '7'),
('186', 'MAGANGUÉ', '7'),
('187', 'MAHATES', '7'),
('188', 'MARGARITA', '7'),
('189', 'MARÍA LA BAJA', '7'),
('19', 'ANGOSTURA', '2'),
('190', 'MOMPÓS', '7'),
('191', 'MONTECRISTO', '7'),
('192', 'MORALES', '7'),
('193', 'NOROSÍ', '7'),
('194', 'PINILLOS', '7'),
('195', 'REGIDOR', '7'),
('196', 'RÍO VIEJO', '7'),
('197', 'SAN CRISTÓBAL', '7'),
('198', 'SAN ESTANISLAO', '7'),
('199', 'SAN FERNANDO', '7'),
('2', 'LA CHORRERA', '1'),
('20', 'ANORÍ', '2'),
('200', 'SAN JACINTO', '7'),
('201', 'SAN JACINTO DEL CAUCA', '7'),
('202', 'SAN JUAN NEPOMUCENO', '7'),
('203', 'SAN MARTÍN DE LOBA', '7'),
('204', 'SAN PABLO', '7'),
('205', 'SANTA CATALINA', '7'),
('206', 'SANTA ROSA', '7'),
('207', 'SANTA ROSA DEL SUR', '7'),
('208', 'SIMITÍ', '7'),
('209', 'SOPLAVIENTO', '7'),
('21', 'ANZÁ', '2'),
('210', 'TALAIGUA NUEVO', '7'),
('211', 'TIQUISIO', '7'),
('212', 'TURBACO', '7'),
('213', 'TURBANÁ', '7'),
('214', 'VILLANUEVA', '7'),
('215', 'ZAMBRANO', '7'),
('216', 'ALMEIDA', '8'),
('217', 'AQUITANIA', '8'),
('218', 'ARCABUCO', '8'),
('219', 'BELÉN', '8'),
('22', 'APARTADÓ', '2'),
('220', 'BERBEO', '8'),
('221', 'BETÉITIVA', '8'),
('222', 'BOAVITA', '8'),
('223', 'BOYACÁ', '8'),
('224', 'BRICEÑO', '8'),
('225', 'BUENAVISTA', '8'),
('226', 'BUSBANZÁ', '8'),
('227', 'CALDAS', '8'),
('228', 'CAMPOHERMOSO', '8'),
('229', 'CERINZA', '8'),
('23', 'ARBOLETES', '2'),
('230', 'CHINAVITA', '8'),
('231', 'CHIQUINQUIRÁ', '8'),
('232', 'CHÍQUIZA', '8'),
('233', 'CHISCAS', '8'),
('234', 'CHITA', '8'),
('235', 'CHITARAQUE', '8'),
('236', 'CHIVATÁ', '8'),
('237', 'CHIVOR', '8'),
('238', 'CIÉNEGA', '8'),
('239', 'CÓMBITA', '8'),
('24', 'ARGELIA', '2'),
('240', 'COPER', '8'),
('241', 'CORRALES', '8'),
('242', 'COVARACHÍA', '8'),
('243', 'CUBARÁ', '8'),
('244', 'CUCAITA', '8'),
('245', 'CUÍTIVA', '8'),
('246', 'DUITAMA', '8'),
('247', 'EL COCUY', '8'),
('248', 'EL ESPINO', '8'),
('249', 'FIRAVITOBA', '8'),
('25', 'ARMENIA', '2'),
('250', 'FLORESTA', '8'),
('251', 'GACHANTIVÁ', '8'),
('252', 'GÁMEZA', '8'),
('253', 'GARAGOA', '8'),
('254', 'GUACAMAYAS', '8'),
('255', 'GUATEQUE', '8'),
('256', 'GUAYATÁ', '8'),
('257', 'GÜICÁN', '8'),
('258', 'IZA', '8'),
('259', 'JENESANO', '8'),
('26', 'BARBOSA', '2'),
('260', 'JERICÓ', '8'),
('261', 'LA CAPILLA', '8'),
('262', 'LA UVITA', '8'),
('263', 'LA VICTORIA', '8'),
('264', 'LABRANZAGRANDE', '8'),
('265', 'MACANAL', '8'),
('266', 'MARIPÍ', '8'),
('267', 'MIRAFLORES', '8'),
('268', 'MONGUA', '8'),
('269', 'MONGUÍ', '8'),
('27', 'BELLO', '2'),
('270', 'MONIQUIRÁ', '8'),
('271', 'MOTAVITA', '8'),
('272', 'MUZO', '8'),
('273', 'NOBSA', '8'),
('274', 'NUEVO COLÓN', '8'),
('275', 'OICATÁ', '8'),
('276', 'OTANCHE', '8'),
('277', 'PACHAVITA', '8'),
('278', 'PÁEZ', '8'),
('279', 'PAIPA', '8'),
('28', 'BELMIRA', '2'),
('280', 'PAJARITO', '8'),
('281', 'PANQUEBA', '8'),
('282', 'PAUNA', '8'),
('283', 'PAYA', '8'),
('284', 'PAZ DE RÍO', '8'),
('285', 'PESCA', '8'),
('286', 'PISBA', '8'),
('287', 'PUERTO BOYACÁ', '8'),
('288', 'QUÍPAMA', '8'),
('289', 'RAMIRIQUÍ', '8'),
('29', 'BETANIA', '2'),
('290', 'RÁQUIRA', '8'),
('291', 'RONDÓN', '8'),
('292', 'SABOYÁ', '8'),
('293', 'SÁCHICA', '8'),
('294', 'SAMACÁ', '8'),
('295', 'SAN EDUARDO', '8'),
('296', 'SAN JOSÉ DE PARE', '8'),
('297', 'SAN LUIS DE GACENO', '8'),
('298', 'SAN MATEO', '8'),
('299', 'SAN MIGUEL DE SEMA', '8'),
('3', 'LA PEDRERA', '1'),
('30', 'BETULIA', '2'),
('300', 'SAN PABLO DE BORBUR', '8'),
('301', 'SANTA MARÍA', '8'),
('302', 'SANTA ROSA DE VITERBO', '8'),
('303', 'SANTA SOFÍA', '8'),
('304', 'SANTANA', '8'),
('305', 'SATIVANORTE', '8'),
('306', 'SATIVASUR', '8'),
('307', 'SIACHOQUE', '8'),
('308', 'SOATÁ', '8'),
('309', 'SOCHA', '8'),
('31', 'BRICEÑO', '2'),
('310', 'SOCOTÁ', '8'),
('311', 'SOGAMOSO', '8'),
('312', 'SOMONDOCO', '8'),
('313', 'SORA', '8'),
('314', 'SORACÁ', '8'),
('315', 'SOTAQUIRÁ', '8'),
('316', 'SUSACÓN', '8'),
('317', 'SUTAMARCHÁN', '8'),
('318', 'SUTATENZA', '8'),
('319', 'TASCO', '8'),
('32', 'BURITICÁ', '2'),
('320', 'TENZA', '8'),
('321', 'TIBANÁ', '8'),
('322', 'TIBASOSA', '8'),
('323', 'TINJACÁ', '8'),
('324', 'TIPACOQUE', '8'),
('325', 'TOCA', '8'),
('326', 'TOGÜÍ', '8'),
('327', 'TÓPAGA', '8'),
('328', 'TOTA', '8'),
('329', 'TUNJA', '8'),
('33', 'CÁCERES', '2'),
('330', 'TUNUNGUÁ', '8'),
('331', 'TURMEQUÉ', '8'),
('332', 'TUTA', '8'),
('333', 'TUTAZÁ', '8'),
('334', 'ÚMBITA', '8'),
('335', 'VENTAQUEMADA', '8'),
('336', 'VILLA DE LEYVA', '8'),
('337', 'VIRACACHÁ', '8'),
('338', 'ZETAQUIRA', '8'),
('339', 'AGUADAS', '9'),
('34', 'CAICEDO', '2'),
('340', 'ANSERMA', '9'),
('341', 'ARANZAZU', '9'),
('342', 'BELALCÁZAR', '9'),
('343', 'CHINCHINÁ', '9'),
('344', 'FILADELFIA', '9'),
('345', 'LA DORADA', '9'),
('346', 'LA MERCED', '9'),
('347', 'MANIZALES', '9'),
('348', 'MANZANARES', '9'),
('349', 'MARMATO', '9'),
('35', 'CALDAS', '2'),
('350', 'MARQUETALIA', '9'),
('351', 'MARULANDA', '9'),
('352', 'NEIRA', '9'),
('353', 'NORCASIA', '9'),
('354', 'PÁCORA', '9'),
('355', 'PALESTINA', '9'),
('356', 'PENSILVANIA', '9'),
('357', 'RIOSUCIO', '9'),
('358', 'RISARALDA', '9'),
('359', 'SALAMINA', '9'),
('36', 'CAMPAMENTO', '2'),
('360', 'SAMANÁ', '9'),
('361', 'SAN JOSÉ', '9'),
('362', 'SUPÍA', '9'),
('363', 'VICTORIA', '9'),
('364', 'VILLAMARÍA', '9'),
('365', 'VITERBO', '9'),
('366', 'ALBANIA', '10'),
('367', 'BELÉN DE LOS ANDAQUÍES', '10'),
('368', 'CARTAGENA DEL CHAIRÁ', '10'),
('369', 'CURILLO', '10'),
('37', 'CAÑASGORDAS', '2'),
('370', 'EL DONCELLO', '10'),
('371', 'EL PAUJÍL', '10'),
('372', 'FLORENCIA', '10'),
('373', 'LA MONTAÑITA', '10'),
('374', 'MILÁN', '10'),
('375', 'MORELIA', '10'),
('376', 'PUERTO RICO', '10'),
('377', 'SAN JOSÉ DEL FRAGUA', '10'),
('378', 'SAN VICENTE DEL CAGUÁN', '10'),
('379', 'SOLANO', '10'),
('38', 'CARACOLÍ', '2'),
('380', 'SOLITA', '10'),
('381', 'VALPARAÍSO', '10'),
('382', 'AGUAZUL', '11'),
('383', 'CHÁMEZA', '11'),
('384', 'HATO COROZAL', '11'),
('385', 'LA SALINA', '11'),
('386', 'MANÍ', '11'),
('387', 'MONTERREY', '11'),
('388', 'NUNCHÍA', '11'),
('389', 'OROCUÉ', '11'),
('39', 'CARAMANTA', '2'),
('390', 'PAZ DE ARIPORO', '11'),
('391', 'PORE', '11'),
('392', 'RECETOR', '11'),
('393', 'SABANALARGA', '11'),
('394', 'SÁCAMA', '11'),
('395', 'SAN LUIS DE PALENQUE', '11'),
('396', 'TÁMARA', '11'),
('397', 'TAURAMENA', '11'),
('398', 'TRINIDAD', '11'),
('399', 'VILLANUEVA', '11'),
('4', 'LA VICTORIA', '1'),
('40', 'CAREPA', '2'),
('400', 'YOPAL', '11'),
('401', 'ALMAGUER', '12'),
('402', 'ARGELIA', '12'),
('403', 'BALBOA', '12'),
('404', 'BOLÍVAR', '12'),
('405', 'BUENOS AIRES', '12'),
('406', 'CAJIBÍO', '12'),
('407', 'CALDONO', '12'),
('408', 'CALOTO', '12'),
('409', 'CORINTO', '12'),
('41', 'CAROLINA', '2'),
('410', 'EL TAMBO', '12'),
('411', 'FLORENCIA', '12'),
('412', 'GUACHENÉ', '12'),
('413', 'GUAPÍ', '12'),
('414', 'INZÁ', '12'),
('415', 'JAMBALÓ', '12'),
('416', 'LA SIERRA', '12'),
('417', 'LA VEGA', '12'),
('418', 'LÓPEZ DE MICAY', '12'),
('419', 'MERCADERES', '12'),
('42', 'CAUCASIA', '2'),
('420', 'MIRANDA', '12'),
('421', 'MORALES', '12'),
('422', 'PADILLA', '12'),
('423', 'PÁEZ', '12'),
('424', 'PATÍA', '12'),
('425', 'PIAMONTE', '12'),
('426', 'PIENDAMÓ', '12'),
('427', 'POPAYÁN', '12'),
('428', 'PUERTO TEJADA', '12'),
('429', 'PURACÉ', '12'),
('43', 'CHIGORODÓ', '2'),
('430', 'ROSAS', '12'),
('431', 'SAN SEBASTIÁN', '12'),
('432', 'SANTA ROSA', '12'),
('433', 'SANTANDER DE QUILICHAO', '12'),
('434', 'SILVIA', '12'),
('435', 'SOTARA', '12'),
('436', 'SUÁREZ', '12'),
('437', 'SUCRE', '12'),
('438', 'TIMBÍO', '12'),
('439', 'TIMBIQUÍ', '12'),
('44', 'CISNEROS', '2'),
('440', 'TORIBÍO', '12'),
('441', 'TOTORÓ', '12'),
('442', 'VILLA RICA', '12'),
('443', 'AGUACHICA', '13'),
('444', 'AGUSTÍN CODAZZI', '13'),
('445', 'ASTREA', '13'),
('446', 'BECERRIL', '13'),
('447', 'BOSCONIA', '13'),
('448', 'CHIMICHAGUA', '13'),
('449', 'CHIRIGUANÁ', '13'),
('45', 'CIUDAD BOLÍVAR', '2'),
('450', 'CURUMANÍ', '13'),
('451', 'EL COPEY', '13'),
('452', 'EL PASO', '13'),
('453', 'GAMARRA', '13'),
('454', 'GONZÁLEZ', '13'),
('455', 'LA GLORIA', '13'),
('456', 'LA JAGUA DE IBIRICO', '13'),
('457', 'LA PAZ', '13'),
('458', 'MANAURE BALCÓN DEL CESAR', '13'),
('459', 'PAILITAS', '13'),
('46', 'COCORNÁ', '2'),
('460', 'PELAYA', '13'),
('461', 'PUEBLO BELLO', '13'),
('462', 'RÍO DE ORO', '13'),
('463', 'SAN ALBERTO', '13'),
('464', 'SAN DIEGO', '13'),
('465', 'SAN MARTÍN', '13'),
('466', 'TAMALAMEQUE', '13'),
('467', 'VALLEDUPAR', '13'),
('468', 'ACANDÍ', '14'),
('469', 'ALTO BAUDÓ', '14'),
('47', 'CONCEPCIÓN', '2'),
('470', 'ATRATO', '14'),
('471', 'BAGADÓ', '14'),
('472', 'BAHÍA SOLANO', '14'),
('473', 'BAJO BAUDÓ', '14'),
('474', 'BOJAYÁ', '14'),
('475', 'CARMEN DEL DARIÉN', '14'),
('476', 'CÉRTEGUI', '14'),
('477', 'CONDOTO', '14'),
('478', 'EL CANTÓN DEL SAN PABLO', '14'),
('479', 'EL CARMEN DE ATRATO', '14'),
('48', 'CONCORDIA', '2'),
('480', 'EL LITORAL DEL SAN JUAN', '14'),
('481', 'ISTMINA', '14'),
('482', 'JURADÓ', '14'),
('483', 'LLORÓ', '14'),
('484', 'MEDIO ATRATO', '14'),
('485', 'MEDIO BAUDÓ', '14'),
('486', 'MEDIO SAN JUAN', '14'),
('487', 'NÓVITA', '14'),
('488', 'NUQUÍ', '14'),
('489', 'QUIBDÓ', '14'),
('49', 'COPACABANA', '2'),
('490', 'RÍO IRÓ', '14'),
('491', 'RÍO QUITO', '14'),
('492', 'RIOSUCIO', '14'),
('493', 'SAN JOSÉ DEL PALMAR', '14'),
('494', 'SIPÍ', '14'),
('495', 'TADÓ', '14'),
('496', 'UNGUÍA', '14'),
('497', 'UNIÓN PANAMERICANA', '14'),
('498', 'AYAPEL', '15'),
('499', 'BUENAVISTA', '15'),
('5', 'LETICIA', '1'),
('50', 'DABEIBA', '2'),
('500', 'CANALETE', '15'),
('501', 'CERETÉ', '15'),
('502', 'CHIMÁ', '15'),
('503', 'CHINÚ', '15'),
('504', 'CIÉNAGA DE ORO', '15'),
('505', 'COTORRA', '15'),
('506', 'LA APARTADA', '15'),
('507', 'LORICA', '15'),
('508', 'LOS CÓRDOBAS', '15'),
('509', 'MOMIL', '15'),
('51', 'DONMATÍAS', '2'),
('510', 'MONTELÍBANO', '15'),
('511', 'MONTERÍA', '15'),
('512', 'MOÑITOS', '15'),
('513', 'PLANETA RICA', '15'),
('514', 'PUEBLO NUEVO', '15'),
('515', 'PUERTO ESCONDIDO', '15'),
('516', 'PUERTO LIBERTADOR', '15'),
('517', 'PURÍSIMA DE LA CONCEPCIÓN', '15'),
('518', 'SAHAGÚN', '15'),
('519', 'SAN ANDRÉS DE SOTAVENTO', '15'),
('52', 'EBÉJICO', '2'),
('520', 'SAN ANTERO', '15'),
('521', 'SAN BERNARDO DEL VIENTO', '15'),
('522', 'SAN CARLOS', '15'),
('523', 'SAN JOSÉ DE URÉ', '15'),
('524', 'SAN PELAYO', '15'),
('525', 'TIERRALTA', '15'),
('526', 'TUCHÍN', '15'),
('527', 'VALENCIA', '15'),
('528', 'AGUA DE DIOS', '16'),
('529', 'ALBÁN', '16'),
('53', 'EL BAGRE', '2'),
('530', 'ANAPOIMA', '16'),
('531', 'ANOLAIMA', '16'),
('532', 'APULO', '16'),
('533', 'ARBELÁEZ', '16'),
('534', 'BELTRÁN', '16'),
('535', 'BITUIMA', '16'),
('536', 'BOJACÁ', '16'),
('537', 'CABRERA', '16'),
('538', 'CACHIPAY', '16'),
('539', 'CAJICÁ', '16'),
('54', 'EL CARMEN DE VIBORAL', '2'),
('540', 'CAPARRAPÍ', '16'),
('541', 'CÁQUEZA', '16'),
('542', 'CARMEN DE CARUPA', '16'),
('543', 'CHAGUANÍ', '16'),
('544', 'CHÍA', '16'),
('545', 'CHIPAQUE', '16'),
('546', 'CHOACHÍ', '16'),
('547', 'CHOCONTÁ', '16'),
('548', 'COGUA', '16'),
('549', 'COTA', '16'),
('55', 'EL SANTUARIO', '2'),
('550', 'CUCUNUBÁ', '16'),
('551', 'EL COLEGIO', '16'),
('552', 'EL PEÑÓN', '16'),
('553', 'EL ROSAL', '16'),
('554', 'FACATATIVÁ', '16'),
('555', 'FÓMEQUE', '16'),
('556', 'FOSCA', '16'),
('557', 'FUNZA', '16'),
('558', 'FÚQUENE', '16'),
('559', 'FUSAGASUGÁ', '16'),
('56', 'ENTRERRÍOS', '2'),
('560', 'GACHALÁ', '16'),
('561', 'GACHANCIPÁ', '16'),
('562', 'GACHETÁ', '16'),
('563', 'GAMA', '16'),
('564', 'GIRARDOT', '16'),
('565', 'GRANADA', '16'),
('566', 'GUACHETÁ', '16'),
('567', 'GUADUAS', '16'),
('568', 'GUASCA', '16'),
('569', 'GUATAQUÍ', '16'),
('57', 'ENVIGADO', '2'),
('570', 'GUATAVITA', '16'),
('571', 'GUAYABAL DE SÍQUIMA', '16'),
('572', 'GUAYABETAL', '16'),
('573', 'GUTIÉRREZ', '16'),
('574', 'JERUSALÉN', '16'),
('575', 'JUNÍN', '16'),
('576', 'LA CALERA', '16'),
('577', 'LA MESA', '16'),
('578', 'LA PALMA', '16'),
('579', 'LA PEÑA', '16'),
('58', 'FREDONIA', '2'),
('580', 'LA VEGA', '16'),
('581', 'LENGUAZAQUE', '16'),
('582', 'MACHETÁ', '16'),
('583', 'MADRID', '16'),
('584', 'MANTA', '16'),
('585', 'MEDINA', '16'),
('586', 'MOSQUERA', '16'),
('587', 'NARIÑO', '16'),
('588', 'NEMOCÓN', '16'),
('589', 'NILO', '16'),
('59', 'FRONTINO', '2'),
('590', 'NIMAIMA', '16'),
('591', 'NOCAIMA', '16'),
('592', 'PACHO', '16'),
('593', 'PAIME', '16'),
('594', 'PANDI', '16'),
('595', 'PARATEBUENO', '16'),
('596', 'PASCA', '16'),
('597', 'PUERTO SALGAR', '16'),
('598', 'PULÍ', '16'),
('599', 'QUEBRADANEGRA', '16'),
('6', 'MIRITÍ - PARANÁ', '1'),
('60', 'GIRALDO', '2'),
('600', 'QUETAME', '16'),
('601', 'QUIPILE', '16'),
('602', 'RICAURTE', '16'),
('603', 'SAN ANTONIO DEL TEQUENDAMA', '16'),
('604', 'SAN BERNARDO', '16'),
('605', 'SAN CAYETANO', '16'),
('606', 'SAN FRANCISCO', '16'),
('607', 'SAN JUAN DE RIOSECO', '16'),
('608', 'SASAIMA', '16'),
('609', 'SESQUILÉ', '16'),
('61', 'GIRARDOTA', '2'),
('610', 'SIBATÉ', '16'),
('611', 'SILVANIA', '16'),
('612', 'SIMIJACA', '16'),
('613', 'SOACHA', '16'),
('614', 'SOPÓ', '16'),
('615', 'SUBACHOQUE', '16'),
('616', 'SUESCA', '16'),
('617', 'SUPATÁ', '16'),
('618', 'SUSA', '16'),
('619', 'SUTATAUSA', '16'),
('62', 'GÓMEZ PLATA', '2'),
('620', 'TABIO', '16'),
('621', 'TAUSA', '16'),
('622', 'TENA', '16'),
('623', 'TENJO', '16'),
('624', 'TIBACUY', '16'),
('625', 'TIBIRITA', '16'),
('626', 'TOCAIMA', '16'),
('627', 'TOCANCIPÁ', '16'),
('628', 'TOPAIPÍ', '16'),
('629', 'UBALÁ', '16'),
('63', 'GRANADA', '2'),
('630', 'UBAQUE', '16'),
('631', 'UNE', '16'),
('632', 'ÚTICA', '16'),
('633', 'VENECIA', '16'),
('634', 'VERGARA', '16'),
('635', 'VIANÍ', '16'),
('636', 'VILLA DE SAN DIEGO DE UBATÉ', '16'),
('637', 'VILLAGÓMEZ', '16'),
('638', 'VILLAPINZÓN', '16'),
('639', 'VILLETA', '16'),
('64', 'GUADALUPE', '2'),
('640', 'VIOTÁ', '16'),
('641', 'YACOPÍ', '16'),
('642', 'ZIPACÓN', '16'),
('643', 'ZIPAQUIRÁ', '16'),
('644', 'BARRANCO MINAS', '17'),
('645', 'CACAHUAL', '17'),
('646', 'INÍRIDA', '17'),
('647', 'LA GUADALUPE', '17'),
('648', 'MAPIRIPANA', '17'),
('649', 'MORICHAL', '17'),
('65', 'GUARNE', '2'),
('650', 'PANA PANA', '17'),
('651', 'PUERTO COLOMBIA', '17'),
('652', 'SAN FELIPE', '17'),
('653', 'CALAMAR', '18'),
('654', 'EL RETORNO', '18'),
('655', 'MIRAFLORES', '18'),
('656', 'SAN JOSÉ DEL GUAVIARE', '18'),
('657', 'ACEVEDO', '19'),
('658', 'AGRADO', '19'),
('659', 'AIPE', '19'),
('66', 'GUATAPÉ', '2'),
('660', 'ALGECIRAS', '19'),
('661', 'ALTAMIRA', '19'),
('662', 'BARAYA', '19'),
('663', 'CAMPOALEGRE', '19'),
('664', 'COLOMBIA', '19'),
('665', 'ELÍAS', '19'),
('666', 'GARZÓN', '19'),
('667', 'GIGANTE', '19'),
('668', 'GUADALUPE', '19'),
('669', 'HOBO', '19'),
('67', 'HELICONIA', '2'),
('670', 'ÍQUIRA', '19'),
('671', 'ISNOS', '19'),
('672', 'LA ARGENTINA', '19'),
('673', 'LA PLATA', '19'),
('674', 'NÁTAGA', '19'),
('675', 'NEIVA', '19'),
('676', 'OPORAPA', '19'),
('677', 'PAICOL', '19'),
('678', 'PALERMO', '19'),
('679', 'PALESTINA', '19'),
('68', 'HISPANIA', '2'),
('680', 'PITAL', '19'),
('681', 'PITALITO', '19'),
('682', 'RIVERA', '19'),
('683', 'SALADOBLANCO', '19'),
('684', 'SAN AGUSTÍN', '19'),
('685', 'SANTA MARÍA', '19'),
('686', 'SUAZA', '19'),
('687', 'TARQUI', '19'),
('688', 'TELLO', '19'),
('689', 'TERUEL', '19'),
('69', 'ITAGÜÍ', '2'),
('690', 'TESALIA', '19'),
('691', 'TIMANÁ', '19'),
('692', 'VILLAVIEJA', '19'),
('693', 'YAGUARÁ', '19'),
('694', 'ALBANIA', '20'),
('695', 'BARRANCAS', '20'),
('696', 'DIBULLA', '20'),
('697', 'DISTRACCIÓN', '20'),
('698', 'EL MOLINO', '20'),
('699', 'FONSECA', '20'),
('7', 'PUERTO ALEGRÍA', '1'),
('70', 'ITUANGO', '2'),
('700', 'HATONUEVO', '20'),
('701', 'LA JAGUA DEL PILAR', '20'),
('702', 'MAICAO', '20'),
('703', 'MANAURE', '20'),
('704', 'RIOHACHA', '20'),
('705', 'SAN JUAN DEL CESAR', '20'),
('706', 'URIBIA', '20'),
('707', 'URUMITA', '20'),
('708', 'VILLANUEVA', '20'),
('709', 'ALGARROBO', '21'),
('71', 'JARDÍN', '2'),
('710', 'ARACATACA', '21'),
('711', 'ARIGUANÍ', '21'),
('712', 'CERRO DE SAN ANTONIO', '21'),
('713', 'CHIVOLO', '21'),
('714', 'CIÉNAGA', '21'),
('715', 'CONCORDIA', '21'),
('716', 'EL BANCO', '21'),
('717', 'EL PIÑÓN', '21'),
('718', 'EL RETÉN', '21'),
('719', 'FUNDACIÓN', '21'),
('72', 'JERICÓ', '2'),
('720', 'GUAMAL', '21'),
('721', 'NUEVA GRANADA', '21'),
('722', 'PEDRAZA', '21'),
('723', 'PIJIÑO DEL CARMEN', '21'),
('724', 'PIVIJAY', '21'),
('725', 'PLATO', '21'),
('726', 'PUEBLOVIEJO', '21'),
('727', 'REMOLINO', '21'),
('728', 'SABANAS DE SAN ÁNGEL', '21'),
('729', 'SALAMINA', '21'),
('73', 'LA CEJA', '2'),
('730', 'SAN SEBASTIÁN DE BUENAVISTA', '21'),
('731', 'SAN ZENÓN', '21'),
('732', 'SANTA ANA', '21'),
('733', 'SANTA BÁRBARA DE PINTO', '21'),
('734', 'SANTA MARTA', '21'),
('735', 'SITIONUEVO', '21'),
('736', 'TENERIFE', '21'),
('737', 'ZAPAYÁN', '21'),
('738', 'ZONA BANANERA', '21'),
('739', 'ACACÍAS', '22'),
('74', 'LA ESTRELLA', '2'),
('740', 'BARRANCA DE UPÍA', '22'),
('741', 'CABUYARO', '22'),
('742', 'CASTILLA LA NUEVA', '22'),
('743', 'CUMARAL', '22'),
('744', 'EL CALVARIO', '22'),
('745', 'EL CASTILLO', '22'),
('746', 'EL DORADO', '22'),
('747', 'FUENTE DE ORO', '22'),
('748', 'GRANADA', '22'),
('749', 'GUAMAL', '22'),
('75', 'LA PINTADA', '2'),
('750', 'LA MACARENA', '22'),
('751', 'LEJANÍAS', '22'),
('752', 'MAPIRIPÁN', '22'),
('753', 'MESETAS', '22'),
('754', 'PUERTO CONCORDIA', '22'),
('755', 'PUERTO GAITÁN', '22'),
('756', 'PUERTO LLERAS', '22'),
('757', 'PUERTO LÓPEZ', '22'),
('758', 'PUERTO RICO', '22'),
('759', 'RESTREPO', '22'),
('76', 'LA UNIÓN', '2'),
('760', 'SAN CARLOS DE GUAROA', '22'),
('761', 'SAN JUAN DE ARAMA', '22'),
('762', 'SAN JUANITO', '22'),
('763', 'SAN LUIS DE CUBARRAL', '22'),
('764', 'SAN MARTÍN', '22'),
('765', 'URIBE', '22'),
('766', 'VILLAVICENCIO', '22'),
('767', 'VISTAHERMOSA', '22'),
('768', 'ALBÁN', '23'),
('769', 'ALDANA', '23'),
('77', 'LIBORINA', '2'),
('770', 'ANCUYÁ', '23'),
('771', 'ARBOLEDA', '23'),
('772', 'BARBACOAS', '23'),
('773', 'BELÉN', '23'),
('774', 'BUESACO', '23'),
('775', 'CHACHAGÜÍ', '23'),
('776', 'COLÓN', '23'),
('777', 'CONSACÁ', '23'),
('778', 'CONTADERO', '23'),
('779', 'CÓRDOBA', '23'),
('78', 'MACEO', '2'),
('780', 'CUASPÚD', '23'),
('781', 'CUMBAL', '23'),
('782', 'CUMBITARA', '23'),
('783', 'EL CHARCO', '23'),
('784', 'EL PEÑOL', '23'),
('785', 'EL ROSARIO', '23'),
('786', 'EL TABLÓN DE GÓMEZ', '23'),
('787', 'EL TAMBO', '23'),
('788', 'FRANCISCO PIZARRO', '23'),
('789', 'FUNES', '23'),
('79', 'MARINILLA', '2'),
('790', 'GUACHUCAL', '23'),
('791', 'GUAITARILLA', '23'),
('792', 'GUALMATÁN', '23'),
('793', 'ILES', '23'),
('794', 'IMUÉS', '23'),
('795', 'IPIALES', '23'),
('796', 'LA CRUZ', '23'),
('797', 'LA FLORIDA', '23'),
('798', 'LA LLANADA', '23'),
('799', 'LA TOLA', '23'),
('8', 'PUERTO ARICA', '1'),
('80', 'MEDELLÍN', '2'),
('800', 'LA UNIÓN', '23'),
('801', 'LEIVA', '23'),
('802', 'LINARES', '23'),
('803', 'LOS ANDES', '23'),
('804', 'MAGÜÍ', '23'),
('805', 'MALLAMA', '23'),
('806', 'MOSQUERA', '23'),
('807', 'NARIÑO', '23'),
('808', 'OLAYA HERRERA', '23'),
('809', 'OSPINA', '23'),
('81', 'MONTEBELLO', '2'),
('810', 'PASTO', '23'),
('811', 'POLICARPA', '23'),
('812', 'POTOSÍ', '23'),
('813', 'PROVIDENCIA', '23'),
('814', 'PUERRES', '23'),
('815', 'PUPIALES', '23'),
('816', 'RICAURTE', '23'),
('817', 'ROBERTO PAYÁN', '23'),
('818', 'SAMANIEGO', '23'),
('819', 'SAN ANDRÉS DE TUMACO', '23'),
('82', 'MURINDÓ', '2'),
('820', 'SAN BERNARDO', '23'),
('821', 'SAN LORENZO', '23'),
('822', 'SAN PABLO', '23'),
('823', 'SAN PEDRO DE CARTAGO', '23'),
('824', 'SANDONÁ', '23'),
('825', 'SANTA BÁRBARA', '23'),
('826', 'SANTACRUZ', '23'),
('827', 'SAPUYES', '23'),
('828', 'TAMINANGO', '23'),
('829', 'TANGUA', '23'),
('83', 'MUTATÁ', '2'),
('830', 'TÚQUERRES', '23'),
('831', 'YACUANQUER', '23'),
('832', 'ÁBREGO', '24'),
('833', 'ARBOLEDAS', '24'),
('834', 'BOCHALEMA', '24'),
('835', 'BUCARASICA', '24'),
('836', 'CÁCHIRA', '24'),
('837', 'CÁCOTA', '24'),
('838', 'CHINÁCOTA', '24'),
('839', 'CHITAGÁ', '24'),
('84', 'NARIÑO', '2'),
('840', 'CONVENCIÓN', '24'),
('841', 'CÚCUTA', '24'),
('842', 'CUCUTILLA', '24'),
('843', 'DURANIA', '24'),
('844', 'EL CARMEN', '24'),
('845', 'EL TARRA', '24'),
('846', 'EL ZULIA', '24'),
('847', 'GRAMALOTE', '24'),
('848', 'HACARÍ', '24'),
('849', 'HERRÁN', '24'),
('85', 'NECHÍ', '2'),
('850', 'LA ESPERANZA', '24'),
('851', 'LA PLAYA', '24'),
('852', 'LABATECA', '24'),
('853', 'LOS PATIOS', '24'),
('854', 'LOURDES', '24'),
('855', 'MUTISCUA', '24'),
('856', 'OCAÑA', '24'),
('857', 'PAMPLONA', '24'),
('858', 'PAMPLONITA', '24'),
('859', 'PUERTO SANTANDER', '24'),
('86', 'NECOCLÍ', '2'),
('860', 'RAGONVALIA', '24'),
('861', 'SALAZAR', '24'),
('862', 'SAN CALIXTO', '24'),
('863', 'SAN CAYETANO', '24'),
('864', 'SANTIAGO', '24'),
('865', 'SARDINATA', '24'),
('866', 'SILOS', '24'),
('867', 'TEORAMA', '24'),
('868', 'TIBÚ', '24'),
('869', 'TOLEDO', '24'),
('87', 'OLAYA', '2'),
('870', 'VILLA CARO', '24'),
('871', 'VILLA DEL ROSARIO', '24'),
('872', 'COLÓN', '25'),
('873', 'MOCOA', '25'),
('874', 'ORITO', '25'),
('875', 'PUERTO ASÍS', '25'),
('876', 'PUERTO CAICEDO', '25'),
('877', 'PUERTO GUZMÁN', '25'),
('878', 'PUERTO LEGUÍZAMO', '25'),
('879', 'SAN FRANCISCO', '25'),
('88', 'PEÑOL', '2'),
('880', 'SAN MIGUEL', '25'),
('881', 'SANTIAGO', '25'),
('882', 'SIBUNDOY', '25'),
('883', 'VALLE DEL GUAMUEZ', '25'),
('884', 'VILLAGARZÓN', '25'),
('885', 'ARMENIA', '26'),
('886', 'BUENAVISTA', '26'),
('887', 'CALARCÁ', '26'),
('888', 'CIRCASIA', '26'),
('889', 'CÓRDOBA', '26'),
('89', 'PEQUE', '2'),
('890', 'FILANDIA', '26'),
('891', 'GÉNOVA', '26'),
('892', 'LA TEBAIDA', '26'),
('893', 'MONTENEGRO', '26'),
('894', 'PIJAO', '26'),
('895', 'QUIMBAYA', '26'),
('896', 'SALENTO', '26'),
('897', 'APÍA', '27'),
('898', 'BALBOA', '27'),
('899', 'BELÉN DE UMBRÍA', '27'),
('9', 'PUERTO NARIÑO', '1'),
('90', 'PUEBLORRICO', '2'),
('900', 'DOSQUEBRADAS', '27'),
('901', 'GUÁTICA', '27'),
('902', 'LA CELIA', '27'),
('903', 'LA VIRGINIA', '27'),
('904', 'MARSELLA', '27'),
('905', 'MISTRATÓ', '27'),
('906', 'PEREIRA', '27'),
('907', 'PUEBLO RICO', '27'),
('908', 'QUINCHÍA', '27'),
('909', 'SANTA ROSA DE CABAL', '27'),
('91', 'PUERTO BERRÍO', '2'),
('910', 'SANTUARIO', '27'),
('911', 'AGUADA', '28'),
('912', 'ALBANIA', '28'),
('913', 'ARATOCA', '28'),
('914', 'BARBOSA', '28'),
('915', 'BARICHARA', '28'),
('916', 'BARRANCABERMEJA', '28'),
('917', 'BETULIA', '28'),
('918', 'BOLÍVAR', '28'),
('919', 'BUCARAMANGA', '28'),
('92', 'PUERTO NARE', '2'),
('920', 'CABRERA', '28'),
('921', 'CALIFORNIA', '28'),
('922', 'CAPITANEJO', '28'),
('923', 'CARCASÍ', '28'),
('924', 'CEPITÁ', '28'),
('925', 'CERRITO', '28'),
('926', 'CHARALÁ', '28'),
('927', 'CHARTA', '28'),
('928', 'CHIMA', '28'),
('929', 'CHIPATÁ', '28'),
('93', 'PUERTO TRIUNFO', '2'),
('930', 'CIMITARRA', '28'),
('931', 'CONCEPCIÓN', '28'),
('932', 'CONFINES', '28'),
('933', 'CONTRATACIÓN', '28'),
('934', 'COROMORO', '28'),
('935', 'CURITÍ', '28'),
('936', 'EL CARMEN DE CHUCURÍ', '28'),
('937', 'EL GUACAMAYO', '28'),
('938', 'EL PEÑÓN', '28'),
('939', 'EL PLAYÓN', '28'),
('94', 'REMEDIOS', '2'),
('940', 'ENCINO', '28'),
('941', 'ENCISO', '28'),
('942', 'FLORIÁN', '28'),
('943', 'FLORIDABLANCA', '28'),
('944', 'GALÁN', '28'),
('945', 'GÁMBITA', '28'),
('946', 'GIRÓN', '28'),
('947', 'GUACA', '28'),
('948', 'GUADALUPE', '28'),
('949', 'GUAPOTÁ', '28'),
('95', 'RETIRO', '2'),
('950', 'GUAVATÁ', '28'),
('951', 'GÜEPSA', '28'),
('952', 'HATO', '28'),
('953', 'JESÚS MARÍA', '28'),
('954', 'JORDÁN', '28'),
('955', 'LA BELLEZA', '28'),
('956', 'LA PAZ', '28'),
('957', 'LANDÁZURI', '28'),
('958', 'LEBRIJA', '28'),
('959', 'LOS SANTOS', '28'),
('96', 'RIONEGRO', '2'),
('960', 'MACARAVITA', '28'),
('961', 'MÁLAGA', '28'),
('962', 'MATANZA', '28'),
('963', 'MOGOTES', '28'),
('964', 'MOLAGAVITA', '28'),
('965', 'OCAMONTE', '28'),
('966', 'OIBA', '28'),
('967', 'ONZAGA', '28'),
('968', 'PALMAR', '28'),
('969', 'PALMAS DEL SOCORRO', '28'),
('97', 'SABANALARGA', '2'),
('970', 'PÁRAMO', '28'),
('971', 'PIEDECUESTA', '28'),
('972', 'PINCHOTE', '28'),
('973', 'PUENTE NACIONAL', '28'),
('974', 'PUERTO PARRA', '28'),
('975', 'PUERTO WILCHES', '28'),
('976', 'RIONEGRO', '28'),
('977', 'SABANA DE TORRES', '28'),
('978', 'SAN ANDRÉS', '28'),
('979', 'SAN BENITO', '28'),
('98', 'SABANETA', '2'),
('980', 'SAN GIL', '28'),
('981', 'SAN JOAQUÍN', '28'),
('982', 'SAN JOSÉ DE MIRANDA', '28'),
('983', 'SAN MIGUEL', '28'),
('984', 'SAN VICENTE DE CHUCURÍ', '28'),
('985', 'SANTA BÁRBARA', '28'),
('986', 'SANTA HELENA DEL OPÓN', '28'),
('987', 'SIMACOTA', '28'),
('988', 'SOCORRO', '28'),
('989', 'SUAITA', '28'),
('99', 'SALGAR', '2'),
('990', 'SUCRE', '28'),
('991', 'SURATÁ', '28'),
('992', 'TONA', '28'),
('993', 'VALLE DE SAN JOSÉ', '28'),
('994', 'VÉLEZ', '28'),
('995', 'VETAS', '28'),
('996', 'VILLANUEVA', '28'),
('997', 'ZAPATOCA', '28'),
('998', 'BUENAVISTA', '29'),
('999', 'CAIMITO', '29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproduccion`
--

CREATE TABLE `tblproduccion` (
  `codigo` int(3) NOT NULL,
  `fecha` date NOT NULL,
  `usuario` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblproduccion`
--

INSERT INTO `tblproduccion` (`codigo`, `fecha`, `usuario`) VALUES
(15, '2020-10-02', '1001651969'),
(17, '2020-10-10', '1001651969'),
(19, '2020-10-09', '1001651968'),
(23, '2020-10-25', '123456'),
(25, '2020-10-11', '123456'),
(27, '2020-10-11', '1001651968'),
(29, '2020-10-11', '123456'),
(39, '2020-10-16', '1001651969'),
(40, '2020-10-16', '1001651969'),
(41, '2020-10-03', '1001651969'),
(42, '2020-10-03', '1001651969'),
(43, '2020-10-18', '123456'),
(44, '2020-10-18', '123456'),
(45, '2020-10-01', '1001651968'),
(46, '2020-10-01', '1001651968'),
(47, '2020-10-11', '1001651968'),
(48, '2020-10-11', '1001651968'),
(49, '2020-11-25', '1001651968'),
(50, '2020-11-25', '1001651968'),
(51, '2020-11-08', '123456'),
(52, '2020-11-08', '123456'),
(53, '0000-00-00', '- Seleccione'),
(54, '0000-00-00', '- Seleccione'),
(55, '0000-00-00', '- Seleccione'),
(56, '0000-00-00', '- Seleccione'),
(57, '0000-00-00', '- Seleccione'),
(58, '0000-00-00', '- Seleccione'),
(59, '0000-00-00', '- Seleccione'),
(60, '0000-00-00', '- Seleccione'),
(61, '0000-00-00', '- Seleccione'),
(62, '0000-00-00', '- Seleccione'),
(63, '0000-00-00', '- Seleccione'),
(64, '0000-00-00', '- Seleccione'),
(65, '0000-00-00', '- Seleccione'),
(66, '0000-00-00', '- Seleccione'),
(67, '0000-00-00', '- Seleccione'),
(68, '0000-00-00', '- Seleccione'),
(69, '0000-00-00', '- Seleccione'),
(70, '0000-00-00', '- Seleccione'),
(71, '0000-00-00', '- Seleccione'),
(72, '0000-00-00', '- Seleccione'),
(73, '0000-00-00', '- Seleccione'),
(74, '0000-00-00', '- Seleccione'),
(75, '0000-00-00', '- Seleccione'),
(76, '0000-00-00', '- Seleccione'),
(77, '0000-00-00', '- Seleccione'),
(78, '0000-00-00', '- Seleccione'),
(79, '2020-10-06', '- Seleccione'),
(80, '2020-10-20', '- Seleccione'),
(81, '0000-00-00', '- Seleccione'),
(82, '0000-00-00', '- Seleccione'),
(83, '0000-00-00', '- Seleccione'),
(84, '0000-00-00', '- Seleccione'),
(85, '0000-00-00', '- Seleccione'),
(86, '0000-00-00', '- Seleccione'),
(87, '0000-00-00', '- Seleccione'),
(88, '0000-00-00', '- Seleccione'),
(89, '0000-00-00', '- Seleccione'),
(90, '0000-00-00', '- Seleccione'),
(91, '0000-00-00', '- Seleccione'),
(92, '0000-00-00', '- Seleccione'),
(93, '0000-00-00', '- Seleccione'),
(94, '0000-00-00', '- Seleccione'),
(95, '0000-00-00', '- Seleccione'),
(96, '0000-00-00', '- Seleccione'),
(97, '2020-11-02', '- Seleccione'),
(98, '0000-00-00', '- Seleccione'),
(99, '0000-00-00', ''),
(100, '0000-00-00', ''),
(101, '0000-00-00', ''),
(102, '0000-00-00', ''),
(103, '0000-00-00', ''),
(104, '0000-00-00', ''),
(105, '0000-00-00', ''),
(106, '0000-00-00', ''),
(107, '2020-11-17', '1001651968'),
(108, '2020-11-26', '1001651969');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproduccionreceta`
--

CREATE TABLE `tblproduccionreceta` (
  `cod_produccion` int(3) NOT NULL,
  `cod_receta` int(3) NOT NULL,
  `cantidad` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblproduccionreceta`
--

INSERT INTO `tblproduccionreceta` (`cod_produccion`, `cod_receta`, `cantidad`) VALUES
(15, 3, 33),
(17, 25, 43252345),
(19, 22, 22),
(23, 3, 12),
(25, 19, 10),
(27, 20, 33),
(29, 21, 10),
(46, 3, 44),
(48, 18, 23),
(48, 19, 23),
(50, 6, 1),
(50, 18, 2),
(50, 22, 3),
(50, 25, 4),
(52, 8, 35),
(52, 19, 36),
(52, 20, 34),
(107, 17, 8),
(107, 28, 8),
(108, 28, 8),
(108, 31, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproductoterminado`
--

CREATE TABLE `tblproductoterminado` (
  `codigo` varchar(15) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `categoria` int(3) NOT NULL,
  `unidades_disponibles` int(5) NOT NULL,
  `unidad_medida` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblproductoterminado`
--

INSERT INTO `tblproductoterminado` (`codigo`, `nombre`, `fecha_creacion`, `fecha_vencimiento`, `categoria`, `unidades_disponibles`, `unidad_medida`) VALUES
('04986056', 'Pollo a la naranja', '2020-10-06', '2020-10-08', 3, 9, 3),
('1', 'Arroz Chinooos', '2020-08-20', '2020-09-03', 1, 99, 2),
('2', 'Pulpo asado', '2020-09-01', '2020-09-30', 2, 67, 5),
('3', 'cacao', '2020-10-07', '2020-10-23', 3, 6, 3),
('4', 'banano con crema', '2020-10-23', '2020-10-22', 2, 6, 4),
('9058606', 'Patacones con guacamole', '2020-09-15', '2020-10-16', 2, 7, 4),
('996996', 'NEUVO PRODUCTO', '2020-12-01', '2020-11-29', 3, 89, 5),
('er9t8095865', 'Pasta', '2020-09-24', '2020-10-16', 3, 7, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproveedor`
--

CREATE TABLE `tblproveedor` (
  `nit` varchar(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(60) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `municipio` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblproveedor`
--

INSERT INTO `tblproveedor` (`nit`, `nombre`, `apellido`, `direccion`, `telefono`, `correo`, `municipio`) VALUES
('09586', 'odpjf', 'dkñfj', 'gorgolesia calle#b', '035405965906', 'karol@hotmial.com', '448'),
('480856069', 'ACTUAL', 'PRv', 'Cale f', '904805', 'correo@.com', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblreceta`
--

CREATE TABLE `tblreceta` (
  `codigo` int(3) NOT NULL,
  `fecha` date NOT NULL,
  `producto` varchar(15) NOT NULL,
  `usuario` varchar(12) NOT NULL,
  `descripcion` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblreceta`
--

INSERT INTO `tblreceta` (`codigo`, `fecha`, `producto`, `usuario`, `descripcion`) VALUES
(3, '2020-08-31', '1', '123456', 'adfdfasfsf'),
(4, '2020-09-19', '2', '1001651969', ''),
(6, '2020-10-02', '1', '1001651968', 'qwer'),
(7, '2020-10-02', '1', '1001651968', 'qwer'),
(8, '2020-10-15', '3', '1001651968', 'a'),
(9, '2020-10-15', '3', '1001651968', 'a'),
(11, '2020-10-15', '3', '1001651968', 'a'),
(14, '2020-11-08', '1', '1001651968', 'wqe'),
(15, '2020-11-08', '1', '1001651968', 'wqe'),
(16, '2020-10-04', '1', '1001651969', 'qwer'),
(17, '2020-10-04', '1', '1001651969', 'qwer'),
(18, '2020-10-02', '2', '1001651968', 'qwer'),
(19, '2020-10-02', '2', '1001651968', 'qwer'),
(20, '2020-10-02', '3', '123456', 'Este es'),
(21, '2020-10-02', '3', '123456', 'Este es'),
(22, '2020-10-04', '2', '1001651968', 'ahh'),
(23, '2020-10-04', '2', '1001651968', 'ahh'),
(24, '2020-10-10', '2', '1001651968', '123'),
(25, '2020-10-10', '2', '1001651968', '123'),
(27, '2020-10-10', '2', '1001651968', '123'),
(28, '2020-10-09', '1', '1001651969', 'ws'),
(29, '2020-10-09', '1', '1001651969', 'ws'),
(30, '2020-10-09', '1', '1001651969', 'ws'),
(31, '2020-10-10', '1', '1001651968', 'asdd'),
(32, '2020-10-10', '1', '1001651968', 'asdd'),
(33, '2020-10-10', '3', '1001651969', 'error1'),
(36, '2020-10-09', '1', '093840945', 'NUEVODESCIPCION'),
(37, '2020-10-29', '4', '1005091870', 'NUEVODESCIPCION'),
(38, '0000-00-00', '3', '1005091870', 'descripcionACTUALIZADA'),
(7882, '2020-11-13', '9058606', '1005091870', 'NUEVA RECETA'),
(7883, '2020-11-10', '2', '1001651968', 'OPSDJUPFODG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltipousuario`
--

CREATE TABLE `tbltipousuario` (
  `id` int(2) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbltipousuario`
--

INSERT INTO `tbltipousuario` (`id`, `nombre`) VALUES
(1, 'SuperAdministrador'),
(2, 'Administrador'),
(3, 'Operario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblunidadmedida`
--

CREATE TABLE `tblunidadmedida` (
  `codigo` int(2) NOT NULL,
  `nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblunidadmedida`
--

INSERT INTO `tblunidadmedida` (`codigo`, `nombre`) VALUES
(1, 'Medio Litro'),
(2, 'Litro'),
(3, 'Galón'),
(4, 'Libra'),
(5, 'Kilogramo'),
(6, 'Paca');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblusuario`
--

CREATE TABLE `tblusuario` (
  `documento` varchar(12) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(60) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `clave` varchar(10) NOT NULL,
  `tipo_usuario` int(2) DEFAULT NULL,
  `municipio` varchar(6) NOT NULL,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblusuario`
--

INSERT INTO `tblusuario` (`documento`, `nombres`, `apellidos`, `correo`, `telefono`, `direccion`, `clave`, `tipo_usuario`, `municipio`, `estado`) VALUES
('093840945', 'JOSE ', 'PEREZ', 'correpepito@mgia.com', '039805', 'calle c', 'claveNUEVA', 2, '100', 0),
('1001651968', 'Cristian Dario', 'Castro Cardona', 'Castrocardonacristian@gmail.com', '3196200585', 'calle 35 # 29-40', '111', 3, '649', 0),
('1001651969', 'Camila', 'Beltrán', 'Camila@gmail.com', '3137155567', 'Calle 85 # 49-70', '111', 2, '538', 1),
('1005091870', 'Karol', 'Yulieth', 'akhfaf@hotmail.com', '3924849549', '11', 'PASS', 3, '668', 0),
('123456', 'Melany', 'Perez', 'melany@hotmail.com', '3924849549', 'calle1barriaSamanta#45-67', '111', 1, '668', 0),
('34905805', 'eimy', 'montoya', 'lkdfkld@mgai.com', '3924849549', 'calle c', '576', NULL, '1000', 1),
('48509586', 'Usuario', 'Procedimiento', 'karol@hotmial.com', '9994', 'gorgolesia calle#b', '0495860968', NULL, '650', 0),
('9048545', 'SOFIA', 'VERGARA', 'CORREODESOFIA@HOTMIAL.CO', '035405965906', 'CALLE Z', 'SOFIACLAVE', NULL, '505', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cliente`
--

CREATE TABLE `tbl_cliente` (
  `documento` varchar(12) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `municipio` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_cliente`
--

INSERT INTO `tbl_cliente` (`documento`, `nombres`, `apellidos`, `telefono`, `correo`, `direccion`, `municipio`) VALUES
('099586069', 'pdo', 'pacheco', '33333', 'samanta@hotmail.com', 'akkwhfñ#.ahfavendia', '538'),
('903489058', 'karol', 'ccbv', 'w9003', 'tatian@hto.cii', 'Calle 2', '535');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tblcategoria`
--
ALTER TABLE `tblcategoria`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tbldepartamento`
--
ALTER TABLE `tbldepartamento`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tblestado`
--
ALTER TABLE `tblestado`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tblfacturacompra`
--
ALTER TABLE `tblfacturacompra`
  ADD PRIMARY KEY (`numero`),
  ADD KEY `fk_tbl_facturacompra_tbl_formapago1_idx` (`forma_pago`),
  ADD KEY `fk_tbl_facturacompra_tbl_proveedor1_idx` (`proveedor`);

--
-- Indices de la tabla `tblfacturacompramateriaprima`
--
ALTER TABLE `tblfacturacompramateriaprima`
  ADD PRIMARY KEY (`materia_prima`,`factura_compra`),
  ADD KEY `fk_compra` (`factura_compra`);

--
-- Indices de la tabla `tblfacturaventa`
--
ALTER TABLE `tblfacturaventa`
  ADD PRIMARY KEY (`numero`),
  ADD KEY `fk_tblfacturaventa_tbl_formapago1_idx` (`forma_pago`),
  ADD KEY `fk_tblfacturaventa_tbl_clientes1_idx` (`cliente`);

--
-- Indices de la tabla `tblfacturventaproducto`
--
ALTER TABLE `tblfacturventaproducto`
  ADD PRIMARY KEY (`factura_venta`,`producto`),
  ADD KEY `fk_tblfacturaventa_producto_tblproducto1_idx` (`producto`);

--
-- Indices de la tabla `tblformapago`
--
ALTER TABLE `tblformapago`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tblmateriaprima`
--
ALTER TABLE `tblmateriaprima`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_tbl_materiaprima_tblunidadmedida1_idx` (`unidad_medida`);

--
-- Indices de la tabla `tblmateriaprimareceta`
--
ALTER TABLE `tblmateriaprimareceta`
  ADD PRIMARY KEY (`materia_prima`,`receta`),
  ADD KEY `fk_tbl_materiaprima_receta_tbl_receta1_idx` (`receta`);

--
-- Indices de la tabla `tblmunicipio`
--
ALTER TABLE `tblmunicipio`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_tbl_municipio_tbl_departamentos1_idx` (`tbl_departamentos_codigo`);

--
-- Indices de la tabla `tblproduccion`
--
ALTER TABLE `tblproduccion`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tblproduccionreceta`
--
ALTER TABLE `tblproduccionreceta`
  ADD PRIMARY KEY (`cod_produccion`,`cod_receta`),
  ADD KEY `fk_tblproduccionreceta_tblreceta1_idx` (`cod_receta`);

--
-- Indices de la tabla `tblproductoterminado`
--
ALTER TABLE `tblproductoterminado`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_tblproducto_tblcategoria1_idx` (`categoria`),
  ADD KEY `fk_tblproducto_tblunidadmedida1_idx` (`unidad_medida`);

--
-- Indices de la tabla `tblproveedor`
--
ALTER TABLE `tblproveedor`
  ADD PRIMARY KEY (`nit`),
  ADD KEY `fk_tbl_proveedor_tbl_municipio1_idx` (`municipio`);

--
-- Indices de la tabla `tblreceta`
--
ALTER TABLE `tblreceta`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_tbl_ajusteinventario_tbl_usuarios1_idx` (`usuario`),
  ADD KEY `fk_tbl_receta_tbl_productoterminado1_idx` (`producto`);

--
-- Indices de la tabla `tbltipousuario`
--
ALTER TABLE `tbltipousuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblunidadmedida`
--
ALTER TABLE `tblunidadmedida`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tblusuario`
--
ALTER TABLE `tblusuario`
  ADD PRIMARY KEY (`documento`),
  ADD KEY `fk_tbl_usuarios_tbl_municipio1_idx` (`municipio`),
  ADD KEY `fk_tbl_usuarios_tbl_tipo_usuario1_idx` (`tipo_usuario`),
  ADD KEY `estado_usuario` (`estado`);

--
-- Indices de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  ADD PRIMARY KEY (`documento`),
  ADD KEY `municipio_cliente` (`municipio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tblfacturacompra`
--
ALTER TABLE `tblfacturacompra`
  MODIFY `numero` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12341252;

--
-- AUTO_INCREMENT de la tabla `tblformapago`
--
ALTER TABLE `tblformapago`
  MODIFY `codigo` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tblproduccion`
--
ALTER TABLE `tblproduccion`
  MODIFY `codigo` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `tblreceta`
--
ALTER TABLE `tblreceta`
  MODIFY `codigo` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7884;

--
-- AUTO_INCREMENT de la tabla `tblunidadmedida`
--
ALTER TABLE `tblunidadmedida`
  MODIFY `codigo` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tblfacturaventa`
--
ALTER TABLE `tblfacturaventa`
  ADD CONSTRAINT `fk_tblfacturaventa_tbl_clientes1` FOREIGN KEY (`cliente`) REFERENCES `tbl_cliente` (`documento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblfacturaventa_tbl_formapago1` FOREIGN KEY (`forma_pago`) REFERENCES `tblformapago` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tblfacturventaproducto`
--
ALTER TABLE `tblfacturventaproducto`
  ADD CONSTRAINT `fk_tblfacturaventa_producto_tblfacturaventa1` FOREIGN KEY (`factura_venta`) REFERENCES `tblfacturaventa` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblfacturaventa_producto_tblproducto1` FOREIGN KEY (`producto`) REFERENCES `tblproductoterminado` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_producto` FOREIGN KEY (`factura_venta`) REFERENCES `tblfacturaventa` (`numero`);

--
-- Filtros para la tabla `tblmunicipio`
--
ALTER TABLE `tblmunicipio`
  ADD CONSTRAINT `fk_tbl_municipio_tbl_departamentos1` FOREIGN KEY (`tbl_departamentos_codigo`) REFERENCES `tbldepartamento` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tblproduccionreceta`
--
ALTER TABLE `tblproduccionreceta`
  ADD CONSTRAINT `fk_tblproduccionreceta_tblproduccion1` FOREIGN KEY (`cod_produccion`) REFERENCES `tblproduccion` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblproduccionreceta_tblreceta1` FOREIGN KEY (`cod_receta`) REFERENCES `tblreceta` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `produccionfk` FOREIGN KEY (`cod_produccion`) REFERENCES `tblproduccion` (`codigo`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tblproductoterminado`
--
ALTER TABLE `tblproductoterminado`
  ADD CONSTRAINT `fk_tblproducto_tblcategoria1` FOREIGN KEY (`categoria`) REFERENCES `tblcategoria` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblproducto_tblunidadmedida1` FOREIGN KEY (`unidad_medida`) REFERENCES `tblunidadmedida` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tblproveedor`
--
ALTER TABLE `tblproveedor`
  ADD CONSTRAINT `fk_tbl_proveedor_tbl_municipio1` FOREIGN KEY (`municipio`) REFERENCES `tblmunicipio` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tblreceta`
--
ALTER TABLE `tblreceta`
  ADD CONSTRAINT `fk_tbl_ajusteinventario_tbl_usuarios10` FOREIGN KEY (`usuario`) REFERENCES `tblusuario` (`documento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_receta_tbl_productoterminado1` FOREIGN KEY (`producto`) REFERENCES `tblproductoterminado` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tblusuario`
--
ALTER TABLE `tblusuario`
  ADD CONSTRAINT `estado_usuario` FOREIGN KEY (`estado`) REFERENCES `tblestado` (`codigo`),
  ADD CONSTRAINT `fk_tbl_usuarios_tbl_municipio1` FOREIGN KEY (`municipio`) REFERENCES `tblmunicipio` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_usuarios_tbl_tipo_usuario1` FOREIGN KEY (`tipo_usuario`) REFERENCES `tbltipousuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  ADD CONSTRAINT `fk_tbl_clientes_tbl_municipio1` FOREIGN KEY (`municipio`) REFERENCES `tblmunicipio` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `municipio_cliente` FOREIGN KEY (`municipio`) REFERENCES `tblmunicipio` (`codigo`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
