USE ventas;

-- 1. Obtener el total de pedidos realizados por un cliente

DELIMITER //
CREATE FUNCTION total_pedidos(id_cliente INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE total_pedido INT;
    
    SELECT SUM(total) INTO total_pedido FROM pedido WHERE id_cliente = id_cliente;
    RETURN total_pedido;
END //
DELIMITER ;
-- DROP FUNCTION total_pedidos;

SELECT total_pedidos(1) AS Total_pedidos;

-- 2. Calcular la comisión total ganada por un comercial

DELIMITER //
CREATE FUNCTION comision_total(id_comercial INT)
RETURNS DOUBLE DETERMINISTIC
BEGIN
	DECLARE comision DOUBLE;
    SELECT SUM(pedido.total * comercial.comision / 100) INTO comision FROM pedido
    JOIN comercial ON pedido.id_comercial = comercial.id
    WHERE pedido.id_comercial = id_comercial;
    RETURN comision;
END //
DELIMITER ;

SELECT comision_total(3);

 -- 3. Obtener el cliente con mayor total en pedidos
 
DELIMITER //
CREATE FUNCTION cliente_mayor_pedido()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cliente_id INT;
    DECLARE cliente_nombre VARCHAR(100);
    DECLARE cliente_apellido1 VARCHAR(100);
    DECLARE cliente_apellido2 VARCHAR(100);
    DECLARE cliente_ciudad VARCHAR(100);
    DECLARE total_pedidos DOUBLE;

    SELECT c.id, c.nombre, c.apellido1, c.apellido2, c.ciudad, SUM(p.total) AS total_pedidos
    INTO cliente_id, cliente_nombre, cliente_apellido1, cliente_apellido2, cliente_ciudad, total_pedidos FROM cliente c
    JOIN pedido p ON c.id = p.id_cliente
    GROUP BY c.id ORDER BY total_pedidos DESC LIMIT 1;
    RETURN cliente_id;
END //
DELIMITER ;

SELECT cliente_mayor_pedido();

-- 4. Contar la cantidad de pedidos realizados en un año específico

DELIMITER //
CREATE FUNCTION contar_pedidos(year1 INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad_pedidos INT;

    SELECT COUNT(*) INTO cantidad_pedidos FROM pedido WHERE YEAR(fecha) = year1;
    RETURN cantidad_pedidos;
END //
DELIMITER ;

SELECT contar_pedidos(2023) AS Pedidos_por_año;

-- 5. Obtener el promedio de total de pedidos por cliente

DELIMITER //
CREATE FUNCTION obtener_promedio()
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE promedio_pedidos DOUBLE;

    SELECT AVG(p.total) INTO promedio_pedidos FROM pedido p;
    RETURN promedio_pedidos;
END //
DELIMITER ;

SELECT obtener_promedio() AS Promedio_pedidos_por_cliente;

