CREATE DATABASE Laboratorio_T2;

USE Laboratorio_T2;

-- drop database Laboratorio_T2;

CREATE TABLE Sucursales (
id_sucursal INT PRIMARY KEY AUTO_INCREMENT,
direccion VARCHAR(50),
ciudad VARCHAR(50),
telefono_fijo INT,
celular INT,
correo_electronico VARCHAR(50)
);

CREATE TABLE Empleados (
id_empleado INT PRIMARY KEY AUTO_INCREMENT,
cedula VARCHAR(50),
nombre1 VARCHAR(60),
nombre2 VARCHAR(60),
apellido1 VARCHAR(60),
apellido2 VARCHAR(60),
direccion VARCHAR(50),
ciudad VARCHAR(50),
celular INT,
correo_electronico VARCHAR(50),
id_sucursal INT,
FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
);

CREATE TABLE Clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
cedula VARCHAR(50),
nombre1 VARCHAR(60),
nombre2 VARCHAR(60),
apellido1 VARCHAR(60),
apellido2 VARCHAR(60),
celular INT,
correo_electronico VARCHAR(50)
);

CREATE TABLE Tipo_vehiculo (
	id_tipoV INT PRIMARY KEY AUTO_INCREMENT,
    valor_alquiler_semana INT,
    valor_alquiler_dia INT,
    tipo VARCHAR(55)
);

CREATE TABLE Vehiculos (
id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
placa VARCHAR(50),
referencia INT,
modelo VARCHAR(50),
puertas INT,
capacidad INT,
sunroof VARCHAR(30),
motor VARCHAR(50),
color VARCHAR(40),
id_tipoV INT,
FOREIGN KEY (id_tipoV) REFERENCES Tipo_vehiculo(id_tipoV)
);

CREATE TABLE Alquileres (
id_alquiler INT PRIMARY KEY AUTO_INCREMENT,
fecha_salida DATE,
fecha_llegada VARCHAR(55) NULL,
fecha_esperada DATE,
valor_cotizado INT,
valor_pagado INT,
id_vehiculo INT,
id_cliente INT,
id_empleado INT,
id_sucursal INT,
FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo),
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
);

CREATE TABLE Descuentos (
	id_descuento INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio DATE,
    fecha_fin DATE,
    porcentaje_descuento INT,
    id_tipoV INT,
    FOREIGN KEY (id_tipoV) REFERENCES Tipo_vehiculo(id_tipoV)
);