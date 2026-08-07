-- ═══════════════════════════════════════════════
-- Ventas_Tech_DB
-- Alumna: Florencia López
-- Checkpoint M3 - Script SQL de Ingeniería de Datos
-- ═══════════════════════════════════════════════

-- ==========================================
-- CREAR BASE DE DATOS
-- ==========================================

CREATE DATABASE Ventas_Tech_DB;
USE Ventas_Tech_DB;

-- ==========================================
-- DROP TABLES
-- ==========================================

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- ==========================================
-- CREATE TABLE categorias
-- ==========================================

CREATE TABLE categorias(
    id_categoria INT NOT NULL PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200) 
);

-- ==========================================
-- CREATE TABLE clientes
-- ==========================================

CREATE TABLE clientes(
    id_cliente INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);

-- ==========================================
-- CREATE TABLE productos
-- ==========================================

CREATE TABLE productos(
    id_producto INT NOT NULL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo TINYINT DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- ==========================================
-- CREATE TABLE ventas
-- ==========================================

CREATE TABLE ventas(
    id_venta INT NOT NULL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ==========================================
-- INSERT CATEGORIAS
-- ==========================================

INSERT INTO categorias VALUES
(1,'Computación','Laptops, PCs y monitores');
INSERT INTO categorias VALUES
(2,'Accesorios','Periféricos y complementos');
INSERT INTO categorias VALUES
(3,'Audio','Auriculares y parlantes');
INSERT INTO categorias VALUES
(4,'Almacenamiento','Discos y memorias');

-- ==========================================
-- INSERT CLIENTES
-- ==========================================

INSERT INTO clientes VALUES
(1,'María López','maria@mail.com','Buenos Aires','2024-01-05');
INSERT INTO clientes VALUES
(2,'Carlos Ruiz','carlos@mail.com','Córdoba','2024-01-10');
INSERT INTO clientes VALUES
(3,'Ana Gómez','ana@mail.com','Rosario','2024-02-01');
INSERT INTO clientes VALUES
(4,'Pedro Sanz','pedro@mail.com','Mendoza','2024-02-15');
INSERT INTO clientes VALUES
(5,'Laura Torres','laura@mail.com','Tucumán','2024-03-01');

-- ==========================================
-- INSERT PRODUCTOS
-- ==========================================

INSERT INTO productos VALUES
(1,'Laptop Pro 15',1,1200.00,15,1);
INSERT INTO productos VALUES
(2,'Mouse Inalámbrico',2,28.00,80,1);
INSERT INTO productos VALUES
(3,'Monitor 4K 27"',1,450.00,12,1);
INSERT INTO productos VALUES
(4,'Auriculares BT Pro',3,120.00,35,1);
INSERT INTO productos VALUES
(5,'SSD Externo 1TB',4,130.00,18,1);
INSERT INTO productos VALUES
(6,'Teclado Mecánico',2,95.00,40,1);

-- ==========================================
-- INSERT VENTAS
-- ==========================================

INSERT INTO ventas VALUES
(1,1,1,2,1200.00,'2024-03-05');
INSERT INTO ventas VALUES
(2,2,2,5,28.00,'2024-03-06');
INSERT INTO ventas VALUES
(3,3,3,1,450.00,'2024-03-07');
INSERT INTO ventas VALUES
(4,1,4,2,120.00,'2024-03-08');
INSERT INTO ventas VALUES
(5,4,5,3,130.00,'2024-03-10');
INSERT INTO ventas VALUES
(6,2,6,4,95.00,'2024-03-11');
INSERT INTO ventas VALUES
(7,5,1,1,1200.00,'2024-03-12');
INSERT INTO ventas VALUES
(8,3,2,8,28.00,'2024-03-13');
INSERT INTO ventas VALUES
(9,4,4,1,120.00,'2024-03-14');
INSERT INTO ventas VALUES
(10,5,3,2,450.00,'2024-03-15');

-- ==========================================
-- VALIDACIONES
-- ==========================================

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;



-- ═══════════════════════════════════════════════════
-- RetailPro — Consultas SQL de negocio
-- Título: Extrayendo métricas clave con SQL
-- Autora: Florencia López
-- Módulo 4
-- ═══════════════════════════════════════════════════


-- ==================================================
-- CONSULTA 1: RESUMEN EJECUTIVO MENSUAL
-- Total facturado, cantidad de pedidos y ticket
-- promedio, agrupados por mes.
-- ==================================================

select MONTH(fecha_venta) as Mes, count(*) as Cantidad_pedidos, sum(precio_unitario * cantidad) as Total_facturado, avg(precio_unitario * cantidad) as Ticket_promedio
from ventas
GROUP BY MONTH(fecha_venta)
ORDER BY Mes;

-- ==================================================
-- CONSULTA 2: RANKING DE PRODUCTOS
-- Cinco productos con mayor facturación.
-- ==================================================

select TOP 5 id_producto, sum(cantidad) as Unidades_vendidas, sum(cantidad * precio_unitario) as Total_facturado
from ventas
GROUP BY (id_producto)
ORDER BY total_facturado DESC 


-- ==================================================
-- CONSULTA 3: CLIENTES RECURRENTES
-- Clientes que realizaron más de un pedido.
-- ==================================================

select id_cliente, count(*) as Cantidad_pedidos, sum(cantidad * precio_unitario) Total_gastado
from ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- ==================================================
-- CONSULTA 4: COMPARACIÓN CON EL PROMEDIO MENSUAL
-- Clasifica cada mes según su facturación respecto
-- del promedio mensual general.
-- ==================================================

select MONTH(fecha_venta) as Mes, sum(precio_unitario * cantidad) as Total_facturado
FROM ventas
GROUP BY MONTH(fecha_venta);

-- La base contiene ventas únicamente del mes de marzo,
-- por lo tanto no es posible realizar una comparación real
-- entre distintos meses.

-- ==================================================
-- HALLAZGOS DE NEGOCIO
-- ==================================================ç

-- 1. En marzo se registraron 10 pedidos, con una facturación
--    total de 6444.00 y un ticket promedio de 644.40.

-- 2. El producto con ID 1 lideró el ranking: vendió 3 unidades
--    y generó 3600.00, equivalente al 55.87% de la facturación total.

-- 3. Todos los clientes realizaron más de un pedido. El cliente
--    con ID 1 fue quien más gastó, con un total de 2640.00.

