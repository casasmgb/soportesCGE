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
--====================================================================================
-- ACTUALIZACION DE NOTAS --------------------------------------------

SELECT edpi.evadocperins_codigo, edpi.per_codigo, pcc.procur_codigo, edpi.evadocperins_calificaciones, edpi.evadocperins_nota_total, edpi.perpre_codigo , * 
FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
inner join acceso_externo.persona_preinscripcion as pp
on pcc.procur_codigo=pp.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on pp.perpre_codigo = edpi.perpre_codigo
WHERE pcc.procurcod_sigla='CE/LP-T197-394/2018' and pp.perpre_apellido_paterno = 'YAÑZ' and pp.perpre_apellido_materno = 'CORNEJO'

	--PARA EJECUTAR
	update seguimiento_capacitacion.evaluacion_docente_personas_inscritas
	set
	evadocperins_calificaciones = '
		<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<row>
			  <doccrieva_codigo>1</doccrieva_codigo>
			  <doccrieva_descripcion>FOROS</doccrieva_descripcion>
			  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
			  <calificacion>10.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>2</doccrieva_codigo>
			  <doccrieva_descripcion>CHATS</doccrieva_descripcion>
			  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
			  <calificacion>20.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>3</doccrieva_codigo>
			  <doccrieva_descripcion>TRABAJOS</doccrieva_descripcion>
			  <doccrieva_ponderacion>30.00</doccrieva_ponderacion>
			  <calificacion>30.00</calificacion>
			</row>
			
			<row>
			  <doccrieva_codigo>4</doccrieva_codigo>
			  <doccrieva_descripcion>EXAMENES</doccrieva_descripcion>
			  <doccrieva_ponderacion>40.00</doccrieva_ponderacion>
			  <calificacion>35.00</calificacion>
			</row>
			
		</table>
	',
	evadocperins_nota_total = 95.00
	where evadocperins_codigo = 46954 and procur_codigo = 1101 and perpre_codigo = '20180626_BCQGDN'
	
	-- ACTUALIZAR LOS DATOS DEL CERTIFICADO
	select * from seguimiento_capacitacion.certificacion_persona where per_codigo =16557 and perpre_codigo = '20180626_BCQGDN' and codcer_numero = '24098'
	
	--PARA EJECUTAR
	update seguimiento_capacitacion.certificacion_persona 
	set cerper_nota_total = 95.00
	where per_codigo =16557 and perpre_codigo = '20180626_BCQGDN' and codcer_numero = '24098'
	
	
--====================================================================================
-- ACTUALIZACION DE NOTAS --------------------------------------------

SELECT edpi.evadocperins_codigo, edpi.per_codigo, pcc.procur_codigo, edpi.evadocperins_calificaciones, edpi.evadocperins_nota_total, edpi.perpre_codigo , * 
FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
inner join acceso_externo.persona_preinscripcion as pp
on pcc.procur_codigo=pp.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on pp.perpre_codigo = edpi.perpre_codigo
WHERE pcc.procurcod_sigla='CE/LP-T197-394/2018' and pp.perpre_apellido_paterno = 'MURILLO' and pp.perpre_apellido_materno = 'TORREZ'


	--PARA EJECUTAR
	update seguimiento_capacitacion.evaluacion_docente_personas_inscritas
	set
	evadocperins_calificaciones = '
	<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
		<row>
		  <doccrieva_codigo>1</doccrieva_codigo>
		  <doccrieva_descripcion>FOROS</doccrieva_descripcion>
		  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
		  <calificacion>10.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>2</doccrieva_codigo>
		  <doccrieva_descripcion>CHATS</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>3</doccrieva_codigo>
		  <doccrieva_descripcion>TRABAJOS</doccrieva_descripcion>
		  <doccrieva_ponderacion>30.00</doccrieva_ponderacion>
		  <calificacion>30.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>4</doccrieva_codigo>
		  <doccrieva_descripcion>EXAMENES</doccrieva_descripcion>
		  <doccrieva_ponderacion>40.00</doccrieva_ponderacion>
		  <calificacion>39.00</calificacion>
		</row>
	
	</table>
	',
	evadocperins_nota_total = 99.00
	where evadocperins_codigo = 46936 and procur_codigo = 1101 and perpre_codigo = '20180612_MEZTKD'
	
	-- ACTUALIZAR LOS DATOS DEL CERTIFICADO
	select * from seguimiento_capacitacion.certificacion_persona where per_codigo =3160 and perpre_codigo = '20180612_MEZTKD' and codcer_numero = '24080'
	
	--PARA EJECUTAR
	update seguimiento_capacitacion.certificacion_persona 
	set cerper_nota_total = 99.00
	where per_codigo =3160 and perpre_codigo = '20180612_MEZTKD' and codcer_numero = '24080'
	
