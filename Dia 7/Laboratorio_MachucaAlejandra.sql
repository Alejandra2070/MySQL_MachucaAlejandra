CREATE DATABASE Laboratorio_T2;

USE Laboratorio_T2;

CREATE TABLE Sucursales (
id_sucursal INT PRIMARY KEY,
Ubicacion VARCHAR(50),
Telefono_fijo INT,
Celular INT,
Correo_electronico VARCHAR(50)
);

CREATE TABLE Empleados (
id_empleado INT PRIMARY KEY,
Cedula INT,
Nombres VARCHAR(60),
Apellidos VARCHAR(60),
Ubicacion VARCHAR(50),
Celular INT,
Correo_electronico VARCHAR(50),
id_sucursal INT,
FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
);

CREATE TABLE Clientes (
id_cliente INT PRIMARY KEY,
Cedula INT,
Nombres VARCHAR(60),
Apellidos VARCHAR(60),
Ubicacion VARCHAR(50),
Celular INT,
Correo_electronico VARCHAR(50)
);

CREATE TABLE Vehiculos (
id_vehiculo INT PRIMARY KEY,
Tipo_vehiculo VARCHAR(50),
Placa VARCHAR(50),
Referencia INT,
Modelo VARCHAR(50),
Puertas INT,
Capacidad INT,
Sunroof VARCHAR(30),
Motor VARCHAR(50),
Color VARCHAR(40)
);

CREATE TABLE Alquileres (
id_alquiler INT PRIMARY KEY,
Fecha_salida DATE,
Fecha_llegada DATE,
Fecha_esperada DATE,
Valor_alquiler_semana INT,
Valor_alquiler_dia INT,
Porcentaje_descuento INT,
Valor_cotizado INT,
Valor_pagado INT,
id_vehiculo INT,
id_cliente INT,
id_empleado INT,
id_sucursal INT,
FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo),
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
);