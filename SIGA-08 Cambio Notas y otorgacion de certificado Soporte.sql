	SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion p WHERE p.procurcod_sigla='CE/LP-T236-455/2018' 	
	SELECT * FROM seguimiento_capacitacion.docente_criterios_evaluacion c WHERE c.procur_codigo=1162
	SELECT * FROM acceso_externo.persona_preinscripcion p 
	WHERE 
	p.perpre_numero_docidentidad='7918414' AND p.procur_codigo=1162
	--perpre_codigo: 20180620_ZCQIGR
	--per_codigo:    24699
	
	select * from seguimiento_capacitacion.personas_inscripcion where perpre_codigo = '20180620_ZCQIGR'
	SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e WHERE e.perpre_codigo='20180620_ZCQIGR'
	

	
	
-- REGISTRO DE NOTAS --------------------------------------------

	SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e WHERE e.perpre_codigo='20180620_ZCQIGR';

	INSERT INTO seguimiento_capacitacion.evaluacion_docente_personas_inscritas(
            --evadocperins_codigo, 
            evadocperins_calificaciones, evadocperins_nota_total, 
            evadocperins_estado, evadocperins_fecha_registro, evadocperins_usuario_base_datos, 
            per_codigo, perpre_codigo, asidoc_codigo, procur_codigo)
	VALUES (   
	'
	<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

		<row>
		  <doccrieva_codigo>1</doccrieva_codigo>
		  <doccrieva_descripcion>EVALUACION A</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>2</doccrieva_codigo>
		  <doccrieva_descripcion>EVALUACION B</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>3</doccrieva_codigo>
		  <doccrieva_descripcion>EVALUACION C</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>4</doccrieva_codigo>
		  <doccrieva_descripcion>EVALUACION D</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
		<row>
		  <doccrieva_codigo>5</doccrieva_codigo>
		  <doccrieva_descripcion>EVALUACION E</doccrieva_descripcion>
		  <doccrieva_ponderacion>20.00</doccrieva_ponderacion>
		  <calificacion>20.00</calificacion>
		</row>
		
	</table>


	', 
		100, 
        2, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        24699, 
        '20180620_ZCQIGR', 
        1, 
        1162
	);
	
	-- CREACION DE CERTIFICADO --------------------------------------------
	
	-- ultimo numero de certificado
	SELECT max(cc.codcer_numero::INTEGER)::CHARACTER VARYING
	--INTO _codcer_numero
	FROM seguimiento_capacitacion.codificacion_certificado AS cc
	WHERE cc.codcer_gestion = 2018;
	
		
	INSERT INTO seguimiento_capacitacion.codificacion_certificado(
	     codcer_numero,
	     codcer_gestion,
	     codcer_sigla,
	     codcer_estado,
	     codcer_fecha_registro,
	     codcer_usuario_base_datos
	)
	VALUES(
		(
		  SELECT COALESCE(max(cc.codcer_numero::INTEGER) +1 , 1::INTEGER)::CHARACTER VARYING						
		  FROM seguimiento_capacitacion.codificacion_certificado AS cc
		  WHERE cc.codcer_gestion = 2018 
		),
		2018,
		'CENCAP/CC',
		1,
		CURRENT_TIMESTAMP,
		SESSION_USER
	); --14455
	
	-- ASIGNACON DE CERTIFICADO --------------------------------------------
	
	--verificamos que se agrego el certificado
	select * from seguimiento_capacitacion.certificacion_persona c WHERE c.per_codigo=24699 AND c.codcer_numero='14455';

	--otorgar certificado a persona
	INSERT INTO seguimiento_capacitacion.certificacion_persona(
            per_codigo, perpre_codigo, cerper_nota_total, cerper_estado, 
            cerper_fecha_registro, cerper_usuario_base_datos, codcer_numero, 
            codcer_gestion, ran_codigo)
	VALUES (
    	24699, 
    	'20180620_ZCQIGR', 
    	100.00, --total_nota
    	1, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        '14455', 
        2018, 
        (  SELECT
           r.ran_codigo
           --INTO _ran_codigo
           FROM seguimiento_capacitacion.rangos r
           WHERE r.ran_estado = 1 AND
           80.00 BETWEEN r.ran_inicio AND r.ran_fin
        )
	);
	
	