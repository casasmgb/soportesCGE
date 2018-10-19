USE [SSCRRHH]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 18/10/2018
 * Script para crear una tabla con informacion
 * para la tabla personal de la base de datos SSCRRHH
 * BASE DE DATOS: BD_PERSONAL
 * Cambiar el nombre se la tabla "personal_2018_octubre"  donde se recuperaran los datos  
 * 
 * El script creara la tabla "personal_2018_octubre" en la base de datos SSCRRHH 
 * con informacion del personal regisrado en la base BD_PERSONAL
 *  
 * Ejecutar con:
 * EXEC [dbo].[spr_creat_personal_backup_SSCRRHH]
 * 
 * Realizar en SSCRRHH:
 * restaurar "DBO.PERSONAL" con los datos de la tabla "personal_2018_octubre"
 *******************************************/

CREATE PROCEDURE [dbo].[spr_creat_personal_backup_SSCRRHH]
AS
BEGIN
	DECLARE @nombreNuevaTablaPersonal NVARCHAR(50)
	SET @nombreNuevaTablaPersonal = 'personal_2018_respaldo_octubre'

	SELECT	per.per_Item, 
			per.per_Tarjeta, 
			per.per_DocIdentidad,
			per.per_Paterno, 
			per.per_Materno, 
			per.per_PrimerNombre + ' ' +per.per_SegundoNombre as per_nombres, 
			car.car_Descripcion,
			prof.pro_Descripcion,
			uni.uni_Descripcion,
			res.res_Descripcion,
			esc.esc_CodigoEscala,
			per.car_Codigo,
			per.pro_Codigo,
			0 as grupo,
			mov_fun.Aplicabilidad_MovilidadFuncional,
			per.per_FechaNacimiento,
			GETDATE() as export,
			per.per_Piso,
			per.per_Interno,
			'00:00' as CH,
			'00:00' as CH2,
			'B3' as G
	into personal_2018_octubre
	FROM BDPersonal_dev.dbo.Persona per 
	INNER JOIN BDPersonal_dev.dbo.Cargo car on car.car_Codigo = per.car_Codigo
	INNER JOIN BDPersonal_dev.dbo.Profesion prof on prof.pro_Codigo = per.pro_Codigo
	INNER JOIN BDPersonal_dev.dbo.Unidad uni on uni.uni_Codigo = per.uni_Codigo
	INNER JOIN BDPersonal_dev.dbo.Residencia res on res.res_Codigo = per.res_Codigo
	INNER JOIN BDPersonal_dev.dbo.Escala esc on esc.esc_Codigo = per.esc_Codigo
	INNER JOIN BDPersonal_dev.dbo.MovilidadFuncional mov_fun on mov_fun.per_Codigo = per.per_Codigo
	where mov_fun.Vigente_MovilidadFuncional = 1 and per.per_Vigente = 1;

	-- select * from personal_2018_octubre
	IF NOT EXISTS (select * from personal_2018_octubre)
		BEGIN
		    RAISERROR (
		        'NO SE PUDO CREAR LA TABLA',
		        15,
		        10
		    )
		    GOTO HANDLE_ERROR 
	END	
	
	--respaldar la tabla "DBO.PERSONAL"
	EXEC SP_RENAME 'DBO.PERSONAL', @nombreNuevaTablaPersonal
	
	SELECT CONVERT(NVARCHAR(5), PV.per_Item)  AS "ITEM",
	       CONVERT(FLOAT, PV.per_Tarjeta)     AS "REGISTRO",
	       CONVERT(NVARCHAR(12), PV.per_DocIdentidad) AS "CI",
	       CONVERT(NVARCHAR(50), PV.per_Paterno) AS "PATERNO",
	       CONVERT(NVARCHAR(50), PV.per_Materno) AS "MATERNO",
	       CONVERT(NVARCHAR(100), PV.per_nombres) AS "NOMBRES",
	       CONVERT(NVARCHAR(100), PV.car_Descripcion) AS "CARGO",
	       CONVERT(NVARCHAR(100), PV.pro_Descripcion) AS "PROFESION",
	       CONVERT(VARCHAR(250), PV.uni_Descripcion) AS "UNIDAD",
	       CONVERT(NVARCHAR(20), PV.res_Descripcion) AS "DPTO",
	       CONVERT(NVARCHAR(4), PV.esc_CodigoEscala) AS "ESCALA",
	       CONVERT(FLOAT, PV.car_Codigo)      AS "CODCARGO",
	       CONVERT(FLOAT, PV.pro_Codigo)      AS "CODPROFE",
	       CONVERT(FLOAT, PV.grupo)           AS "GRUPO",
	       CONVERT(SMALLDATETIME, PV.Aplicabilidad_MovilidadFuncional) AS "FECHAING",
	       CONVERT(SMALLDATETIME, PV.per_FechaNacimiento) AS "FNAC",
	       GETDATE()                          AS "EXPORT",	-- PV.export,
	       CONVERT(VARCHAR(3), PV.per_Piso)   AS "PISO",
	       CONVERT(VARCHAR(10), PV.per_Interno) AS "INTERNO",
	       CONVERT(NVARCHAR(10), '00:00')     AS "CH",
	       CONVERT(NVARCHAR(50), '00:00')     AS "CH2",
	       CONVERT(NVARCHAR(5), 'B3')         AS "G"
	INTO   dbo.PERSONAL
	FROM   DBO.personal_2018_octubre AS pv
		
	HANDLE_ERROR:
	BEGIN
		SELECT @@ERROR AS error	
	END	
END 

SELECT * FROM PERSONAL
