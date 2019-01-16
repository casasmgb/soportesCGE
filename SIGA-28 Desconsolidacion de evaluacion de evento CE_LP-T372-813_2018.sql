
/*******************************************
 	HOJA DE RUTA GNAF/5236/2018
 	SGSIR/31/2019
	CENCAP-1782
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 10/01/2019
	MODIFICACION DE NOTAS
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 10/01/2019
	POR: LIC. GABRIEL CASAS MAMANI.
 * 
 *******************************************/
/*
-- VERIFICAR LOS REGISTROS.
select edpi.*, * from seguimiento_capacitacion.personas_inscripcion peri 
inner join acceso_externo.persona_preinscripcion pp
on peri.perpre_codigo = pp.perpre_codigo
inner join seguimiento_capacitacion.programacion_curso_codificacion pcc
on pp.procur_codigo = pcc.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on edpi.procur_codigo = pcc.procur_codigo and edpi.perpre_codigo = pp.perpre_codigo
where pcc.procurcod_sigla = 'CE/LP-T372-813/2018' 
*/

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
		   SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi 
		   WHERE edpi.evadocperins_estado = 2 
		   AND edpi.procur_codigo = 1522 
		   AND edpi.asidoc_codigo = 4
		   ) as t
	) as traza,
	'seguimiento_capacitacion.evaluacion_docente_personas_inscritas' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'desconsolidacion edicion de notas GNAF/5236/2018' as comentario_accion_realizada;

	UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
	SET
	evadocperins_estado = 1 --2
	WHERE edpi.evadocperins_estado = 2 AND edpi.procur_codigo = 1522 AND edpi.asidoc_codigo = 4;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 34	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% REGISTROS ACTUALIZADOS. ', _actualizados;
END
$$;
