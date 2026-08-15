-- ═══════════════════════════════════════════════
-- RetailPro
-- Módulo 5 - Consultas con JOINs y UNION ALL
-- Título: Cruzando tablas para enriquecer el análisis
-- Alumna: Florencia López
-- Fecha de entrega: 15/08/2026
-- ═══════════════════════════════════════════════


-- ==========================================
-- CONSULTA 1 - VISTA BASE DEL PROYECTO
-- INNER JOIN
-- ==========================================

-- Pregunta de negocio:
-- ¿Cómo obtener en una sola vista la información completa
-- de cada venta, incluyendo cliente, segmento, región,
-- producto, categoría, cantidad, precio, total y canal?

SELECT
    v.fecha_venta AS fecha,
    c.nombre AS cliente,
    c.segmento,
    t.region,
    p.nombre_producto,
    ca.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias ca
    ON p.id_categoria = ca.id_categoria
INNER JOIN territorios t
    ON v.id_territorio = t.id_territorio;



-- ==========================================
-- CONSULTA 2 - CLIENTES SIN VENTAS
-- LEFT JOIN + IS NULL
-- ==========================================

-- Pregunta de negocio:
-- ¿Qué clientes están registrados pero todavía
-- no realizaron ninguna compra?

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ==========================================
-- CONSULTA 3 - PRODUCTOS SIN VENTAS
-- LEFT JOIN + IS NULL
-- ==========================================

-- Pregunta de negocio:
-- ¿Qué productos existen en el catálogo pero
-- todavía no registraron ninguna venta?

SELECT
    p.nombre_producto,
    ca.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias ca
    ON p.id_categoria = ca.id_categoria
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;



-- ==========================================
-- CONSULTA 4 - CONSOLIDADO POR CANAL
-- UNION ALL + GROUP BY
-- ==========================================

-- Pregunta de negocio:
-- ¿Cuál es el total vendido por canal,
-- diferenciando ventas Online y Presencial?

SELECT
    v.id_venta,
    v.cantidad * v.precio_unitario AS total_venta,
    'Online' AS canal
FROM ventas v
WHERE v.canal = 'Online'

SELECT
    v.id_venta,
    v.cantidad * v.precio_unitario AS total_venta,
    'Presencial' AS canal
FROM ventas v
WHERE v.canal = 'Presencial'

SELECT
    canal,
    SUM(total_venta) AS total_por_canal
FROM (
    SELECT
        v.id_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Online' AS canal
    FROM ventas v
    WHERE v.canal = 'Online'

    UNION ALL

    SELECT
        v.id_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Presencial' AS canal
    FROM ventas v
    WHERE v.canal = 'Presencial'
) AS ventas_por_canal
GROUP BY canal;