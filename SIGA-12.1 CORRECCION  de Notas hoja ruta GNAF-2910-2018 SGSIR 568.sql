-- DATOS DE LA PERSONA AFECTADA
SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T190-387/2018'

SELECT * FROM acceso_externo.persona_preinscripcion p 
where p.perpre_apellido_paterno = 'BENAVIDES' and p.perpre_apellido_materno = 'VARGAS'  AND p.procur_codigo=1089

SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e where procur_codigo = 1089 and e.perpre_codigo='20180629_XTIHPU';
     
-- per_codigo = 11968
-- evadocperins_codigo = 39000 (ERRADA)
-- evadocperins_codigo = 36664 (MODIFICAR POR EL CORRECTO)
    
-- ELIMINAMOS LA CALIFICAION ERRADA.
DELETE FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas
WHERE evadocperins_codigo = 39000;

--MODIFICAMOS LA NOTA CORRECTA 
	update seguimiento_capacitacion.evaluacion_docente_personas_inscritas
	set
	evadocperins_calificaciones = '
		<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			
			<row>
			  <doccrieva_codigo>1</doccrieva_codigo>
			  <doccrieva_descripcion>TRABAJOS PRÁCTICOS</doccrieva_descripcion>
			  <doccrieva_ponderacion>30.00</doccrieva_ponderacion>
			  <calificacion>27.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>2</doccrieva_codigo>
			  <doccrieva_descripcion>PARTICIPACIÓN EN FOROS</doccrieva_descripcion>
			  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
			  <calificacion>2.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>3</doccrieva_codigo>
			  <doccrieva_descripcion>PARTICIPACIÓN EN SALA DE CHAT</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>5.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>4</doccrieva_codigo>
			  <doccrieva_descripcion>PRIMER PARCIAL</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>20.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>5</doccrieva_codigo>
			  <doccrieva_descripcion>SEGUNDO PARCIAL</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>18.00</calificacion>
			</row>
			
		</table>
	',
	evadocperins_nota_total = 72.00,
	evadocperins_estado = 2
	where evadocperins_codigo = 36664 and procur_codigo = 1089 and perpre_codigo = '20180629_XTIHPU';
	
-- 	EL CERTIFICADO SE MANTIENE SOLO ES NECESARIO CAMBIAR LA NOTA.
	select * from seguimiento_capacitacion.certificacion_persona where per_codigo =11968 and perpre_codigo = '20180629_XTIHPU' and codcer_numero = '16601'