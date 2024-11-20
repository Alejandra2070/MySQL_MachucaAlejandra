USE Laboratorio_T2;

-- Consultas

SELECT direccion, ciudad, celular FROM Sucursales;-- 1.  Listar todas las sucursales con sus direcciones, ciudad y teléfonos.
SELECT DISTINCT apellido1 FROM Clientes;-- 2. Lista el primer apellido de los clientes eliminando los apellidos que estén repetidos.
SELECT CONCAT_WS(' ',nombre1,'',nombre2,' ',apellido1,' ',apellido2) AS NOMBRES FROM Clientes; -- 3. Lista el nombre y apellidos de los clientes en una única columna.
SELECT * FROM Sucursales;-- 4. Listar todas las sucursales disponibles
SELECT Clientes.id_cliente,Clientes.nombre1, Clientes.apellido1 FROM Clientes JOIN Alquileres ON Clientes.id_cliente = Alquileres.id_cliente;-- 5. Mostrar clientes con al menos un alquiler registrado
SELECT * FROM Empleados WHERE id_sucursal = 8;-- 6. Listar los empleados que trabajan en una sucursal especifica
SELECT V.id_vehiculo, V.placa, T.tipo FROM Vehiculos V JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV WHERE V.id_vehiculo NOT IN (SELECT id_vehiculo FROM Alquileres WHERE fecha_llegada IS NULL); -- 7. Listar vehículos disponibles para alquiler (no rentados actualmente)
SELECT V.placa, V.modelo, V.motor FROM Vehiculos V JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV WHERE T.tipo = 'Sedán'; -- 8. Listar vehículos por tipo
SELECT A.id_alquiler, C.nombre1, C.apellido1, A.fecha_esperada FROM Alquileres A JOIN Clientes C ON A.id_cliente = C.id_cliente WHERE A.fecha_llegada > A.fecha_esperada; -- 9. Mostrar alquileres que se encuentran retrasados
SELECT DISTINCT tipo,valor_alquiler_semana, valor_alquiler_dia FROM Tipo_vehiculo; -- 10. Obtener el valor de alquiler de los vehículos por tipo (semana o día)
SELECT SUM(Alquileres.valor_pagado) AS Total_ingresos FROM Alquileres WHERE Alquileres.fecha_salida BETWEEN '2024-01-10' AND  '2024-01-14'; -- 11. Obtener el total de ingresos generados por alquileres en un periodo específico
SELECT Vehiculos.placa, Vehiculos.modelo, T.tipo, T.valor_alquiler_dia, T.valor_alquiler_semana FROM Vehiculos JOIN Tipo_vehiculo T ON Vehiculos.id_tipoV = T.id_tipoV; -- 12. Listar los vehículos con su tipo, placa y el valor de alquiler correspondiente
SELECT V.placa, V.referencia, V.modelo, V.puertas, V.capacidad, V.sunroof, V.motor, V.color, T.tipo FROM Vehiculos V JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV; -- 13. Listar los vehículos disponibles para alquiler, con sus características
SELECT V.modelo, A.valor_cotizado, A.valor_pagado from Alquileres A JOIN Vehiculos V ON A.id_vehiculo = V.id_vehiculo; -- 14. Devuelve una lista con el modelo 
SELECT V.modelo from Alquileres A JOIN Vehiculos V ON A.id_vehiculo = V.id_vehiculo WHERE fecha_llegada > fecha_esperada; -- 15. Devuelve una lista con el modelo de los vehiculos donde su fecha de llegada es mayor a su fecha esperada de llegada
SELECT C.id_cliente, C.nombre1, C.apellido1 FROM Clientes C LEFT JOIN Alquileres A ON C.id_cliente = A.id_cliente WHERE A.id_cliente IS NULL; -- 16. Obtener los clientes que no han realizado ningún alquiler
SELECT C.id_cliente, C.nombre1, C.apellido1, COUNT(A.id_alquiler) AS cantidad_alquileres FROM Clientes C LEFT JOIN Alquileres A ON C.id_cliente = A.id_cliente GROUP BY C.id_cliente; -- 17. Obtener la cantidad de alquileres realizados por cada cliente
SELECT V.placa, V.modelo, T.tipo, A.id_alquiler FROM Vehiculos V JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV JOIN Alquileres A ON V.id_vehiculo = A.id_vehiculo WHERE A.fecha_llegada IS NULL; -- 18. Listar los vehículos con su tipo y los alquileres activos (sin fecha de llegada)
SELECT S.direccion, S.ciudad, E.nombre1, E.apellido1 FROM Sucursales S JOIN Empleados E ON S.id_sucursal = E.id_sucursal; -- 19.  Listar las sucursales y sus empleados 
SELECT V.placa, V.modelo, T.valor_alquiler_semana FROM Vehiculos V JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV WHERE T.tipo = 'SUV' AND V.id_vehiculo NOT IN (SELECT id_vehiculo FROM Alquileres WHERE fecha_llegada IS NULL); -- 20. Obtener los vehículos disponibles de tipo "SUV" con su placa, modelo y valor de alquiler por semana
SELECT C.nombre1, C.apellido1, A.fecha_esperada FROM Alquileres A JOIN Clientes C ON A.id_cliente = C.id_cliente WHERE A.fecha_llegada > A.fecha_esperada; -- 21. Obtener los clientes con alquileres retrasados y la fecha esperada de retorno
SELECT S.direccion, S.ciudad, COUNT(E.id_empleado) AS num_empleados FROM Sucursales S JOIN Empleados E ON S.id_sucursal = E.id_sucursal GROUP BY S.id_sucursal HAVING COUNT(E.id_empleado) > 2; -- 22. Listar las sucursales con más de 2 empleados
SELECT T.tipo, COUNT(V.id_vehiculo) AS cantidad_vehiculos FROM Vehiculos V JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV WHERE V.id_vehiculo NOT IN (SELECT id_vehiculo FROM Alquileres WHERE fecha_llegada IS NULL) GROUP BY T.id_tipoV; -- 23. Mostrar la cantidad de vehículos disponibles por cada tipo de vehículo
SELECT C.nombre1, C.apellido1, V.placa, A.fecha_salida, A.fecha_esperada FROM Alquileres A JOIN Clientes C ON A.id_cliente = C.id_cliente JOIN Vehiculos V ON A.id_vehiculo = V.id_vehiculo; -- 24. Obtener los detalles de los alquileres por cliente y vehículo
SELECT T.tipo, COUNT(V.id_vehiculo) AS cantidad_vehiculos FROM Vehiculos V JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV GROUP BY T.tipo; -- 25. Mostrar la cantidad de vehículos de cada tipo de vehículo

-- Funciones

-- 1 Función

DELIMITER //
DELIMITER //
CREATE FUNCTION descuento(id_tipoV INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE descuento INT DEFAULT 0;
    
    SELECT porcentaje_descuento INTO descuento
    FROM Descuentos
    WHERE id_tipoV = id_tipoV AND CURDATE() BETWEEN fecha_inicio AND fecha_fin
    LIMIT 1;
    
    RETURN descuento;
END //
DELIMITER ;


-- 1 Consulta
SELECT T.tipo, descuento(T.id_tipoV) AS descuento_aplicado FROM Tipo_vehiculo T; -- Devuelve el porcentaje de descuento disponible para un tipo de vehículo específico en un periodo de tiempo actual.

-- 2 Función

DELIMITER //
CREATE FUNCTION total_alquileres_cliente(id_cliente INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT DEFAULT 0;
    
    SELECT COUNT(*) INTO total
    FROM Alquileres
    WHERE id_cliente = id_cliente;
    
    RETURN total;
END //
DELIMITER ;


-- 2 Consulta

SELECT C.nombre1, C.apellido1, total_alquileres_cliente(C.id_cliente) AS alquileres_realizados FROM Clientes C; -- Devuelve el número total de alquileres realizados por un cliente específico.

-- 3 Función

DELIMITER //
CREATE FUNCTION total_ingresos_periodo(fecha_inicio DATE, fecha_fin DATE)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT DEFAULT 0;

    SELECT SUM(valor_pagado) INTO total
    FROM Alquileres
    WHERE fecha_salida BETWEEN fecha_inicio AND fecha_fin;
    
    RETURN total;
END //
DELIMITER ;

-- 3 Consulta

SELECT total_ingresos_periodo('2024-01-01', '2024-01-31') AS ingresos_enero; -- Devuelve el total de ingresos generados por los alquileres dentro de un rango de fechas específico.

-- 4 Función

DELIMITER //
CREATE FUNCTION vehiculos_disponibles()
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT DEFAULT 0;
    
    SELECT COUNT(*) INTO total
    FROM Vehiculos
    WHERE id_vehiculo NOT IN (SELECT id_vehiculo FROM Alquileres WHERE fecha_llegada IS NULL);
    
    RETURN total;
END //
DELIMITER ;

-- 4 Consulta

SELECT vehiculos_disponibles() AS total_vehiculos_disponibles; -- Devuelve el número de vehículos disponibles para alquilar

-- 5 Función

DELIMITER //
CREATE FUNCTION vehiculo_mas_caro()
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE id_vehiculo INT;
    
    SELECT id_vehiculo INTO id_vehiculo
    FROM Vehiculos
    ORDER BY (SELECT valor_alquiler_dia FROM Tipo_vehiculo WHERE id_tipoV = Vehiculos.id_tipoV) DESC
    LIMIT 1;
    
    RETURN id_vehiculo;
END //
DELIMITER ;

-- 5 Consulta

SELECT V.placa, V.modelo FROM Vehiculos V WHERE V.id_vehiculo = vehiculo_mas_caro(); -- Devuelve el ID del vehículo con el valor de alquiler más alto.

-- PROCEDIMIENTOS

-- 1. Registrar un nuevo cliente

DELIMITER //
CREATE PROCEDURE registrar_clientes(IN cedula_cliente VARCHAR(50), 
	IN nombre1_cliente VARCHAR(50), IN nombre2_cliente VARCHAR(50), 
    IN apellido1_cliente VARCHAR(50), IN apellido2_cliente VARCHAR(50), 
    IN celular_cliente VARCHAR(50), IN correo_electronico_cliente VARCHAR(50))
BEGIN
	INSERT INTO Clientes(cedula, nombre1, nombre2, apellido1, apellido2, celular, correo_electronico) 
    VALUES (cedula_cliente, nombre1_cliente, nombre2_cliente, apellido1_cliente, apellido2_cliente, celular_cliente, correo_electronico_cliente);
END
// DELIMITER ;

CALL registrar_clientes('1234567898', 'Mayra', 'Alejandra', 'Guevara', 'Jaimes', 987654423, 'mayra.guevara@cliente.com');
SELECT * FROM Clientes;

-- 2. Aplicar un descuento a un tipo de vehículo

DELIMITER //
CREATE PROCEDURE descuento(IN fechaInicio_descuento DATE, IN fechaFin_descuento DATE, IN porcentaje_descuentoB DECIMAL(5,2), IN idTipoV_descuento INT)
BEGIN
	INSERT INTO Descuentos(fecha_inicio, fecha_fin, porcentaje_descuento,id_tipoV) 
    VALUES (fechaInicio_descuento, fechaFin_descuento, porcentaje_descuentoB, idTipoV_descuento);
END
// DELIMITER ;

CALL descuento('2024-05-01', '2024-05-18', 15, 1);
SELECT * FROM Descuentos;

-- 3. Consultar el historial de un cliente

DELIMITER //
CREATE PROCEDURE consultar_historial(IN id_cliente_historial INT)
BEGIN
	SELECT A.id_alquiler, V.placa, V.modelo, A.fecha_salida, A.fecha_llegada, A.valor_cotizado, A.valor_pagado FROM Alquileres A
    INNER JOIN Vehiculos V ON A.id_vehiculo = V.id_vehiculo WHERE A.id_cliente = id_cliente_historial;
END //
DELIMITER ;

CALL consultar_historial(100);

-- 4. Consultar vehículos por precio

DELIMITER //
CREATE PROCEDURE consultar_precio(IN precio_minimo INT, precio_maximo INT)
BEGIN
	SELECT V.id_vehiculo, V.placa, V.modelo, T.tipo, T.valor_alquiler_dia, T.valor_alquiler_semana FROM Vehiculos V
    INNER JOIN Tipo_vehiculo T ON V.id_tipoV = T.id_tipoV WHERE (T.valor_alquiler_dia BETWEEN precio_minimo AND precio_maximo)
    OR (T.valor_alquiler_semana BETWEEN precio_minimo AND precio_maximo);
END //
DELIMITER ;

CALL consultar_precio(50,200); -- precio diario y precio semanal

-- 5. Eliminar un registro por descuento

DELIMITER //
CREATE PROCEDURE eliminar_descuento(IN id_descuentos INT)
BEGIN
	DELETE FROM Descuentos WHERE id_descuento = id_descuentos;
END //
DELIMITER ;

CALL eliminar_descuento(90);

-- 6. Registrar un alquiler

DELIMITER //
CREATE PROCEDURE registrar_alquiler (IN p_id_vehiculo INT, IN p_id_cliente INT, 
	IN p_id_empleado INT, IN p_id_sucursal INT, IN p_fecha_salida DATE, 
    IN p_fecha_esperada DATE, IN p_fecha_llegada DATE, IN p_valor_cotizado INT, 
    IN p_valor_pagado INT)
BEGIN
    INSERT INTO Alquileres (id_vehiculo, id_cliente, id_empleado, id_sucursal, fecha_salida, fecha_esperada, fecha_llegada, valor_cotizado, valor_pagado)
    VALUES (p_id_vehiculo, p_id_cliente, p_id_empleado, p_id_sucursal, p_fecha_salida, p_fecha_esperada, p_fecha_esperada, p_valor_cotizado, p_valor_pagado);
END //
DELIMITER ;

CALL registrar_alquiler(1, 100, 10, 3, '2024-12-01', '2024-12-10', '2024-12-10', 350, 350);
SELECT * FROM Alquileres;

-- 7. Actualizar un alquiler

DELIMITER //
CREATE PROCEDURE actualizar_alquiler (IN p_id_alquiler INT, IN p_fecha_llegada DATE, IN p_valor_pagado INT)
BEGIN
    UPDATE Alquileres
    SET fecha_llegada = p_fecha_llegada, valor_pagado = p_valor_pagado
    WHERE id_alquiler = p_id_alquiler;
END //
DELIMITER ;

CALL actualizar_alquiler(1, '2024-12-09', 370);
select * from Alquileres;

-- 8. Consultar historial de alquileres de un vehículo

DELIMITER //
CREATE PROCEDURE historial_vehiculo ( IN p_id_vehiculo INT)
BEGIN
    SELECT A.id_alquiler, C.nombre1, C.apellido1, A.fecha_salida, A.fecha_llegada, A.valor_cotizado
    FROM Alquileres A
    JOIN Clientes C ON A.id_cliente = C.id_cliente
    WHERE A.id_vehiculo = p_id_vehiculo LIMIT 1;
END //
DELIMITER ;

CALL historial_vehiculo(5);

-- 9. Inicio de sesión de un cliente

DELIMITER //
CREATE PROCEDURE inicio_sesion_cliente ( IN p_cedula VARCHAR(50), IN p_correo_electronico VARCHAR(50))
BEGIN
    IF EXISTS (SELECT 1 FROM Clientes WHERE cedula = p_cedula AND correo_electronico = p_correo_electronico) THEN
        SELECT 'Inicio de sesión exitoso' AS mensaje;
    ELSE
        SELECT 'Cédula o correo electrónico incorrectos' AS mensaje;
    END IF;
END //
DELIMITER ;

CALL inicio_sesion_cliente('1234567898', 'mayra.guevara@cliente.com');

-- 10. Consulta de alquileres pendientes de un cliente

DELIMITER //
CREATE PROCEDURE consultar_alquileres_pendientes_cliente (IN p_id_cliente INT)
BEGIN
    SELECT A.id_alquiler, V.placa, V.modelo, A.fecha_salida, A.fecha_esperada, A.fecha_llegada, A.valor_cotizado
    FROM Alquileres A
    INNER JOIN Vehiculos V ON A.id_vehiculo = V.id_vehiculo
    WHERE A.id_cliente = p_id_cliente
    AND (A.fecha_llegada IS NULL OR A.fecha_llegada > CURDATE());
END //
DELIMITER ;

CALL consultar_alquileres_pendientes_cliente(100);