CREATE DATABASE [HOSPITAL];
GO

USE [HOSPITAL];
GO

-- Tablas

CREATE TABLE [especialidad] (
    [id_especialidadPK] INT IDENTITY(1,1),
    [nombre_especialidad] VARCHAR(50) NOT NULL,
    [descripcion_especialidad] VARCHAR(100),
    CONSTRAINT [PK_id_especialidad] PRIMARY KEY ([id_especialidadPK])
);
GO

CREATE TABLE [tipousuario] (
    [id_tipo_usuarioPK] INT IDENTITY(1,1),
    [nombre_tipo_usuario] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_id_tipo_usuario] PRIMARY KEY ([id_tipo_usuarioPK])
);
GO

CREATE TABLE [usuario] (
    [id_usuarioPK] INT IDENTITY(1,1),
    [nombre_usuario] VARCHAR(30) NOT NULL,
    [contra_usuario] VARCHAR(100) NOT NULL,
    [id_tipo_usuarioFK] INT,
    CONSTRAINT [PK_id_usuario] PRIMARY KEY ([id_usuarioPK])
);
GO

CREATE TABLE [medico] (
    [id_medicoPK] INT IDENTITY(1,1),
    [nombres_medico] VARCHAR(50) NOT NULL,
    [apellidos_medico] VARCHAR(50) NOT NULL,
    [id_especialidadFK] INT,
    [id_usuarioFK] INT,
    CONSTRAINT [PK_id_medico] PRIMARY KEY ([id_medicoPK])
);
GO

CREATE TABLE [pais_origen] (
    [id_paisPK] INT IDENTITY(1,1),
    [nombre_pais] VARCHAR(50) NOT NULL,
    CONSTRAINT [PK_id_pais] PRIMARY KEY ([id_paisPK])
);
GO

CREATE TABLE [departamento] (
    [id_departamentoPK] INT IDENTITY(1,1),
    [nombre_departamento] VARCHAR(50) NOT NULL,
    [id_paisFK] INT,
    CONSTRAINT [PK_id_departamento] PRIMARY KEY ([id_departamentoPK])
);
GO

CREATE TABLE [municipio] (
    [id_municipioPK] INT IDENTITY(1,1),
    [nombre_municipio] VARCHAR(50) NOT NULL,
    [id_departamentoFK] INT,
    CONSTRAINT [PK_id_municipio] PRIMARY KEY ([id_municipioPK])
);
GO

CREATE TABLE [paciente] (
    [id_pacientePK] INT IDENTITY(1,1),
    [nombres_paciente] VARCHAR(50) NOT NULL,
    [apellidos_paciente] VARCHAR(50) NOT NULL,
    [fecha_nacimiento] DATE NOT NULL,
    [sexo] CHAR(1),
    [direccion] VARCHAR(100),
    [id_municipioFK] INT,
    CONSTRAINT [PK_id_paciente] PRIMARY KEY ([id_pacientePK])
);
GO

CREATE TABLE [telefono] (
    [id_telefonoPK] INT IDENTITY(1,1),
    [numero_telefono] VARCHAR(15) NOT NULL,
    [id_pacienteFK] INT,
    CONSTRAINT [PK_id_telefono] PRIMARY KEY ([id_telefonoPK])
);
GO

CREATE TABLE [medicamento] (
    [id_medicamentoPK] INT IDENTITY(1,1),
    [nombre_medicamento] VARCHAR(50) NOT NULL,
    [descripcion_medicamento] VARCHAR(100),
    [precio] DECIMAL(8,2) NOT NULL,
    CONSTRAINT [PK_id_medicamento] PRIMARY KEY ([id_medicamentoPK])
);
GO

CREATE TABLE [procedimiento] (
    [id_procedimientoPK] INT IDENTITY(1,1),
    [nombre_procedimiento] VARCHAR(50) NOT NULL,
    [descripcion_procedimiento] VARCHAR(100) NOT NULL,
    [costo] DECIMAL(8,2),
    CONSTRAINT [PK_id_procedimiento] PRIMARY KEY ([id_procedimientoPK])
);
GO

CREATE TABLE [consulta] (
    [id_consultaPK] INT IDENTITY(1,1),
    [fecha_consulta] DATE NOT NULL,
    [diagnostico] VARCHAR(200),
    [id_pacienteFK] INT,
    [id_medicoFK] INT,
    CONSTRAINT [PK_id_consulta] PRIMARY KEY ([id_consultaPK])
);
GO

CREATE TABLE [factura] (
    [id_facturaPK] INT IDENTITY(1,1),
    [fecha_factura] DATETIME NOT NULL,
    [total] DECIMAL(10,2),
    [id_pacienteFK] INT,
    CONSTRAINT [PK_id_factura] PRIMARY KEY ([id_facturaPK])
);
GO

CREATE TABLE [detalle_factura] (
    [id_detalle_facturaPK] INT IDENTITY(1,1),
    [cantidad] INT NOT NULL,
    [precio_unitario] DECIMAL(8,2) NOT NULL,
    [subtotal] DECIMAL(10,2) NOT NULL,
    [id_facturaFK] INT,
    [id_medicamentoFK] INT,
    [id_procedimientoFK] INT,
    CONSTRAINT [PK_id_detalle_factura] PRIMARY KEY ([id_detalle_facturaPK])
);
GO

-- LLAVES FORÁNEAS

-- Relación: departamento -> pais_origen
ALTER TABLE [departamento]
ADD CONSTRAINT [FK_departamento_pais]
FOREIGN KEY ([id_paisFK])
REFERENCES [pais_origen]([id_paisPK]);
GO

-- Relación: municipio -> departamento
ALTER TABLE [municipio]
ADD CONSTRAINT [FK_municipio_departamento]
FOREIGN KEY ([id_departamentoFK])
REFERENCES [departamento]([id_departamentoPK]);
GO

-- Relación: paciente -> municipio
ALTER TABLE [paciente]
ADD CONSTRAINT [FK_paciente_municipio]
FOREIGN KEY ([id_municipioFK])
REFERENCES [municipio]([id_municipioPK]);
GO

-- Relación: usuario -> tipousuario
ALTER TABLE [usuario]
ADD CONSTRAINT [FK_usuario_tipo_usuario]
FOREIGN KEY ([id_tipo_usuarioFK])
REFERENCES [tipousuario]([id_tipo_usuarioPK]);
GO

-- Relación: medico -> especialidad
ALTER TABLE [medico]
ADD CONSTRAINT [FK_medico_especialidad]
FOREIGN KEY ([id_especialidadFK])
REFERENCES [especialidad]([id_especialidadPK]);
GO

-- Relación: medico -> usuario
ALTER TABLE [medico]
ADD CONSTRAINT [FK_medico_usuario]
FOREIGN KEY ([id_usuarioFK])
REFERENCES [usuario]([id_usuarioPK]);
GO

-- Relación: telefono -> paciente
ALTER TABLE [telefono]
ADD CONSTRAINT [FK_telefono_paciente]
FOREIGN KEY ([id_pacienteFK])
REFERENCES [paciente]([id_pacientePK]);
GO

-- Relación: consulta -> paciente
ALTER TABLE [consulta]
ADD CONSTRAINT [FK_consulta_paciente]
FOREIGN KEY ([id_pacienteFK])
REFERENCES [paciente]([id_pacientePK]);
GO

-- Relación: consulta -> medico
ALTER TABLE [consulta]
ADD CONSTRAINT [FK_consulta_medico]
FOREIGN KEY ([id_medicoFK])
REFERENCES [medico]([id_medicoPK]);
GO

-- Relación: factura -> paciente
ALTER TABLE [factura]
ADD CONSTRAINT [FK_factura_paciente]
FOREIGN KEY ([id_pacienteFK])
REFERENCES [paciente]([id_pacientePK]);
GO

-- Relación: detalle_factura -> factura
ALTER TABLE [detalle_factura]
ADD CONSTRAINT [FK_detalle_factura_factura]
FOREIGN KEY ([id_facturaFK])
REFERENCES [factura]([id_facturaPK]);
GO

-- Relación: detalle_factura -> medicamento
ALTER TABLE [detalle_factura]
ADD CONSTRAINT [FK_detalle_factura_medicamento]
FOREIGN KEY ([id_medicamentoFK])
REFERENCES [medicamento]([id_medicamentoPK]);
GO

-- Relación: detalle_factura -> procedimiento
ALTER TABLE [detalle_factura]
ADD CONSTRAINT [FK_detalle_factura_procedimiento]
FOREIGN KEY ([id_procedimientoFK])
REFERENCES [procedimiento]([id_procedimientoPK]);
GO
