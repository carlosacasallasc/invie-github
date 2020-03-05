IF (NOT EXISTS (SELECT name 
FROM master.dbo.sysdatabases 
WHERE ('[' + name + ']' = 'Seguridad_Test'
OR name = 'Seguridad_Test')))
BEGIN
	CREATE DATABASE Seguridad_Test
END
GO

USE Seguridad_Test
GO

/********************************************************
BORRADO DE TABLAS Y CONSTRAINTS
********************************************************/
IF OBJECT_ID('USUARIO') IS NOT NULL
BEGIN
	--ALTER TABLE USUARIO DROP CONSTRAINT FK_IDPERSONA_USUARIO
	DROP TABLE USUARIO
END
GO

IF OBJECT_ID('PERSONA') IS NOT NULL
BEGIN
	DROP TABLE PERSONA
END
GO

IF OBJECT_ID('CIUDAD') IS NOT NULL
BEGIN
	DROP TABLE CIUDAD
END
GO

IF OBJECT_ID('DEPARTAMENTO') IS NOT NULL
BEGIN	
	DROP TABLE DEPARTAMENTO
END
GO

IF OBJECT_ID('PAIS') IS NOT NULL
BEGIN
	DROP TABLE PAIS
END
GO

IF OBJECT_ID('TIPODOCUMENTO') IS NOT NULL
BEGIN
	DROP TABLE TIPODOCUMENTO
END
GO

/********************************************************
CREACION DE TABLAS
********************************************************/

CREATE TABLE PAIS
(
	IdPais INT IDENTITY PRIMARY KEY,
	NombrePais VARCHAR(50),
	CodigoPostal VARCHAR(30),
	Latitutd VARCHAR(50),
	Longitud VARCHAR(50)
)
GO


CREATE TABLE DEPARTAMENTO
(
	IdDepartamento BIGINT IDENTITY PRIMARY KEY,
	NombreDepartamento VARCHAR(50),
	CodigoPostalDepartamento VARCHAR(30),
	IdPais INT,

	CONSTRAINT FK_IDPAIS_DEPARTAMENTO FOREIGN KEY (IdPais) REFERENCES PAIS (IdPais)
)
GO


CREATE TABLE CIUDAD
(
	IdCiudad BIGINT IDENTITY PRIMARY KEY,
	NombreCiudad VARCHAR(50),
	CodigoPostalCiudad VARCHAR(30),
	IdDepartamento	BIGINT,
	CONSTRAINT FK_IDDEPARTAMENTO_CIUDAD FOREIGN KEY (IdDepartamento) REFERENCES DEPARTAMENTO (IdDepartamento)
)
GO



CREATE TABLE TIPODOCUMENTO
(
	IdTipoDocumento INT IDENTITY PRIMARY KEY,
	DescripcionTipoDocumento VARCHAR(30),
	DescripcionCorta VARCHAR(3)
)
GO


CREATE TABLE PERSONA
(
	IdPersona BIGINT IDENTITY PRIMARY KEY,
	IdTipoDocumento INT,
	NombrePersona VARCHAR(30),
	ApellidoPersona VARCHAR(30),
	DireccionResidencia VARCHAR(60),
	Telefono NUMERIC(30),
	FechaNacimiento DATE,
	NumeroDocumento VARCHAR(30),
	IdPais INT,
	IdDepartamento BIGINT,
	IdCiudad BIGINT,
	CONSTRAINT FK_IDTIPODOCUMENTO_PERSONA FOREIGN KEY (IdTipoDocumento) REFERENCES TIPODOCUMENTO (IdTipoDocumento),
	CONSTRAINT FK_IDCIUDAD_PERSONA FOREIGN KEY (IdCiudad) REFERENCES CIUDAD (IdCiudad),
	CONSTRAINT FK_IDDEPARTAMENTO_PERSONA FOREIGN KEY (IdDepartamento) REFERENCES Departamento (IdDepartamento),
	CONSTRAINT FK_IDPAIS_PERSONA FOREIGN KEY (IdPais) REFERENCES PAIS (IdPais),
)
GO

CREATE TABLE USUARIO
(
	IdUsuario BIGINT IDENTITY PRIMARY KEY,
	NombreUsuario VARCHAR(40),
	FechaCreacion DATE,
	IdPersona BIGINT,
	CONSTRAINT FK_IDPERSONA_USUARIO FOREIGN KEY (IdPersona) REFERENCES PERSONA (IdPersona)
)
GO

/********************************************************
INSERCION DE DATOS
********************************************************/

INSERT INTO TIPODOCUMENTO (DescripcionTipoDocumento, DescripcionCorta)
VALUES ('Cédula', 'CC')
GO
INSERT INTO TIPODOCUMENTO (DescripcionTipoDocumento, DescripcionCorta)
VALUES ('Tarjeta de Identidad', 'TI')
GO
INSERT INTO TIPODOCUMENTO (DescripcionTipoDocumento, DescripcionCorta)
VALUES ('Cédula de Extrangería', 'CE')
GO
INSERT INTO TIPODOCUMENTO (DescripcionTipoDocumento, DescripcionCorta)
VALUES ('PASAPORTE', 'PP')
GO



INSERT INTO PAIS (NombrePais,	CodigoPostal,	Latitutd, Longitud)
VALUES ('COLOMBIA', '01', '50.411', '60.48')
INSERT INTO PAIS (NombrePais,	CodigoPostal,	Latitutd, Longitud)
VALUES ('ESTADOS UNIDOS', '02', '60.321', '72.562')
INSERT INTO PAIS (NombrePais,	CodigoPostal,	Latitutd, Longitud)
VALUES ('MEXICO', '03', '40.451', '71.621')

SELECT * FROM PAIS

INSERT INTO DEPARTAMENTO (NombreDepartamento, CodigoPostalDepartamento, IdPais)
VALUES ('CUNDINAMARCA', '01', 1)
INSERT INTO DEPARTAMENTO (NombreDepartamento, CodigoPostalDepartamento, IdPais)
VALUES ('TOLIMA', '02', 1)

INSERT INTO DEPARTAMENTO (NombreDepartamento, CodigoPostalDepartamento, IdPais)
VALUES ('TEXAS', '01', 2)
INSERT INTO DEPARTAMENTO (NombreDepartamento, CodigoPostalDepartamento, IdPais)
VALUES ('FLORIDA', '02', 2)

INSERT INTO DEPARTAMENTO (NombreDepartamento, CodigoPostalDepartamento, IdPais)
VALUES ('PUEBLA', '01', 3)
INSERT INTO DEPARTAMENTO (NombreDepartamento, CodigoPostalDepartamento, IdPais)
VALUES ('ESTADO DE MEXICO', '02', 3)

SELECT * FROM DEPARTAMENTO

INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('BOGOTÁ', '1001000', 1)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('CHIA', '1001000', 1)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('IBAGUE', '1001000', 2)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('FALNDES', '1001000', 2)

INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('HOUSTON', '1001000', 3)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('DALLAS', '1001000', 3)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('MIAMI', '1001000', 4)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('ORLANDO', '1001000', 4)

INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('CORONANGO', '1001000', 5)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('PUEBLA DE ZARAGOZA', '1001000', 5)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('TOLUCA', '1001000', 6)
INSERT INTO CIUDAD (NombreCiudad,	CodigoPostalCiudad,	IdDepartamento)
VALUES ('MONTERREY', '1001000', 6)

SELECT * FROM CIUDAD

