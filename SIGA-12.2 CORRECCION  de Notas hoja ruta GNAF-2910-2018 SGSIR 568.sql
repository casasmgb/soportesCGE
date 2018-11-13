-- DATOS DE LA PERSONA AFECTADA
SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T190-387/2018'

SELECT * FROM acceso_externo.persona_preinscripcion p 
where p.perpre_apellido_paterno = 'MOLINA' and p.perpre_apellido_materno = 'ASCARRUNZ'  AND p.procur_codigo=1089;

SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e where procur_codigo = 1089 and e.perpre_codigo='20180629_FLVJGS';

-- per_codigo = 19549
-- evadocperins_codigo = 39001 (ERRADA)
-- evadocperins_codigo = 36677 (MODIFICAR POR EL CORRECTO)
    
-- ELIMINAMOS LA CALIFICAION ERRADA.
DELETE FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas
WHERE evadocperins_codigo = 39001;

--MODIFICAMOS LA NOTA CORRECTA 
	UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas
	SET
	evadocperins_calificaciones = '
		<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			
			<row>
			  <doccrieva_codigo>1</doccrieva_codigo>
			  <doccrieva_descripcion>TRABAJOS PRÁCTICOS</doccrieva_descripcion>
			  <doccrieva_ponderacion>30.00</doccrieva_ponderacion>
			  <calificacion>24.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>2</doccrieva_codigo>
			  <doccrieva_descripcion>PARTICIPACIÓN EN FOROS</doccrieva_descripcion>
			  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
			  <calificacion>10.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>3</doccrieva_codigo>
			  <doccrieva_descripcion>PARTICIPACIÓN EN SALA DE CHAT</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>10.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>4</doccrieva_codigo>
			  <doccrieva_descripcion>PRIMER PARCIAL</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>16.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>5</doccrieva_codigo>
			  <doccrieva_descripcion>SEGUNDO PARCIAL</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>15.00</calificacion>
			</row>
			
		</table>
	',
	evadocperins_nota_total = 75.00,
	evadocperins_estado = 2
	where evadocperins_codigo = 36677 and procur_codigo = 1089 and perpre_codigo = '20180629_FLVJGS'

-- 	EL CERTIFICADO SE MANTIENE SOLO ES NECESARIO CAMBIAR LA NOTA.
	select * from seguimiento_capacitacion.certificacion_persona where per_codigo =19549 and perpre_codigo = '20180629_FLVJGS' and codcer_numero = '16602'	
	
	
	