CREATE TABLE seguimiento_capacitacion.historico_directrices_cursos(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(150),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria_dc PRIMARY KEY (id)
);

/*
	NUMERO DE SOPORTE: 00042/2019
	DE: LIC. ALVARO EDGAR CORDOVA CHAVEZ
	FECHA REMICION DE HR: 08/01/2019
	DESCONSOLIDAR DIRECTRIZ (MALLA) CON CODIGO D-37
	SISTEMA:SIGA
	FECHA EJECUCION: 08/01/2019
	POR: LIC. GABRIEL CASAS MAMANI.
*/
DO $$
DECLARE 
_actualizados INTEGER;
BEGIN
		
	insert into seguimiento_capacitacion.historico_directrices_cursos 
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT
	(
		SELECT
			array_to_json ( array_agg ( row_to_json ( t ) ) )
	    FROM (
		   	select * from seguimiento_capacitacion.curso AS c 
			WHERE c.dir_codigo = 39 and c.cur_estado = 2
		   ) as t
	) as traza,
	'seguimiento_capacitacion.curso' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'desconsolidacion curso' as comentario_accion_realizada;
	
	insert into seguimiento_capacitacion.historico_directrices_cursos 
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT
	(
		SELECT
			array_to_json ( array_agg ( row_to_json ( t ) ) )
	    FROM (
		   	select * from seguimiento_capacitacion.curso_prerequisito AS cp
			WHERE cp.cur_codigo_curso IN (
				SELECT c.cur_codigo
				FROM seguimiento_capacitacion.directrices AS d
				INNER JOIN seguimiento_capacitacion.curso AS c
					ON d.dir_codigo = c.dir_codigo
				WHERE d.dir_codigo = 39) and cp.curpre_estado = 2
		   ) as t
	) as traza,
	'seguimiento_capacitacion.curso_prerequisito' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'desconsolidacion curso_prerequisito' as comentario_accion_realizada;
	
	insert into seguimiento_capacitacion.historico_directrices_cursos 
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT
	(
		SELECT
			array_to_json ( array_agg ( row_to_json ( t ) ) )
	    FROM (
		   	select * from seguimiento_capacitacion.competencias_basicas_curso AS cbc 
			WHERE cbc.cur_codigo IN (
				SELECT c.cur_codigo
				FROM seguimiento_capacitacion.directrices AS d
				INNER JOIN seguimiento_capacitacion.curso AS c
					ON d.dir_codigo = c.dir_codigo
				WHERE d.dir_codigo = 39) and cbc.combascur_estado = 2
		   ) as t
	) as traza,
	'seguimiento_capacitacion.competencias_basicas_curso' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'desconsolidacion competencias_basicas_curso' as comentario_accion_realizada;
	
	
	UPDATE seguimiento_capacitacion.curso AS c
	SET
		cur_estado = 1
	WHERE c.dir_codigo = 39 AND c.cur_estado = 2;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 8	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% REGISTROS ACTUALIZADOS EN CURSO. ', _actualizados;
					
	UPDATE seguimiento_capacitacion.curso_prerequisito AS cp
	SET
		curpre_estado = 1
	WHERE cp.cur_codigo_curso IN (
		SELECT c.cur_codigo
		FROM seguimiento_capacitacion.directrices AS d
		INNER JOIN seguimiento_capacitacion.curso AS c
		ON d.dir_codigo = c.dir_codigo
		WHERE d.dir_codigo = 39) and cp.curpre_estado = 2;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 9	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% REGISTROS ACTUALIZADOS EN CURSO PREREQUISITOS. ', _actualizados;
				
	UPDATE seguimiento_capacitacion.competencias_basicas_curso AS cbc
	SET
		combascur_estado = 1
	WHERE cbc.cur_codigo IN (
		SELECT c.cur_codigo
		FROM seguimiento_capacitacion.directrices AS d
		INNER JOIN seguimiento_capacitacion.curso AS c
		ON d.dir_codigo = c.dir_codigo
		WHERE d.dir_codigo = 39) and cbc.combascur_estado = 2;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 8	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% REGISTROS ACTUALIZADOS EN COMPETENCIAS BASICAS CURSO. ', _actualizados;
END
$$;

-- select * from seguimiento_capacitacion.historico_directrices_cursos
