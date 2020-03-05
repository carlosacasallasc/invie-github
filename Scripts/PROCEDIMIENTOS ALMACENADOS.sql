IF OBJECT_ID('paCrearUsuario')IS NOT NULL
BEGIN
	DROP PROCEDURE paCrearUsuario
END
GO

CREATE PROCEDURE paCrearUsuario
	@NombreUsuario VARCHAR(50),
	@NombrePersona VARCHAR(30),
	@ApellidoPersona VARCHAR(30),
	@DireccionResidencia VARCHAR(60),
	@Telefono NUMERIC(30),
	@FechaNacimiento DATE,
	@NumeroDocumento VARCHAR(30),
	@IdTipoDocumento INT,
	@IdPais INT,
	@IdDepartamento BIGINT,
	@IdCiudad BIGINT	
AS
BEGIN

	DECLARE @IdPersona BIGINT

	INSERT INTO PERSONA 
	(	
		NombrePersona,
		ApellidoPersona,
		DireccionResidencia ,
		Telefono,
		FechaNacimiento,
		NumeroDocumento,
		IdPais,
		IdDepartamento,
		IdCiudad,
		IdTipoDocumento
	)
	VALUES
	(		
		@NombrePersona,
		@ApellidoPersona,
		@DireccionResidencia,
		@Telefono,
		@FechaNacimiento,
		@NumeroDocumento,
		@IdPais,
		@IdDepartamento,
		@IdCiudad,
		@IdTipoDocumento
	)
	
	SET @IdPersona = SCOPE_IDENTITY()	 

	INSERT INTO USUARIO 
	(	
		NombreUsuario,
		FechaCreacion,
		IdPersona
	)
	VALUES
	(
		@NombreUsuario,		
		GETDATE(),
		@IdPersona
	)
END
GO


IF OBJECT_ID('paActualizarUsuario')IS NOT NULL
BEGIN
	DROP PROCEDURE paActualizarUsuario
END
GO

CREATE PROCEDURE paActualizarUsuario
	@IdUsuario BIGINT,
	@IdPersona BIGINT,
	@NombreUsuario VARCHAR(50),
	@NombrePersona VARCHAR(30),
	@ApellidoPersona VARCHAR(30),
	@DireccionResidencia VARCHAR(60),
	@Telefono NUMERIC(30),
	@FechaNacimiento DATE,
	@NumeroDocumento VARCHAR(30),
	@IdTipoDocumento INT,
	@IdPais INT,
	@IdDepartamento BIGINT,
	@IdCiudad BIGINT	
AS
BEGIN

	UPDATE PERSONA 
		SET
		NombrePersona = @NombrePersona,
		ApellidoPersona = @ApellidoPersona,
		DireccionResidencia = @DireccionResidencia,
		Telefono = @Telefono,
		FechaNacimiento = @FechaNacimiento,
		NumeroDocumento = @NumeroDocumento,
		IdPais = @IdPais,
		IdDepartamento = @IdDepartamento,
		IdCiudad = @IdCiudad,
		IdTipoDocumento = @IdTipoDocumento
	WHERE IdPersona = @IdPersona
	
	UPDATE USUARIO 
	SET	
		NombreUsuario = @NombreUsuario
	WHERE IdUsuario = @IdUsuario
	
END
GO


IF OBJECT_ID('paConsultarUsuarios')IS NOT NULL
BEGIN
	DROP PROCEDURE paConsultarUsuarios
END	
GO


CREATE PROCEDURE paConsultarUsuarios	
AS
BEGIN
		SELECT 
			PER.IdPersona,
			USU.IdUsuario,
			PER.IdTipoDocumento,
			DescripcionTipoDocumento,
			DescripcionCorta,        
			NombrePersona,
			ApellidoPersona,
			FechaCreacion,
			Telefono,
			NombreUsuario,
			DireccionResidencia,
			FechaNacimiento,
			NumeroDocumento,
			PER.IdCiudad,
			CodigoPostalCiudad,
			NombreCiudad, 
			PER.IdDepartamento,
			NombreDepartamento,
			CodigoPostalDepartamento,                        
			PER.IdPais,
			NombrePais,
			CodigoPostal
		FROM PERSONA PER
			INNER JOIN USUARIO  USU
				ON PER.IdPersona = USU.IdPersona
			INNER JOIN TIPODOCUMENTO TIP
				ON TIP.IdTipoDocumento = PER.IdTipoDocumento
			INNER JOIN PAIS PAI
				ON PAI.IdPais = PER.IdPais
			INNER JOIN DEPARTAMENTO DEP
				ON DEP.IdDepartamento = PER.IdDepartamento
			INNER JOIN CIUDAD CIU
				ON CIU.IdCiudad = PER.IdCiudad					
END
GO

IF OBJECT_ID('paConsultarUsuarioPorDocumento')IS NOT NULL
BEGIN
	DROP PROCEDURE paConsultarUsuarioPorDocumento
END	
GO

CREATE PROCEDURE paConsultarUsuarioPorDocumento
	@NumeroDocumento VARCHAR(30)
AS
BEGIN
		SELECT 
			PER.IdPersona,
			USU.IdUsuario,
			PER.IdTipoDocumento,
			DescripcionTipoDocumento,
			DescripcionCorta,        
			NombrePersona,
			ApellidoPersona,
			FechaCreacion,
			Telefono,
			NombreUsuario,
			DireccionResidencia,
			FechaNacimiento,
			NumeroDocumento,
			PER.IdCiudad,
			CodigoPostalCiudad,
			NombreCiudad, 
			PER.IdDepartamento,
			NombreDepartamento,
			CodigoPostalDepartamento,                        
			PER.IdPais,
			NombrePais,
			CodigoPostal
		FROM PERSONA PER
			INNER JOIN USUARIO  USU
				ON PER.IdPersona = USU.IdPersona
			INNER JOIN TIPODOCUMENTO TIP
				ON TIP.IdTipoDocumento = PER.IdTipoDocumento
			INNER JOIN PAIS PAI
				ON PAI.IdPais = PER.IdPais
			INNER JOIN DEPARTAMENTO DEP
				ON DEP.IdDepartamento = PER.IdDepartamento
			INNER JOIN CIUDAD CIU
				ON CIU.IdCiudad = PER.IdCiudad
		WHERE PER.NumeroDocumento = @NumeroDocumento				
END
GO

IF OBJECT_ID('paConsultarTiposDocumento') IS NOT NULL
BEGIN
	DROP PROCEDURE paConsultarTiposDocumento
END
GO

CREATE PROCEDURE paConsultarTiposDocumento
AS
BEGIN
	SELECT 
		IdTipoDocumento,
		DescripcionTipoDocumento,
		DescripcionCorta
	FROM TIPODOCUMENTO
END
GO


IF OBJECT_ID('paConsultarPaises') IS NOT NULL
BEGIN
	DROP PROCEDURE paConsultarPaises
END
GO

CREATE PROCEDURE paConsultarPaises
AS
BEGIN
	SELECT 
		IdPais,
		NombrePais,
		CodigoPostal
	FROM PAIS
END
GO


IF OBJECT_ID('paConsultarDepartamentos') IS NOT NULL
BEGIN
	DROP PROCEDURE paConsultarDepartamentos
END
GO

CREATE PROCEDURE paConsultarDepartamentos
AS
BEGIN
	SELECT 
		IdDepartamento,
		NombreDepartamento,
		CodigoPostalDepartamento,
		IdPais
	FROM DEPARTAMENTO
END
GO


IF OBJECT_ID('paConsultarCiudades') IS NOT NULL
BEGIN
	DROP PROCEDURE paConsultarCiudades
END
GO

CREATE PROCEDURE paConsultarCiudades
AS
BEGIN
	SELECT 
		IdCiudad,
		NombreCiudad,
		CodigoPostalCiudad,
		IdDepartamento
	FROM CIUDAD
END
GO

IF OBJECT_ID('paBorrarUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE paBorrarUsuario
END
GO

CREATE PROCEDURE paBorrarUsuario
	@NumeroDocumento VARCHAR(30)
AS
BEGIN
	DECLARE @IdPersona BIGINT
	SELECT 
		@IdPersona = IdPersona		
	FROM PERSONA
	WHERE NumeroDocumento = @NumeroDocumento

	DELETE FROM USUARIO WHERE IdPersona = @IdPersona
	DELETE FROM PERSONA WHERE IdPersona = @IdPersona

END
GO

