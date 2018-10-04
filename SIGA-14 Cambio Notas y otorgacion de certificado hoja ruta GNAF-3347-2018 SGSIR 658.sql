--====================================================================================
	/*
	HOJA DE RUTA GNAF 3347/2018 SGSIR/628/2018
	
	CENCAP/CI-583/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 14/09/2018
	MODIFICAR CALIFICACIONES Y OTORGAR CERTIFICADO EN EL SISTEMA SIGA
	SISTEMA:SIGA
	FECHA EJECUCION: 19/09/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
--====================================================================================
-- ACTUALIZACION DE NOTAS --------------------------------------------

SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T304-538/2018'
SELECT * FROM acceso_externo.persona_preinscripcion p 
where p.perpre_apellido_paterno = 'GONZALES' and p.perpre_apellido_materno = 'BRETON' AND p.procur_codigo=1258
         
         
SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e WHERE e.perpre_codigo='20180719_RRRYIH';
-- per_codigo = 16838
-- evadocperins_codigo = 39514

	--PARA EJECUTAR
	update seguimiento_capacitacion.evaluacion_docente_personas_inscritas
	set
	evadocperins_calificaciones = '
		<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
		
		<row>
		  <doccrieva_codigo>1</doccrieva_codigo>
		  <doccrieva_descripcion>ELABORACIÓN DE 2 TRABAJO PRÁCTICOS</doccrieva_descripcion>
		  <doccrieva_ponderacion>30.00</doccrieva_ponderacion>
		  <calificacion>24.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>2</doccrieva_codigo>
		  <doccrieva_descripcion>PARTICIPACION EN 2 FOROS DEBATE</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>11.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>3</doccrieva_codigo>
		  <doccrieva_descripcion>PARTICIPACION EN LA SALA DE CHAT</doccrieva_descripcion>
		  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
		  <calificacion>8.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>4</doccrieva_codigo>
		  <doccrieva_descripcion>PRIMERA EVALUACIÓN EN LÍNEA</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>5</doccrieva_codigo>
		  <doccrieva_descripcion>SENGUNDA EVALUACIÓN EN LÍNEA</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
	</table>
	',
	evadocperins_nota_total = 83.00
	
	where evadocperins_codigo = 39514 and procur_codigo = 1258 and perpre_codigo = '20180719_RRRYIH'
	
	-- ACTUALIZAR LOS DATOS DEL CERTIFICADO
	select * from seguimiento_capacitacion.certificacion_persona where per_codigo =16838 and perpre_codigo = '20180719_RRRYIH' and codcer_numero = '17186'
	
	
	--PARA EJECUTAR
	update seguimiento_capacitacion.certificacion_persona 
	set cerper_nota_total = 83.00
	where per_codigo =16838 and perpre_codigo = '20180719_RRRYIH' and codcer_numero = '17186'
	
	
--====================================================================================
-- ACTUALIZACION DE NOTAS --------------------------------------------

SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T304-538/2018'
SELECT * FROM acceso_externo.persona_preinscripcion p 
where p.perpre_apellido_paterno = 'GONZALES' and p.perpre_apellido_materno = 'SOLANO'  AND p.procur_codigo=1258
         
         
SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e WHERE e.perpre_codigo='20180723_MCCUGG';
-- 1109
-- evadocperins_codigo = 39514

	--PARA EJECUTAR
	update seguimiento_capacitacion.evaluacion_docente_personas_inscritas
	set
	evadocperins_calificaciones = '
	<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
		
		<row>
		  <doccrieva_codigo>1</doccrieva_codigo>
		  <doccrieva_descripcion>ELABORACIÓN DE 2 TRABAJO PRÁCTICOS</doccrieva_descripcion>
		  <doccrieva_ponderacion>30.00</doccrieva_ponderacion>
		  <calificacion>24.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>2</doccrieva_codigo>
		  <doccrieva_descripcion>PARTICIPACION EN 2 FOROS DEBATE</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>14.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>3</doccrieva_codigo>
		  <doccrieva_descripcion>PARTICIPACION EN LA SALA DE CHAT</doccrieva_descripcion>
		  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
		  <calificacion>4.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>4</doccrieva_codigo>
		  <doccrieva_descripcion>PRIMERA EVALUACIÓN EN LÍNEA</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>15.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>5</doccrieva_codigo>
		  <doccrieva_descripcion>SENGUNDA EVALUACIÓN EN LÍNEA</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>14.00</calificacion>
		</row>
		
	</table>
	', 
	evadocperins_nota_total = 71.00
	where evadocperins_codigo = 39513 and procur_codigo = 1258 and perpre_codigo = '20180723_MCCUGG'
	
	
	-- ACTUALIZAR LOS DATOS DEL CERTIFICADO
	select * from seguimiento_capacitacion.certificacion_persona where per_codigo =1109 and perpre_codigo = '20180723_MCCUGG' and codcer_numero = '17185'
	
	
	-- PARA EJECUTAR
	update seguimiento_capacitacion.certificacion_persona 
	set cerper_nota_total = 71.00
	where per_codigo =1109 and perpre_codigo = '20180723_MCCUGG' and codcer_numero = '17185'	
	
	