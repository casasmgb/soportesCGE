DO $$
DECLARE 
_actualizados INTEGER;
BEGIN
		
	insert into seguimiento_capacitacion.historico_participantes 
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT
	(
		SELECT
			array_to_json ( array_agg ( row_to_json ( t ) ) )
	    FROM (
		   SELECT * FROM seguimiento_capacitacion.docente_criterios_evaluacion 
		   where asidoc_codigo = 1 and procur_codigo = 1604
		   ) as t
	) as traza,
	'seguimiento_capacitacion.evaluacion_docente_personas_inscritas' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'cambio de estados y correccion de tipo base de calificacion' as comentario_accion_realizada;

	update seguimiento_capacitacion.docente_criterios_evaluacion 
	set procalbascal_codigo = 1,
		doccrieva_estado = 0 --2
	where asidoc_codigo = 1 and procur_codigo = 1604;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 1 THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% registros actualizados.',_actualizados;
	
END
$$;