USE [SSCRRHH]
GO
/****** Object:  StoredProcedure [dbo].[spr_upd_desconsolidacion_evento_3291]    Script Date: 07/24/2018 17:01:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*******************************************
 * NUMERO DE SOPORTE: 06555/2018
 * FUNCIONARIO: LAURA APAZA JOSE LUIS
 * DESCRIPCION:
 *       CAMBIO DE CONYUGUE EN EL NOMBRE DE 'VELASCO' A ''
 * CODCORRPER: 1527 
 * DOCIDE:  4647714
 *
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 12/09/2018
 * Base de datos: SSCRRHH
 * Verion Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 * Ejemplo de ejecucion:
 * EXEC dbo.spr_upd_cambio_conyugue
 * 
 *******************************************/

CREATE PROCEDURE [dbo].[spr_upd_cambio_conyugue]
AS
BEGIN
	DECLARE @cantidadRegistrosAfectado INT
	DECLARE @CodCorrPer INT    --@CodCorrEvEjec
	DECLARE @nombreTransaccion NVARCHAR(200)
	DECLARE @DocIde NVARCHAR(10)
	DECLARE @Conyugue NVARCHAR(50)
	DECLARE @registrosActualizados INT
	SET @cantidadRegistrosAfectado = 0
	SET @CodCorrPer = 1527
	SET @DocIde = '4647714'
	SET @Conyugue = ''
	SET @nombreTransaccion = 'SICARH_TRANSACCION'
	SET @registrosActualizados = 0
	
		IF NOT EXISTS (
		       SELECT *
		       FROM   DBO.Personas AS p
		       WHERE  p.CodCorrPer = @CodCorrPer
		              AND p.DocIde = @DocIde
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
		FROM   DBO.Personas AS p
		WHERE  p.CodCorrPer = @CodCorrPer
			   AND p.DocIde = @DocIde
				
		
		IF NOT EXISTS (
		       SELECT *
		       FROM   DBO.Personas AS p
		       WHERE  p.CodCorrPer = @CodCorrPer
		              AND p.DocIde = @DocIde
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
		
		UPDATE Personas
		SET    Conyuge = @Conyugue -- VELASCO
		WHERE  CodCorrPer = @CodCorrPer
		
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