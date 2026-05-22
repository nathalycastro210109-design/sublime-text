-- PRACTICA 1, Nathaly Evangelina Castro Armas (Corregido y Robusto)

-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Tienda')
BEGIN
  CREATE DATABASE [Tienda];
END
GO

USE [Tienda];
GO

-- Eliminar tablas en orden inverso de dependencias para evitar errores de llaves foráneas
IF OBJECT_ID('[dbo].[detalleventa]', 'U') IS NOT NULL DROP TABLE [dbo].[detalleventa];
IF OBJECT_ID('[dbo].[venta]', 'U') IS NOT NULL DROP TABLE [dbo].[venta];
IF OBJECT_ID('[dbo].[producto]', 'U') IS NOT NULL DROP TABLE [dbo].[producto];
IF OBJECT_ID('[dbo].[cliente]', 'U') IS NOT NULL DROP TABLE [dbo].[cliente];
IF OBJECT_ID('[dbo].[tipodeproducto]', 'U') IS NOT NULL DROP TABLE [dbo].[tipodeproducto];
GO

-- 1. Crear tabla tipodeproducto
CREATE TABLE [dbo].[tipodeproducto](
  [id_tipo_productoPK] INT IDENTITY(1,1) NOT NULL,
  [nombre_del_tipo_de_producto] VARCHAR(30) NOT NULL,
  CONSTRAINT [PK_id_tipo_producto] PRIMARY KEY ([id_tipo_productoPK])
);
GO

-- 2. Crear tabla cliente
CREATE TABLE [dbo].[cliente] (
   [id_clientePK] INT IDENTITY(1,1) NOT NULL,
   [nombre] VARCHAR(12) NOT NULL,
   [apellido] VARCHAR(12) NOT NULL,
   [telefono] VARCHAR(8) NOT NULL,
   [direccion] VARCHAR(70) NOT NULL,
   [email] VARCHAR(30) NOT NULL,
   [dui] CHAR(10) NOT NULL,
   CONSTRAINT [PK_id_cliente] PRIMARY KEY ([id_clientePK])
);
GO

-- 3. Crear tabla producto
CREATE TABLE [dbo].[producto] (
   [id_productoPK] INT IDENTITY(1,1) NOT NULL,
   [nombre] VARCHAR(10) NOT NULL,
   [descripcion] VARCHAR(50) NULL,
   [precio] DECIMAL(5,2) NOT NULL,
   [id_tipo_productoFK] INT NULL,
   CONSTRAINT [PK_id_producto] PRIMARY KEY ([id_productoPK]),
   CONSTRAINT [FK_id_tipo_producto] FOREIGN KEY ([id_tipo_productoFK])
      REFERENCES [dbo].[tipodeproducto]([id_tipo_productoPK])
      ON UPDATE CASCADE ON DELETE NO ACTION
);
GO

-- 4. Crear tabla venta
CREATE TABLE [dbo].[venta] (
  [id_ventaPK] INT IDENTITY(1,1) NOT NULL,
  [fecha_venta] DATE NOT NULL,
  [id_clienteFK] INT NOT NULL,
  [total_venta] DECIMAL(10,2) NOT NULL,
  CONSTRAINT [PK_id_venta] PRIMARY KEY ([id_ventaPK]),
  CONSTRAINT [FK_id_cliente] FOREIGN KEY ([id_clienteFK])
      REFERENCES [dbo].[cliente]([id_clientePK])
      ON UPDATE CASCADE ON DELETE NO ACTION
);
GO

-- 5. Crear tabla detalleventa
CREATE TABLE [dbo].[detalleventa] (
  [id_detallePK] INT IDENTITY(1,1) NOT NULL,
  [id_ventaFK] INT NOT NULL,
  [id_productoFK] INT NOT NULL,
  [cantidad] INT NOT NULL,
  [subtotal] DECIMAL(10,2) NOT NULL,
  CONSTRAINT [PK_id_detalle] PRIMARY KEY ([id_detallePK]),
  CONSTRAINT [FK_id_venta] FOREIGN KEY ([id_ventaFK])
      REFERENCES [dbo].[venta]([id_ventaPK])
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT [FK_id_producto] FOREIGN KEY ([id_productoFK])
      REFERENCES [dbo].[producto]([id_productoPK])
      ON UPDATE CASCADE ON DELETE NO ACTION
);
GO

-- INSERTS (Ahora con nombres calificados y GO para asegurar que las tablas existen)

INSERT INTO [dbo].[tipodeproducto] ([nombre_del_tipo_de_producto])
VALUES ('Bebidas');
GO

INSERT INTO [dbo].[producto] ([nombre], [descripcion], [precio], [id_tipo_productoFK])
VALUES ('CocaCola', 'Bebida gaseosa', 1.50, 1);
GO

INSERT INTO [dbo].[cliente] ([nombre], [apellido], [telefono], [direccion], [email], [dui])
VALUES ('Nathaly', 'Castro', '12345678', 'San Salvador', 'nathaly@gmail.com', '12345678-9');
GO

INSERT INTO [dbo].[venta] ([fecha_venta], [id_clienteFK], [total_venta])
VALUES ('2026-05-21', 1, 15.50);
GO

INSERT INTO [dbo].[detalleventa] ([id_ventaFK], [id_productoFK], [cantidad], [subtotal])
VALUES (1, 1, 2, 3.00);
GO

-- SELECTS

SELECT [nombre_del_tipo_de_producto] FROM [dbo].[tipodeproducto];
SELECT * FROM [dbo].[tipodeproducto];

SELECT [nombre] FROM [dbo].[producto];
SELECT * FROM [dbo].[producto];

SELECT [nombre] FROM [dbo].[cliente];
SELECT * FROM [dbo].[cliente];

SELECT [fecha_venta] FROM [dbo].[venta];
SELECT * FROM [dbo].[venta];

SELECT [subtotal] FROM [dbo].[detalleventa];
SELECT * FROM [dbo].[detalleventa];
GO

-- NOTA: Si en SSMS los nombres aparecen en rojo, presione Ctrl + Shift + R para refrescar el cache de IntelliSense.
