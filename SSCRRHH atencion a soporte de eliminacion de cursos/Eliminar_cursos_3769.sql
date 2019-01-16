/*******************************************
 * Nro soporte: 07547/2018
 * Solicitante: Jose Luis Laura Apaza
 * Descripcion: 
 * SISTEMAS Por favor, Eliminar el evento "PROGRAMA DE TELECONFERENCIAS POLITICAS PUBLICAS"
 * Codigo Ejecucion: 3769 
 * Codigo: 4G12G2995 
 * 
 * Autor: Gabriel Casas
 * Fecha: 11/01/2018
 * Base de datos: SSCRRHH
 * Version Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 * Ejemplo de ejecucion:
 * EXEC dbo.spr_eliminacion_evento_3769
 * drop PROCEDURE dbo.spr_eliminacion_evento_3769 
 *******************************************/
CREATE PROCEDURE dbo.spr_eliminacion_evento_3769
AS
BEGIN
	DECLARE @cantidadRegistrosAfectado INT
	DECLARE @CodCorrEvEjec INT
	DECLARE @nombreTransaccion NVARCHAR(200)
	DECLARE @registrosActualizados INT
	DECLARE @CodEstadoOrigen NVARCHAR(10)
	DECLARE @CodEstadoDestino NVARCHAR(10)
	DECLARE @cantidadTransacciones INT
	
	SET @cantidadRegistrosAfectado = 0
	SET @CodCorrEvEjec = 3769
	SET @nombreTransaccion = 'SICARH_TRANSACCION'
	SET @registrosActualizados = 0	
	SET @CodEstadoOrigen = 'EJA'
	SET @CodEstadoDestino = 'EJN'
	SET @cantidadTransacciones = 0	
	
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
	              AND ee.CodEstado = @CodEstadoOrigen
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
	SET    CodEstado         = @CodEstadoDestino -- anulado con EJN antes estaba en  EJA
	WHERE  CodCorrEvEjec     = @CodCorrEvEjec
	       AND CodEstado     = @CodEstadoOrigen
	SET @registrosActualizados = @@ROWCOUNT
	
	IF (@cantidadRegistrosAfectado <> @registrosActualizados)
	BEGIN
	    RAISERROR (
	        'NO SE PUDO REALIZAR LA ACTUALIZACION POR NO CUMPLIR CON LOS RESULTADOS ESPERADOS',
	        15,
	        10
	    )
	    GOTO ROLLBACK_FIN
	END
	
	SET @cantidadTransacciones = @cantidadTransacciones + @registrosActualizados
		
	SELECT @cantidadRegistrosAfectado = COUNT(*)
	FROM   dbo.Alumnos AS a
	WHERE  A.CodCorrEvEjec= @CodCorrEvEjec
	
	UPDATE Alumnos
	SET    CodCorrEvEjec = -@CodCorrEvEjec
	WHERE  CodCorrEvEjec = @CodCorrEvEjec;
	SET @registrosActualizados = @@ROWCOUNT
	
	IF (@cantidadRegistrosAfectado <> @registrosActualizados)
	BEGIN
	    RAISERROR (
	        'NO SE PUDO REALIZAR LA ACTUALIZACION POR NO CUMPLIR CON LOS RESULTADOS ESPERADOS',
	        15,
	        10
	    )
	    GOTO ROLLBACK_FIN
	END

	SET @cantidadTransacciones = @cantidadTransacciones + @registrosActualizados
	
	COMMIT TRANSACTION @nombreTransaccion
	SELECT @cantidadTransacciones AS RegistrosActualizados
	       ROLLBACK_FIN:
	BEGIN
		IF @@TRANCOUNT > 0
		BEGIN
		    ROLLBACK TRANSACTION @nombreTransaccion
		END
	END
	HANDLE_ERROR:
	BEGIN
		SELECT @@ERROR AS codigo_error
	END
END
