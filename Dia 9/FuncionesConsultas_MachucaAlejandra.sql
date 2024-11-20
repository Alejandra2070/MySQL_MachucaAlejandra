USE ventas;

-- 1. Obtener el total de pedidos realizados por un cliente

DELIMITER //
CREATE FUNCTION total_pedidos(id_cliente INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE total_p INT DEFAULT 0;
    
    SELECT COUNT(*) INTO total_p FROM pedido WHERE id = id_cliente;
    RETURN total_p;
END //
DELIMITER ;
-- DROP FUNCTION total_pedidos;

SELECT P.id, total_pedidos(P.id) FROM pedido P;

 -- 3. Obtener el cliente con mayor total en pedidos
 
 DELIMITER //
 CREATE FUNCTION total_mayor(id_cliente INT)
 RETURNS INT DETERMINISTIC
 BEGIN
	DECLARE total_m INT DEFAULT 0;

    SELECT SUM(total) INTO total_m
    FROM pedido LIMIT 1;
    
    RETURN total_m;
 END //
 DELIMITER ;
 
 SELECT C.id_cliente, total_mayor(C.id_cliente) AS total_pedido FROM pedido C;