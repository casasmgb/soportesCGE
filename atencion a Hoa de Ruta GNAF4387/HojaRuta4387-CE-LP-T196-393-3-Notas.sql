--====================================================================================
	/*
	HOJA DE RUTA GNAF 4387/2018 SGSIR/761/2018
	CENCAP/CI-712/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 15/11/2018
	MODIFICAR DATOS DE NOTAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 20/11/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
/*
 -- Ejecutar con usuario: USRACADEMICO
CREATE TABLE seguimiento_capacitacion.historico_participantes(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(150),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria PRIMARY KEY (id)
);


 -- VERIFICAR Y OBTENER DATOS
SELECT edpi.evadocperins_codigo, edpi.per_codigo, pcc.procur_codigo, edpi.evadocperins_calificaciones, edpi.evadocperins_nota_total, edpi.perpre_codigo , * 
FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
inner join acceso_externo.persona_preinscripcion as pp
on pcc.procur_codigo=pp.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on pp.perpre_codigo = edpi.perpre_codigo
WHERE pcc.procurcod_sigla='CE/LP-T196-393/2018' and pp.perpre_apellido_paterno = 'PORTILLO' and pp.perpre_apellido_materno = 'MAMANI'
--=================
select * from seguimiento_capacitacion.certificacion_persona where per_codigo =16528 and perpre_codigo = '20180629_RYELUX' and codcer_numero = '24080'
*/
/*
 * ************CREAR HISTORICO
-- Ejecutar con usuario: USRACADEMICO
CREATE TABLE seguimiento_capacitacion.historico_participantes(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(150),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria PRIMARY KEY (id)
);
 */
DO $$
DECLARE 
_registros INTEGER;
_data_historico json;
begin
	--PARA EJECUTAR
	insert into seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	 SELECT
	 (
	       SELECT
		    array_to_json (array_agg(row_to_json(t)))
	       FROM (
		     SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas 
		     where evadocperins_codigo = 46140 and procur_codigo = 1100 and perpre_codigo = '20180629_RYELUX'
		    ) AS t
	 ) as traza,
	 'seguimiento_capacitacion.evaluacion_docente_personas_inscritas ' as tabla,
	 now() as fecha_ejecucion, 
	 'Gabriel Casas' as funcionario_sgsir_responsable, 
	 'actualizar notas' as comentario_accion_realizada;	

	update seguimiento_capacitacion.evaluacion_docente_personas_inscritas
	set
	evadocperins_calificaciones = '
	<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
		<row>
		  <doccrieva_codigo>1</doccrieva_codigo>
		  <doccrieva_descripcion>CHAT</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>2</doccrieva_codigo>
		  <doccrieva_descripcion>TRABAJO</doccrieva_descripcion>
		  <doccrieva_ponderacion>30.00</doccrieva_ponderacion>
		  <calificacion>30.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>3</doccrieva_codigo>
		  <doccrieva_descripcion>FORO</doccrieva_descripcion>
		  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
		  <calificacion>10.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>4</doccrieva_codigo>
		  <doccrieva_descripcion>EXAMEN N° 1</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>18.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>5</doccrieva_codigo>
		  <doccrieva_descripcion>EXAMEN N° 2</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
	</table>
	',
	evadocperins_nota_total = 98.00
	where evadocperins_codigo = 46140 and procur_codigo = 1100 and perpre_codigo = '20180629_RYELUX';
	GET DIAGNOSTICS _registros = ROW_COUNT;	
	IF _registros != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--ACTUALIZAR DATOS DE CERTIFICADO.
	insert into seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	 SELECT
	 (
	       SELECT
		    array_to_json (array_agg(row_to_json(t)))
	       FROM (
		     SELECT * FROM seguimiento_capacitacion.certificacion_persona 
		     where per_codigo =16528 and perpre_codigo = '20180629_RYELUX' and codcer_numero = '23334'
		    ) AS t
	 ) as traza,
	 'seguimiento_capacitacion.evaluacion_docente_personas_inscritas ' as tabla,
	 now() as fecha_ejecucion, 
	 'Gabriel Casas' as funcionario_sgsir_responsable, 
	 'actualizar nota para certificado' as comentario_accion_realizada;	
	
	update seguimiento_capacitacion.certificacion_persona 
	set cerper_nota_total = 98.00
	where per_codigo =16528 and perpre_codigo = '20180629_RYELUX' and codcer_numero = '23334';
	GET DIAGNOSTICS _registros = ROW_COUNT;	
	IF _registros != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
END
$$;
