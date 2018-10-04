USE [SSCRRHH]
GO
/****** Object:  StoredProcedure [dbo].[spr_upd_desconsolidacion_evento_3291]    Script Date: 07/24/2018 17:01:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*******************************************
 * NUMERO DE SOPORTE: 06339/2018
 * FUNCIONARIO: LAZO VEGA NADIR DANITZA
 * DESCRIPCION:
 *       DESCONSOLIDAR LAS LISTAS DEL EVENTO DE CAPACITACION IDENTIFICACION DE DELITOS EN UNA AUDITORIA ESPECIAL
 * COD EV: 3305 
 * COD: 2G12G2775
 * TIPO DE EVENTO: CURSO 
 * 
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 23/07/2018
 * Base de datos: SSCRRHH
 * Verion Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 * Ejemplo de ejecucion:
 * EXEC dbo.spr_upd_desconsolidacion_evento_6339
 * 
 *******************************************/

CREATE PROCEDURE [dbo].[spr_upd_desconsolidacion_evento_6339]
AS
BEGIN
	DECLARE @cantidadRegistrosAfectado INT
	DECLARE @CodCorrEvEjec INT
	DECLARE @nombreTransaccion NVARCHAR(200)
	DECLARE @registrosActualizados INT
	SET @cantidadRegistrosAfectado = 0
	SET @CodCorrEvEjec = 3305
	SET @nombreTransaccion = 'SICARH_TRANSACCION'
	SET @registrosActualizados = 0
	
		IF NOT EXISTS (
		       SELECT *
		       FROM   DBO.EjecucionEventos AS ee
		       WHERE  ee.CodCorrEvEjec = @CodCorrEvEjec
		   )
		BEGIN
		    RAISERROR (
		        'NO EXISTE EL REGISTRO A SER ACTUALIZADO, POR FAVOR REVISE LA TRANSCRIPCION',
		        15,
		        10
		    )
		    GOTO HANDLE_ERROR
		END
		
		SELECT @cantidadRegistrosAfectado = COUNT(*)
		FROM   DBO.EjecucionEventos AS ee
		WHERE  EE.CodCorrEvEjec = @CodCorrEvEjec
				
		
		IF NOT EXISTS (
		       SELECT *
		       FROM   DBO.EjecucionEventos AS ee
		       WHERE  ee.CodCorrEvEjec = @CodCorrEvEjec
		              AND ee.InscripcionConsolidada = 'S'  -- cambiar a S		              
		   )
		BEGIN
		    RAISERROR (
		        'EL REGISTRO NO CUMPLE CON LOS REQUISITOS PARA SU MODIFICACION',
		        15,
		        10
		    )
		    GOTO HANDLE_ERROR 
		END		
		BEGIN TRANSACTION @nombreTransaccion
		
		UPDATE EjecucionEventos
		SET    InscripcionConsolidada = '-' -- ANTES S
		WHERE  CodCorrEvEjec = @COdCorrEvEjec
		
		SET @registrosActualizados = @@ROWCOUNT
		
		IF (@cantidadRegistrosAfectado <> @registrosActualizados)
		BEGIN
		    RAISERROR (
		        'NO SE PUDO REALIZAR LA ACTUALIZACIÓN POR NO CUMPLIR CON LOS RESULTADOS ESPERADO',
		        15,
		        10
		    )
		    GOTO ROLLBACK_FIN
		END
		
		COMMIT TRANSACTION @nombreTransaccion
		
		SELECT @cantidadRegistrosAfectado AS registrosActualizadosEsperdos,
		       @registrosActualizados AS RegistrosActualizados
	
		
		ROLLBACK_FIN:
		BEGIN
			
		
		IF @@TRANCOUNT > 0
				BEGIN			
		    ROLLBACK TRANSACTION @nombreTransaccion		
		    PRINT 'algo paso...!'    
				END
		END
	    HANDLE_ERROR:
		BEGIN
		SELECT @@ERROR AS codigo_error	
		END	
END 