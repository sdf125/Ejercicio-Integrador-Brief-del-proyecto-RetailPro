-- ═══════════════════════════════════════════════
-- Ventas_Tech_DB
-- Alumna: Florencia López
-- Checkpoint M3 - Script SQL de Ingeniería de Datos
-- ═══════════════════════════════════════════════

CREATE DATABASE Ventas_Tech_DB;
USE Ventas_Tech_DB;

-- ==========================================
-- DROP TABLES
-- ==========================================

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS territorios;
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
    segmento VARCHAR(50),
    fecha_registro DATE NOT NULL
);

-- ==========================================
-- CREATE TABLE territorios
-- ==========================================

CREATE TABLE territorios(
    id_territorio INT NOT NULL PRIMARY KEY,
    region VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    zona VARCHAR(50)
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

    FOREIGN KEY (id_categoria)
    REFERENCES categorias(id_categoria)
);

-- ==========================================
-- CREATE TABLE ventas
-- ==========================================

CREATE TABLE ventas(
    id_venta INT NOT NULL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    id_territorio INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL,
    canal VARCHAR(20) NOT NULL,

    FOREIGN KEY (id_cliente)
    REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_producto)
    REFERENCES productos(id_producto),

    FOREIGN KEY (id_territorio)
    REFERENCES territorios(id_territorio)
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
(1,'María López','maria@mail.com','Buenos Aires','Premium','2024-01-05');

INSERT INTO clientes VALUES
(2,'Carlos Ruiz','carlos@mail.com','Córdoba','Regular','2024-01-10');

INSERT INTO clientes VALUES
(3,'Ana Gómez','ana@mail.com','Rosario','Premium','2024-02-01');

INSERT INTO clientes VALUES
(4,'Pedro Sanz','pedro@mail.com','Mendoza','Regular','2024-02-15');

INSERT INTO clientes VALUES
(5,'Laura Torres','laura@mail.com','Tucumán','Premium','2024-03-01');

-- Cliente sin ventas
INSERT INTO clientes VALUES
(6,'Sofía Martínez','sofia@mail.com','Salta','Nuevo','2024-03-20');

-- ==========================================
-- INSERT TERRITORIOS
-- ==========================================

INSERT INTO territorios VALUES
(1,'Centro','Argentina','Buenos Aires');

INSERT INTO territorios VALUES
(2,'Centro','Argentina','Córdoba');

INSERT INTO territorios VALUES
(3,'Litoral','Argentina','Rosario');

INSERT INTO territorios VALUES
(4,'Cuyo','Argentina','Mendoza');

INSERT INTO territorios VALUES
(5,'Norte','Argentina','Tucumán');

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

-- Producto sin ventas
INSERT INTO productos VALUES
(7,'Webcam HD 1080p',2,75.00,20,1);

-- ==========================================
-- INSERT VENTAS
-- ==========================================

INSERT INTO ventas VALUES
(1,1,1,1,2,1200.00,'2024-03-05','Online');

INSERT INTO ventas VALUES
(2,2,2,2,5,28.00,'2024-03-06','Presencial');

INSERT INTO ventas VALUES
(3,3,3,3,1,450.00,'2024-03-07','Online');

INSERT INTO ventas VALUES
(4,1,4,1,2,120.00,'2024-03-08','Presencial');

INSERT INTO ventas VALUES
(5,4,5,4,3,130.00,'2024-03-10','Online');

INSERT INTO ventas VALUES
(6,2,6,2,4,95.00,'2024-03-11','Presencial');

INSERT INTO ventas VALUES
(7,5,1,5,1,1200.00,'2024-03-12','Online');

INSERT INTO ventas VALUES
(8,3,2,3,8,28.00,'2024-03-13','Presencial');

INSERT INTO ventas VALUES
(9,4,4,4,1,120.00,'2024-03-14','Online');

INSERT INTO ventas VALUES
(10,5,3,5,2,450.00,'2024-03-15','Presencial');

-- ==========================================
-- VALIDACIONES
-- ==========================================

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM territorios;
SELECT * FROM productos;
SELECT * FROM ventas;