--perpre_codigo = 20181023_EVZHTA
--fac_codigo = 438699

-- HITORICO seguimiento_capacitacion.facturas_persona_inscripcion
	INSERT INTO seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT(
		select array_to_json (array_agg (row_to_json (t)))
	    from(
			select * from seguimiento_capacitacion.facturas_persona_inscripcion f where f.perpre_codigo IN ('20181023_EVZHTA' )
		    ) as t
	) as traza,
	'seguimiento_capacitacion.facturas_persona_inscripcion' as tabla,
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'factura  34719 - Borrar la asociacion de inscripcion' as comentario_accion_realizada;
	
-- HITORICO seguimiento_capacitacion.facturas
	INSERT INTO seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT(
		select array_to_json (array_agg (row_to_json (t)))
	    from(
			select * from seguimiento_capacitacion.facturas where fac_codigo = 438699
		    ) as t
	) as traza,
	'seguimiento_capacitacion.facturas' as tabla,
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'factura  34719 - actualizar el saldo' as comentario_accion_realizada;
	
-- HITORICO seguimiento_capacitacion.personas_inscripcion
	INSERT INTO seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT(
		select array_to_json (array_agg (row_to_json (t)))
	    from(
			SELECT * FROM seguimiento_capacitacion.personas_inscripcion pe WHERE pe.perpre_codigo IN ( '20181023_EVZHTA' )
		    ) as t
	) as traza,
	'seguimiento_capacitacion.personas_inscripcion' as tabla,
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'factura  34719 - borrar la inscripcion' as comentario_accion_realizada;

-- HITORICO acceso_externo.cuenta_persona_inscripcion
	INSERT INTO  acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT(
		select array_to_json (array_agg (row_to_json (t)))
	    from(
			SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo IN ( '20181023_EVZHTA' )
		    ) as t
	) as traza,
	'acceso_externo.cuenta_persona_inscripcion' as tabla,
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'factura  34719 - borrar la cuenta para la inscripcion' as comentario_accion_realizada;

-- HITORICO acceso_externo.persona_preinscripcion
	INSERT INTO  acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT(
		select array_to_json (array_agg (row_to_json (t)))
	    from(
			select * from acceso_externo.persona_preinscripcion pe WHERE pe.perpre_codigo IN   ('20181023_EVZHTA') and pe.perpre_estado = 3
		    ) as t
	) as traza,
	'acceso_externo.persona_preinscripcion' as tabla,
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'factura  34719 - actualizar el estado de la inscripcion eliminada' as comentario_accion_realizada;

	
