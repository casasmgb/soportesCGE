--====================================================================================
	/*
	HOJA DE RUTA GNAF 4387/2018 SGSIR/761/2018   CENCAP/CI-757/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 30/11/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 03/12/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	select acceso_externo.correccionDatosNombres4672();
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.correccionDatosNombres4672() 
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
	total INTEGER;
	_mensaje CHARACTER VARYING(9000);
	_data_historico JSON;
	_err_Mensaje_detalle CHARACTER VARYING(8000);
	_obj_informacion_afectada public.objinformacion_afectada%rowtype;
BEGIN
	-- Tipo de dato de retorno
	SELECT	'',            -- inf_codigo VARCHAR(1000),
			'',            -- inf_complemento VARCHAR(1000),
			0,             -- err_existente INTEGER,
			'',            -- err_mensaje VARCHAR(1000),
			0              -- err_codigo INTEGER
	INTO _obj_informacion_afectada;
	my_var:=0;
	total:=0;
	
	--13.-	CE/CB-T36-921/2018
	--    	6559729   -   20181114_MLVFRY
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181114_MLVFRY'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.persona_preinscripcion', now(), 'Gabriel Casas M.', 'quitar apellido de esposo');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_esposo = '' --PIMENTEL
	WHERE perpre_codigo = '20181114_MLVFRY'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '13: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	total:=total+1;
	
	--25.-	CE/LP-T385-826/2018
	--    	7495506  -  20181107_AXIZTX
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181107_AXIZTX'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.persona_preinscripcion', now(), 'Gabriel Casas M.', 'CORRECCION DE NOMBRES');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'CAROL ANDREA' --CAROLANDREA
	WHERE perpre_codigo = '20181107_AXIZTX'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '25: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	total:=total+1;
	
	-- Retornamos los valores 
	_obj_informacion_afectada.inf_codigo		:= _mensaje;
	_obj_informacion_afectada.inf_complemento	:= 'SCRIPT FINALIZO';
	_obj_informacion_afectada.err_Existente		:= 0;
	_obj_informacion_afectada.err_Mensaje		:= _obj_informacion_afectada;
	_obj_informacion_afectada.err_codigo		:= total;
	RETURN NEXT _obj_informacion_afectada;
	
EXCEPTION
	WHEN transaction_rollback THEN
	BEGIN
		GET STACKED DIAGNOSTICS _obj_informacion_afectada.err_Codigo = RETURNED_SQLSTATE;                
		RAISE NOTICE 'Error actualizando datos :(%) ', _obj_informacion_afectada;                
                _obj_informacion_afectada.inf_codigo		:= -1;
                _obj_informacion_afectada.inf_complemento	:= 'error rollback';
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= _err_Mensaje;
                
		RETURN NEXT _obj_informacion_afectada;
	END;
			
	WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS _obj_informacion_afectada.err_Mensaje := MESSAGE_TEXT,
		_err_Mensaje_detalle := PG_EXCEPTION_CONTEXT;                
		RAISE NOTICE 'Error: (%)', _obj_informacion_afectada;                
		_obj_informacion_afectada.err_Existente		:= 1;
        _obj_informacion_afectada.inf_codigo		:= -1;
        _obj_informacion_afectada.inf_complemento	:= 'otro error';                
		RETURN NEXT _obj_informacion_afectada;
END;
$function$