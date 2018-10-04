
--LUJAN MARAÑON NAIRA SAMANTHA con C.I. 4503794
--(07:16:34 p.m.) GUERRERO IRAHOLA JULIO CESAR  con CI: 5059381
--(07:16:57 p.m.) evento:CE/CB-T05-308/2018     -----del primero
--(07:17:09 p.m.) CE/LP-T106-242/2018      del segundo.

--------------------------------------------------------------------------
	select c.* from seguimiento_capacitacion.certificacion_persona c 
	JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas e ON c.perpre_codigo=e.perpre_codigo
	WHERE e.procur_codigo=1015 and c.perpre_codigo='20180606_CBGCDX'
			

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
	);--8483
		
		
--------------------------------------------------------------------------
	select * from seguimiento_capacitacion.certificacion_persona c WHERE c.per_codigo=20399 AND c.codcer_numero='14176'

					
	INSERT INTO seguimiento_capacitacion.certificacion_persona(
            per_codigo, perpre_codigo, cerper_nota_total, cerper_estado, 
            cerper_fecha_registro, cerper_usuario_base_datos, codcer_numero, 
            codcer_gestion, ran_codigo)
	VALUES (
    	20399, 
    	'20180606_CBGCDX', 
    	97.00, --total_nota
    	1, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        '14176',--codcer_numero 
        2018, 
        (  SELECT
           r.ran_codigo
           --INTO _ran_codigo
           FROM seguimiento_capacitacion.rangos r
           WHERE r.ran_estado = 1 AND
           97.00 BETWEEN r.ran_inicio AND r.ran_fin
        )
	);
	
--==============================================================================

	select c.* from seguimiento_capacitacion.certificacion_persona c 
	JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas e ON c.perpre_codigo=e.perpre_codigo
	WHERE e.procur_codigo=948 and c.perpre_codigo='20180425_BMAGRP'
			

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
	);--8483
		
		
--------------------------------------------------------------------------
	select * from seguimiento_capacitacion.certificacion_persona c WHERE c.per_codigo=18433 AND c.codcer_numero='14177'

					
	INSERT INTO seguimiento_capacitacion.certificacion_persona(
            per_codigo, perpre_codigo, cerper_nota_total, cerper_estado, 
            cerper_fecha_registro, cerper_usuario_base_datos, codcer_numero, 
            codcer_gestion, ran_codigo)
	VALUES (
    	18433, 
    	'20180425_BMAGRP', 
    	71.00, --total_nota
    	1, 
        CURRENT_TIMESTAMP, 
        SESSION_USER, 
        '14177',--codcer_numero 
        2018, 
        (  SELECT
           r.ran_codigo
           --INTO _ran_codigo
           FROM seguimiento_capacitacion.rangos r
           WHERE r.ran_estado = 1 AND
           71.00 BETWEEN r.ran_inicio AND r.ran_fin
        )
	);