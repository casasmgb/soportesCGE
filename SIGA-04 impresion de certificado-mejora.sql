
--LUJAN MARAÑON NAIRA SAMANTHA con C.I. 4503794
--(07:16:34 p.m.) GUERRERO IRAHOLA JULIO CESAR  con CI: 5059381
--(07:16:57 p.m.) evento:CE/CB-T05-308/2018     -----del primero
--(07:17:09 p.m.) CE/LP-T106-242/2018      del segundo.


-- VARGAS SUBIRANA LIZNEY con C.I.5609537 del evento CE/LP-T70-177/2018-LEY N° 1178
-- per_codigo:: 16323
-- cur_codigo:: 251
--------------------------------------------------------------------------
	select * from seguimiento_capacitacion.curso where cur_codigo_sigla = 'D-26/CE/T-02/CUR-251'
	select * from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where procur_codigo = 1015

	SELECT * FROM seguimiento_capacitacion.programacion_curso where cur_codigo = 251 
	SELECT * FROM seguimiento_capacitacion.personas_inscripcion where per_codigo = 16323
	SELECT * FROM seguimiento_capacitacion.personas where per_docidentidad = '5609537'
	
	
	-- obtener el perpre_codigo y procur_codigo
	select * from acceso_externo.persona_preinscripcion p1, seguimiento_capacitacion.personas_inscripcion p2, seguimiento_capacitacion.programacion_curso sc
	where p1.perpre_numero_docidentidad ='5609537' and p2.per_codigo= 16323 and p1.perpre_codigo_preinscripcion = p2.perins_codigo_preinscripcion 
	and sc.procur_codigo = p1.procur_codigo and sc.cur_codigo=251
	
	-- perpre_codigo:: 20180409_UURBWG
	-- procur_codigo:: 884



	SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas

	select c.* from seguimiento_capacitacion.certificacion_persona c 
	JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas e ON c.perpre_codigo=e.perpre_codigo
	WHERE e.procur_codigo=884 and c.perpre_codigo='20180409_UURBWG'
			

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



SELECT * 
FROM seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas (
-1, -- _per_codigo INTEGER,
'', -- _perpre_codigo CHARACTER VARYING,
'', -- _perpre_codigo_preinscripcion CHARACTER VARYING,
'', -- criterio_busqueda CHARACTER VARYING,
948, -- _procur_codigo INTEGER,
-1, -- _asidoc_codigo INTEGER,
1 -- _reporte INTEGER
)



SELECT * 
FROM seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas (
18433, -- _per_codigo INTEGER,
'', -- _perpre_codigo CHARACTER VARYING,
'', -- _perpre_codigo_preinscripcion CHARACTER VARYING,
'', -- criterio_busqueda CHARACTER VARYING,
948, -- _procur_codigo INTEGER,
-1, -- _asidoc_codigo INTEGER,
1 -- _reporte INTEGER
)

select * from seguimiento_capacitacion.certificacion_persona where codcer_numero = '7393'
select * from seguimiento_capacitacion.personas_inscripcion where per_codigo = 18433
