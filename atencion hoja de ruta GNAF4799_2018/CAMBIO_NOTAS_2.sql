--====================================================================================
	/*
	HOJA DE RUTA GNAF/4790/2018 SGSIR/813/2018
	CENCAP/CI-766/2018
	DE: LIC. PAOLA BURGOA BELTRAN
	FECHA REMICION DE HR: 06/12/2018
	MODIFICAR DATOS DE NOTAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 06/12/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
/*
 * VERIFICAR Y OBTENER DATOS
 
SELECT edpi.evadocperins_codigo, edpi.per_codigo, pcc.procur_codigo, edpi.evadocperins_calificaciones, edpi.evadocperins_nota_total, edpi.perpre_codigo , * 
FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
inner join acceso_externo.persona_preinscripcion as pp
on pcc.procur_codigo=pp.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on pp.perpre_codigo = edpi.perpre_codigo
WHERE pcc.procurcod_sigla='CE/CB-T11-564/2018' and pp.perpre_apellido_paterno = 'MONTERO' and pp.perpre_apellido_materno = 'LAZARTE'
--=================
select * from seguimiento_capacitacion.certificacion_persona where per_codigo =21525 and perpre_codigo = '20180807_OVDNKW' and codcer_numero = '23152'
--=================
*/

DO $$
DECLARE 
_registros INTEGER;
_data_historico json;
	--PARA EJECUTAR
begin
	insert into seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	 SELECT
	 (
	       SELECT
		    array_to_json ( array_agg ( row_to_json ( t ) ) )
	       FROM (
		     SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas 
		     where evadocperins_codigo = 45858 
		     and procur_codigo = 1217 
		     and perpre_codigo = '20180807_OVDNKW'
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
			  <doccrieva_descripcion>TRABAJO PR�CTICO 1</doccrieva_descripcion>
			  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
			  <calificacion>8.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>2</doccrieva_codigo>
			  <doccrieva_descripcion>TRABAJO PRACTICO 2</doccrieva_descripcion>
			  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
			  <calificacion>7.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>3</doccrieva_codigo>
			  <doccrieva_descripcion>TRABAJO PRACTICO 3</doccrieva_descripcion>
			  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
			  <calificacion>9.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>4</doccrieva_codigo>
			  <doccrieva_descripcion>EVALUACI�N 1</doccrieva_descripcion>
			  <doccrieva_ponderacion>24.00</doccrieva_ponderacion>
			  <calificacion>24.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>5</doccrieva_codigo>
			  <doccrieva_descripcion>TRABAJO PRACTICO 4</doccrieva_descripcion>
			  <doccrieva_ponderacion>6.00</doccrieva_ponderacion>
			  <calificacion>5.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>6</doccrieva_codigo>
			  <doccrieva_descripcion>EVALUACI�N FINAL</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>20.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>7</doccrieva_codigo>
			  <doccrieva_descripcion>TRABAJO PRACTICO 5</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>15.00</calificacion>
			</row>
		</table>

	',
	evadocperins_nota_total = 88.00
	where evadocperins_codigo = 45858 and procur_codigo = 1217 and perpre_codigo = '20180807_OVDNKW';
	GET DIAGNOSTICS _registros = ROW_COUNT;	
	IF _registros != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% REGISTROS ACTUALIZADOS PARA NOTAS', _registros;
	_registros:=0;
	--ACTUALIZAR DATOS DE CERTIFICADO.
	insert into seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	 SELECT
	 (
	       SELECT
		    array_to_json (array_agg(row_to_json(t)))
	       FROM (
		     SELECT * FROM seguimiento_capacitacion.certificacion_persona 
		     where per_codigo =21525 and perpre_codigo = '20180807_OVDNKW' and codcer_numero = '23152'
		    ) AS t
	 ) as traza,
	 'seguimiento_capacitacion.evaluacion_docente_personas_inscritas ' as tabla,
	 now() as fecha_ejecucion, 
	 'Gabriel Casas' as funcionario_sgsir_responsable, 
	 'actualizar nota para certificado' as comentario_accion_realizada;	
	
	update seguimiento_capacitacion.certificacion_persona 
	set cerper_nota_total = 88.00
	-- agregar la competenci alcanzada
	where per_codigo =21525 and perpre_codigo = '20180807_OVDNKW' and codcer_numero = '23152';
	GET DIAGNOSTICS _registros = ROW_COUNT;	
	IF _registros != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% REGISTROS ACTUALIZADOS PARA CERTIFICADO', _registros;
END
$$;	