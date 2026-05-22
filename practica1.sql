-- PRACTICA 1, Nathaly Evangelina Castro Armas (Corregido)

CREATE DATABASE Tienda;
GO

USE Tienda;
GO

-- Creacion de tablas

CREATE TABLE tipodeproducto(
  id_tipo_productoPK INT IDENTITY(1,1),
  nombre_del_tipo_de_producto varchar(30) NOT NULL
);

CREATE TABLE producto (
   id_productoPK INT IDENTITY(1,1),
   nombre varchar(10) NOT NULL,
   descripcion varchar (50),
   precio decimal (5,2) NOT NULL,
   id_tipo_productoFK INT
);

CREATE TABLE cliente (
   id_clientePK INT IDENTITY(1,1),
   nombre varchar (12) NOT NULL,
   apellido varchar (12)  NOT NULL,
   telefono varchar (8) NOT NULL,
   direccion varchar (70) NOT NULL,
   email varchar (30) NOT NULL,
   dui char (10) NOT NULL
);

CREATE TABLE venta (
  id_ventaPK INT IDENTITY(1,1),
  fecha_venta DATE NOT NULL,
  id_clienteFK INT NOT NULL,
  total_venta DECIMAL(10,2) NOT NULL
);

CREATE TABLE detalleventa (
  id_detallePK INT IDENTITY(1,1),
  id_ventaFK INT NOT NULL,
  id_productoFK INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DECIMAL (10,2) NOT NULL
);

-- Primarias

ALTER TABLE tipodeproducto ADD CONSTRAINT PK_id_tipo_producto
PRIMARY KEY (id_tipo_productoPK);

ALTER TABLE producto ADD CONSTRAINT PK_id_producto
PRIMARY KEY (id_productoPK);

ALTER TABLE cliente ADD CONSTRAINT PK_id_cliente
PRIMARY KEY (id_clientePK);

ALTER TABLE detalleventa ADD CONSTRAINT PK_id_detalle
PRIMARY KEY (id_detallePK);

-- Foraneas

ALTER TABLE producto ADD CONSTRAINT FK_id_tipo_producto
FOREIGN KEY (id_tipo_productoFK)
REFERENCES tipodeproducto(id_tipo_productoPK)
ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE venta ADD CONSTRAINT FK_id_cliente
FOREIGN KEY (id_clienteFK)
REFERENCES cliente(id_clientePK)
ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE detalleventa ADD CONSTRAINT FK_id_venta
FOREIGN KEY (id_ventaFK)
REFERENCES venta(id_ventaPK)
ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE detalleventa ADD CONSTRAINT FK_id_producto
FOREIGN KEY (id_productoFK)
REFERENCES producto(id_productoPK)
ON UPDATE CASCADE ON DELETE NO ACTION;

-- INSERTS

INSERT INTO tipodeproducto(nombre_del_tipo_de_producto)
VALUES ('Bebidas');

INSERT INTO producto(nombre, descripcion, precio, id_tipo_productoFK)
VALUES ('CocaCola', 'Bebida gaseosa', 1.50, 1);

INSERT INTO cliente(nombre, apellido, telefono, direccion, email, dui)
VALUES ('Nathaly', 'Castro', '12345678', 'San Salvador', 'nathaly@gmail.com', '12345678-9');

INSERT INTO venta(fecha_venta, id_clienteFK, total_venta)
VALUES ('2026-05-21', 1, 15.50);

INSERT INTO detalleventa(id_ventaFK, id_productoFK, cantidad, subtotal)
VALUES (1, 1, 2, 3.00);

-- SELECTS

SELECT nombre_del_tipo_de_producto FROM tipodeproducto;
SELECT * FROM tipodeproducto;

SELECT nombre FROM producto;
SELECT * FROM producto;

SELECT nombre FROM cliente;
SELECT * FROM cliente;

SELECT fecha_venta FROM venta;
SELECT * FROM venta;

SELECT subtotal FROM detalleventa;
SELECT * FROM detalleventa;
