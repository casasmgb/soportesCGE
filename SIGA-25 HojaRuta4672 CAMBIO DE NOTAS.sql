--====================================================================================
		/*
	HOJA DE RUTA GNAF 4672/2018 SGSIR/792/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 30/11/2018
	MODIFICAR DATOS DE NOTAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 30/11/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
/*
-- Ejecutar con usuario si no existiera la tabla: USRACADEMICO 
CREATE TABLE seguimiento_capacitacion.historico_participantes(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(150),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria PRIMARY KEY (id)
);
-- VERIFICAR LOS REGISTROS.
select edpi.*, * from seguimiento_capacitacion.personas_inscripcion peri 
inner join acceso_externo.persona_preinscripcion pp
on peri.perpre_codigo = pp.perpre_codigo
inner join seguimiento_capacitacion.programacion_curso_codificacion pcc
on pp.procur_codigo = pcc.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on edpi.procur_codigo = pcc.procur_codigo and edpi.perpre_codigo = pp.perpre_codigo
where pcc.procurcod_sigla = 'CE/LP-T270-500/2018' 
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
		   AND edpi.procur_codigo = 1208 
		   AND edpi.asidoc_codigo = 1
		   ) as t
	) as traza,
	'seguimiento_capacitacion.evaluacion_docente_personas_inscritas' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'desconsolidacion edicion de notas' as comentario_accion_realizada;
	
	
	UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
	SET
	evadocperins_estado = 1 --2
	WHERE edpi.evadocperins_estado = 2 AND edpi.procur_codigo = 1208 AND edpi.asidoc_codigo = 1;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 38	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	_actualizados :=0;
	
	INSERT INTO seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT(
		select array_to_json (array_agg (row_to_json (t)))
	    from(
			select * from seguimiento_capacitacion.certificacion_persona where perpre_codigo = '20180703_XOYBWF'
		    ) as t
	) as traza,
	'seguimiento_capacitacion.certificacion_persona' as tabla,
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'Borrado logico de el registro de certificado generado de la inscripcion' as comentario_accion_realizada;
	
	update seguimiento_capacitacion.certificacion_persona
	set cerper_estado =0
	where perpre_codigo = '20180703_XOYBWF';
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 1	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
END
$$;

-- select * from seguimiento_capacitacion.historico_participantes


select * from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where perpre_codigo = '20180703_XOYBWF' or perpre_codigo = '20180703_LXOAYC'
