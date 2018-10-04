/*******************************************
 * NUMERO DE SOPORTE: 05956/2018
 * FUNCIONARIO: LAURA APAZA JOSE LUIS
 * DESCRIPCION:
 *       FAVOR, ASIGNAR ESTADO DE CONSOLIDADO A FUNCIONARIOS: CARLOS MOLINA CABRERA Y 
 *       CAUDIA PEÑALOZA BALDERAMA   DEL EVENTO "PRIMEROS AUXILIOS"
 * COD EJECUCION: 3291 
 * COD: 2G12G2763
 * TIPO DE EVENTO: SEMINARIO 
 * 
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 24/07/2018
 * Base de datos: SSCRRHH
 * Verion Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 * Ejemplo de ejecucion:
 * EXEC dbo.spr_abandono_consolidado_3291_1195
 * 
 *******************************************/
CREATE PROCEDURE dbo.spr_abandono_consolidado_3291_1195
AS
BEGIN
	DECLARE @cantidadRegistrosAfectado INT
	DECLARE @CodCorrEvEjec INT
	DECLARE @nombreTransaccion NVARCHAR(200)
	DECLARE @registrosActualizados INT
	DECLARE @codCorrPer INT
	DECLARE @CodEstadoOrigen NVARCHAR(10)
	DECLARE @CodEstadoDestino NVARCHAR(10)
	DECLARE @cantidadTransacciones INT
	
	
	SET @cantidadRegistrosAfectado = 0
	SET @CodCorrEvEjec = 3291
	SET @nombreTransaccion = 'SICARH_TRANSACCION'
	SET @registrosActualizados = 0
	SET @codCorrPer = 1195
	SET @CodEstadoOrigen = 'INA'
	SET @CodEstadoDestino = 'INC'
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
	FROM   DBO.Alumnos AS a
	WHERE  A.CodCorrEvEjec = @CodCorrEvEjec
	       AND A.CodCorrPer = @codCorrPer
	
	
	IF NOT EXISTS (
	       SELECT *
	       FROM   DBO.EjecucionEventos AS ee
	       WHERE  ee.CodCorrEvEjec = @CodCorrEvEjec
	              AND ee.InscripcionConsolidada = 'S'
	              AND ee.CalificacionesConsolidadas = 'S'
	   )
	BEGIN
	    RAISERROR (
	        'EL REGISTRO NO CUMPLE CON LOS REQUISITOS PARA SU MODIFICACION',
	        15,
	        10
	    )
	    GOTO HANDLE_ERROR
	END
	
	IF NOT EXISTS (
	       SELECT *
	       FROM   DBO.Alumnos AS a
	       WHERE  a.CodCorrEvEjec = @CodCorrEvEjec AND 
	       a.CodCorrPer = @codCorrPer AND a.CodEstado = @CodEstadoOrigen
	              
	   )
	BEGIN
	    RAISERROR (
	        'EL REGISTRO NO CUMPLE CON LOS REQUISITOS PARA SU MODIFICACION RESPECTIVA',
	        15,
	        10
	    )
	    GOTO HANDLE_ERROR
	END
	
	BEGIN TRANSACTION @nombreTransaccion
	
	UPDATE a
	SET    a.CodEstado = @CodEstadoDestino,	--antes INC,
	       a.Asistencia = 100,	--antes era 0
	       a.AprobadoReprobado = 'A' --antes era -
	FROM   Alumnos a
	       INNER JOIN Personas p
	            ON  p.CodCorrPer = a.CodCorrPer
	WHERE  a.CodCorrEvEjec = @CodCorrEvEjec
	       AND a.CodEstado = @CodEstadoOrigen
	       AND a.codcorrper = @codCorrPer
	
	
	
	SET @registrosActualizados = @@ROWCOUNT
	
	IF (@cantidadRegistrosAfectado <> @registrosActualizados)
	BEGIN
	    RAISERROR (
	        'NO SE PUDO REALIZAR LA ACTUALIZACIÓN POR NO CUMPLIR CON LOS RESULTADOS ESPERADOS',
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