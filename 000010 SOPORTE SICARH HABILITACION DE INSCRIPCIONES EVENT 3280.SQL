/*******************************************
 * NUMERO DE SOPORTE: 05956/2018
 * FUNCIONARIO: LAURA APAZA JOSE LUIS
 * DESCRIPCION:
 *       FAVOR, DESCONSOLIDAR INSCRIPCION DEL EVENTO "PRIMEROS AUXILIOS"
 * COD EV: 3291 
 * COD: 2G12G2763
 * TIPO DE EVENTO: CURSO 
 * 
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 23/07/2018
 * Base de datos: SSCRRHH
 * Verion Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 * Ejemplo de ejecucion:
 * EXEC dbo.spr_upd_desconsolidacion_evento_3291
 * 
 *******************************************/
CREATE  PROCEDURE dbo.spr_upd_desconsolidacion_evento_3291
AS
BEGIN
	DECLARE @cantidadRegistrosAfectado INT
	DECLARE @CodCorrEvEjec INT
	DECLARE @nombreTransaccion NVARCHAR(200)
	DECLARE @registrosActualizados INT
	SET @cantidadRegistrosAfectado = 0
	SET @CodCorrEvEjec = 3291
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
		              AND ee.InscripcionConsolidada = 'S'
		              
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