--1.-	CE/LP-T273-504/2018
--		6062848
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
_perpre_nombres CHARACTER VARYING(50);
_per_codigopersona CHARACTER VARYING(20);

begin
	
	_old_ci:= '6062848';
	_new_ci:= '6062848';
	_paterno:='VARGAS';
	_materno:='QUISBERT';
	_perpre_nombres:='LORENA PACESA';
	_per_codigopersona:='VQL6062848';
	_perpre_codigo:='20180822_EQFGHY';
	_procur_codigo:=1211;
	_funcionario:='Gabriel Casas';
	
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = _old_ci and  pp.perpre_codigo = _perpre_codigo
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico,' acceso_externo.historico_participantes', now(), 'Gabriel Casas M.', 'actualizar nombre');
	 
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = _perpre_nombres --LORENAPACESA
	WHERE perpre_numero_docidentidad = _old_ci 
	and  perpre_codigo = _perpre_codigo;
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '1 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF; 

END
$$;
