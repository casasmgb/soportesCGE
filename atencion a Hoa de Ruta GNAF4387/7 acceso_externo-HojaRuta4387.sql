--7.-	CE/LP-T388-858/2018
--		5963141
DO $$
DECLARE 
my_var INTEGER;
_data_historico json;
begin
	
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '5963141' and  pp.perpre_codigo = '20181004_RNYKID'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico,' acceso_externo.historico_participantes', now(), 'Gabriel Casas M.', 'actualizar nombre');
	 
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'NICOLE VIVIANA'		--NICOLE VIVIAANA
	WHERE perpre_numero_docidentidad = '5963141' 
	and  perpre_codigo = '20181004_RNYKID';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '7 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF;

END
$$;
