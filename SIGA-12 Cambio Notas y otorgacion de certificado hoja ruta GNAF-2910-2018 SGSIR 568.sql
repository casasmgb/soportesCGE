--=================================================================================================================================
-- REGISTRO DE NOTAS --------------------------------------------

SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T190-387/2018'
SELECT * FROM acceso_externo.persona_preinscripcion p 
where p.perpre_apellido_paterno = 'BENAVIDES' and p.perpre_apellido_materno = 'VARGAS'  AND p.procur_codigo=1089
         
         
SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e WHERE e.perpre_codigo='20180629_XTIHPU';



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
	  <doccrieva_descripcion>TRABAJOS PRÃ�CTICOS</doccrieva_descripcion>
	  <doccrieva_ponderacion>27.00</doccrieva_ponderacion>
	  <calificacion>27.00</calificacion>
	</row>
	
	<row>
	  <doccrieva_codigo>2</doccrieva_codigo>
	  <doccrieva_descripcion>PARTICIPACIÃ“N EN FOROS</doccrieva_descripcion>
	  <doccrieva_ponderacion>2.00</doccrieva_ponderacion>
	  <calificacion>0.00</calificacion>
	</row>
	
	<row>
	  <doccrieva_codigo>3</doccrieva_codigo>
	  <doccrieva_descripcion>PARTICIPACIÃ“N EN SALA DE CHAT</doccrieva_descripcion>
	  <doccrieva_ponderacion>5.00</doccrieva_ponderacion>
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
	  <doccrieva_ponderacion>18.00</doccrieva_ponderacion>
	  <calificacion>18.00</calificacion>
	</row>
	
	</table>

	', 
		72, 
        2, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        11968, 
        '20180629_XTIHPU', 
        1, 
        1089
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
	); -- 16601
	
	-- ASIGNACON DE CERTIFICADO --------------------------------------------
	
	--verificamos que se agrego el certificado
	select * from seguimiento_capacitacion.certificacion_persona c WHERE c.per_codigo=11968 AND c.codcer_numero='16601'; --CAMBIAR

	--otorgar certificado a persona
	INSERT INTO seguimiento_capacitacion.certificacion_persona(
            per_codigo, 
            perpre_codigo, 
            cerper_nota_total, 
            cerper_estado, 
            cerper_fecha_registro, 
            cerper_usuario_base_datos, 
            codcer_numero, 
            codcer_gestion, 
            ran_codigo)
	VALUES (
    	11968, 
    	'20180629_XTIHPU', 
    	72.00, --total_nota
    	1, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        '16601',               --CAMBIAR
        2018, 
        (  SELECT
           r.ran_codigo
           --INTO _ran_codigo
           FROM seguimiento_capacitacion.rangos r
           WHERE r.ran_estado = 1 AND
           80.00 BETWEEN r.ran_inicio AND r.ran_fin
        )
	);
	

--=================================================================================================================================
-- REGISTRO DE NOTAS --------------------------------------------

SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T190-387/2018'
SELECT * FROM acceso_externo.persona_preinscripcion p 
where p.perpre_apellido_paterno = 'MOLINA' and p.perpre_apellido_materno = 'ASCARRUNZ'  AND p.procur_codigo=1089
         
         
SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e WHERE e.perpre_codigo='20180629_FLVJGS';



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
	  <doccrieva_descripcion>TRABAJOS PRÁCTICOS</doccrieva_descripcion>
	  <doccrieva_ponderacion>24.00</doccrieva_ponderacion>
	  <calificacion>27.00</calificacion>
	</row>
	
	<row>
	  <doccrieva_codigo>2</doccrieva_codigo>
	  <doccrieva_descripcion>PARTICIPACIÓN EN FOROS</doccrieva_descripcion>
	  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
	  <calificacion>0.00</calificacion>
	</row>
	
	<row>
	  <doccrieva_codigo>3</doccrieva_codigo>
	  <doccrieva_descripcion>PARTICIPACIÓN EN SALA DE CHAT</doccrieva_descripcion>
	  <doccrieva_ponderacion>10.00</doccrieva_ponderacion>
	  <calificacion>5.00</calificacion>
	</row>
	
	<row>
	  <doccrieva_codigo>4</doccrieva_codigo>
	  <doccrieva_descripcion>PRIMER PARCIAL</doccrieva_descripcion>
	  <doccrieva_ponderacion>16.00</doccrieva_ponderacion>
	  <calificacion>20.00</calificacion>
	</row>
	
	<row>
	  <doccrieva_codigo>5</doccrieva_codigo>
	  <doccrieva_descripcion>SEGUNDO PARCIAL</doccrieva_descripcion>
	  <doccrieva_ponderacion>15.00</doccrieva_ponderacion>
	  <calificacion>18.00</calificacion>
	</row>
	
	</table>

	', 
		75, 
        2, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        19549, 
        '20180629_FLVJGS', 
        1, 
        1089
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
	); -- 16603
	
	-- ASIGNACON DE CERTIFICADO --------------------------------------------
	
	--verificamos que se agrego el certificado
	select * from seguimiento_capacitacion.certificacion_persona c WHERE c.per_codigo=19549 AND c.codcer_numero='16603'; --CAMBIAR

	--otorgar certificado a persona
	INSERT INTO seguimiento_capacitacion.certificacion_persona(
            per_codigo, 
            perpre_codigo, 
            cerper_nota_total, 
            cerper_estado, 
            cerper_fecha_registro, 
            cerper_usuario_base_datos, 
            codcer_numero, 
            codcer_gestion, 
            ran_codigo)
	VALUES (
    	19549, 
    	'20180629_FLVJGS', 
    	75.00, --total_nota
    	1, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        '16603',               --CAMBIAR
        2018, 
        (  SELECT
           r.ran_codigo
           --INTO _ran_codigo
           FROM seguimiento_capacitacion.rangos r
           WHERE r.ran_estado = 1 AND
           80.00 BETWEEN r.ran_inicio AND r.ran_fin
        )
	);
	
	