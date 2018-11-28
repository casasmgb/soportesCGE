/*
 * cambiar ci de 2394260-LP  a  2394260
 * en el curso:  CE/LP-T376-817/2018
 * datos:   Hugo Gonzalo Urquidi Cardenas
 * 
 * Base de datos: siga_soportes
 */

/*
	--Buscar sus datos
select	p.perpre_codigo , *		
FROM acceso_externo.persona_preinscripcion p
INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
ON p.procur_codigo = pcc.procur_codigo 
WHERE pcc.procurcod_sigla = 'CE/LP-T376-817/2018' 
AND p.perpre_numero_docidentidad = '2394260-LP'
*/


select	p.perpre_codigo, pcc.procur_codigo, *		
FROM acceso_externo.persona_preinscripcion p
INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
ON p.procur_codigo = pcc.procur_codigo 
WHERE pcc.procurcod_sigla = 'CE/LP-T376-817/2018' 
AND p.perpre_numero_docidentidad = '2394260-LP'

select * from seguimiento_capacitacion.personas where per_docidentidad like '%2394260%'

DO $$
DECLARE 
my_var INTEGER;
_data_historico json;
_new_pass CHARACTER VARYING(50);
_old_ci  CHARACTER VARYING(10);
_new_ci  CHARACTER VARYING(10);
_perpre_codigo CHARACTER VARYING(20);
_procur_codigo INTEGER;
_comentario CHARACTER VARYING(200);
_funcionario CHARACTER VARYING(50);
_tabla CHARACTER VARYING(150);
_paterno CHARACTER VARYING(50);
_materno CHARACTER VARYING(50);
_per_codigopersona CHARACTER VARYING(20);

begin
	
	_old_ci:= '2394260-LP';
	_new_ci:= '2394260';
	_paterno:='URQUIDI';
	_materno:='CARDENAS';
	_per_codigopersona:='UCH2394260';
	_perpre_codigo:='20181015_NJJWZZ';
	_procur_codigo:=1526;
	
	--4.-	CE/LP-T376-817/2018
	--		2394260
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo = _perpre_codigo
	) row1;
	raise notice '_data_historico %', _data_historico;
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.cuenta_persona_inscripcion', now(), 'Gabriel Casas M.', 'Cambio contraseña');
	 
	_new_pass := (select public.fn_encriptar_cadena(_new_ci));
	
	UPDATE acceso_externo.cuenta_persona_inscripcion
	SET cueperins_contrasenia = _new_pass
 	WHERE perpre_codigo = _perpre_codigo;
 	GET DIAGNOSTICS my_var := ROW_COUNT;
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN   
		raise notice '#ERROR AL MOMENTO DE ACTUALIZAR PW.';
		RAISE EXCEPTION transaction_rollback;
	END IF;
	
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.procur_codigo=_procur_codigo 
		AND pp.perpre_codigo = _perpre_codigo
	) row1;
	raise notice '_data_historico %', _data_historico;
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.cuenta_persona_inscripcion', now(), 'Gabriel Casas M.', 'Cambio de CI');
	
	UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad=_new_ci	                                      			
        WHERE pp.procur_codigo=_procur_codigo 
       	AND pp.perpre_numero_docidentidad=_old_ci 
       	AND pp.perpre_apellido_paterno = _paterno
		AND pp.perpre_apellido_materno = _materno
		AND pp.perpre_codigo = _perpre_codigo;
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var := ROW_COUNT;
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN   
		raise notice '#ERROR AL MOMENTO DE ACTUALIZAR CI.';
		RAISE EXCEPTION transaction_rollback;
	END IF; 
	
	SELECT row_to_json (row1) INTO _data_historico 
	FROM (
	    SELECT * FROM seguimiento_capacitacion.personas p WHERE p.per_docidentidad= _old_ci
	    AND p.per_appaterno = _paterno 
	    AND p.per_apmaterno = _materno
	) row1;
	raise notice '_data_historico %', _data_historico;
	INSERT INTO seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico,'seguimiento_capacitacion.personas' ,now(), 'Gabriel Casas M.', 'Cambio de CI');
	 	
	UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = _new_ci,
			per_codigopersona=_per_codigopersona
	        WHERE p.per_docidentidad=_old_ci 
	        AND p.per_appaterno = _paterno 
	        AND p.per_apmaterno = _materno;
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN
			raise notice 'Transaccion Roll Back';
			RAISE EXCEPTION transaction_rollback;
		END IF ;
END
$$;