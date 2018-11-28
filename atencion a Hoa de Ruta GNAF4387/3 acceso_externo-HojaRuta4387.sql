--3.-	CE/LP-T202-399/2018
--		3290423
DO $$
DECLARE 
my_var INTEGER;
_data_historico json;
_old_ci  CHARACTER VARYING(10);
_new_ci  CHARACTER VARYING(10);
_perpre_codigo CHARACTER VARYING(20);

begin
	
	_old_ci:= '3290423';
	_new_ci:= '3290423';
	_perpre_codigo:='20180622_CUDMQP';
	
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = _old_ci and  pp.perpre_codigo = _perpre_codigo
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza,tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(),' acceso_externo.historico_participantes', 'Gabriel Casas M.', 'actualizar nombre');
	 
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'BALLESTERO', --ANTELO
		perpre_apellido_materno = 'ANTELO'		--BALLESTERO
	WHERE perpre_numero_docidentidad = '3290423' 
	and  perpre_codigo = '20180622_CUDMQP';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '3 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF; 

END
$$;
