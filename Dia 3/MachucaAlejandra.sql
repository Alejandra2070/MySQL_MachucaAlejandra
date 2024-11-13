CREATE DATABASE migrupoT2; -- Crear una base de datos

USE migrupoT2; -- Utilizar mi base de datos

CREATE TABLE Vehiculos(
id_vehiculo INT NOT NULL PRIMARY KEY,
marca VARCHAR(25) NOT NULL,
modelo VARCHAR(30) NOT NULL,
año INT NOT NULL,
número_de_serie_único INT NOT NULL,
precio INT NOT NULL,
color VARCHAR(20) NOT NULL,
tipo_de_combustible VARCHAR(25) NOT NULL,
tipo_de_transmisión VARCHAR(30) NOT NULL,
estado VARCHAR(35) NOT NULL
);

CREATE TABLE Clientes(
id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(25) NOT NULL,
teléfono INT NOT NULL,
correo_electrónico VARCHAR(20) NOT NULL
);

CREATE TABLE Vendedores(
id_vendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(25) NOT NULL,
número_de_empleado INT NOT NULL,
fecha_de_contratación INT NOT NULL,
múltiples_ventas INT NOT NULL,
transacciones_de_ventas VARCHAR(20) NOT NULL
);

CREATE TABLE Ventas(
id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
cliente VARCHAR(30) NOT NULL,
vendedor VARCHAR(30) NOT NULL,
vehículos INT NOT NULL,
fecha_de_la_venta INT NOT NULL,
total_transacción INT NOT NULL,
método_de_pago VARCHAR(25) NOT NULL,
id_vehiculo INT NOT NULL,
FOREIGN KEY(id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
);

CREATE TABLE Mantenimiento(
id_mantenimiento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
mantenimiento VARCHAR(20) NOT NULL,
tipo_de_servicio VARCHAR(25) NOT NULL,
costo INT NOT NULL,
fecha_del_servicio INT NOT NULL,
cliente VARCHAR(30) NOT NULL,
vehiculo VARCHAR(35) NOT NULL,
id_vehiculo INT NOT NULL,
FOREIGN KEY(id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
);
DESCRIBE Vehiculos;

SHOW databases;