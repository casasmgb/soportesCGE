--5.-	MU/SC-T41-792/2018
--		7737021
DO $$
DECLARE 
my_var INTEGER;
_data_historico json;
begin
	
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '7737021' and  pp.perpre_codigo = '20180926_WMSGGW'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico,' acceso_externo.historico_participantes', now(), 'Gabriel Casas M.', 'actualizar nombre');
	 
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_materno = 'VACA'		--CAVA
	WHERE perpre_numero_docidentidad = '7737021' 
	and  perpre_codigo = '20180926_WMSGGW';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '5 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF; 

END
$$;
