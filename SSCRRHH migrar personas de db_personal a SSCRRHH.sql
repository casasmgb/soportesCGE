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
 *******************************************/
CREATE PROCEDURE [dbo].[spr_creat_personal_backup_SSCRRHH] @nombre varchar(20)
AS
BEGIN
	DECLARE @nombreTabla NVARCHAR(200)
	SET @nombreTabla = @nombre
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
	IF NOT EXISTS (select * from @nombreTabla)
		BEGIN
		    RAISERROR (
		        'NO SE PUDO CREAR LA TABLA',
		        15,
		        10
		    )
		    GOTO HANDLE_ERROR 
		END	
END 