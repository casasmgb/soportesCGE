--====================================================================================
	/*
	HOJA DE RUTA GNAF/5191/2018 SGSIR/842/2018
	CENCAP/CI-806/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 26/12/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 27/12/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	select acceso_externo.correccionDatosNombres5191();
	drop function acceso_externo.correccionDatosNombres5191() 
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.correccionDatosNombres5191() 
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
	
	--13.-  CE/OR-T12-590/2018
    --		7339601    -    20180803_YNMTEM
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20180803_YNMTEM'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.persona_preinscripcion', now(), 'Gabriel Casas M.', 'CORRECCION DE APELLIDOS');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'MACHACA', --DAVALOS
		perpre_apellido_materno = 'DAVALOS'  --MACHACA
	WHERE perpre_codigo = '20180803_YNMTEM'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '13: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	total:=total+1;
	--14.-  CE/OR-T12-590/2018
    --		3110685    20180803_HYMIMP
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20180803_HYMIMP'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.persona_preinscripcion', now(), 'Gabriel Casas M.', 'CORRECCION DE APELLIDOS');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'TRONCONI', --DELGADILLO
		perpre_apellido_materno = 'DELGADILLO'  --TRONCONI
	WHERE perpre_codigo = '20180803_HYMIMP'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '14: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	total:=total+1;
	--19.-  CE/LP-T427-937/2018
    --		5970486
    SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181114_VDSQRC'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.persona_preinscripcion', now(), 'Gabriel Casas M.', 'CORRECCION DE APELLIDOS');
	
	UPDATE acceso_externo.persona_preinscripcion
   	set
   		perpre_nombres = 'DELMIRA', --MACHACA
		perpre_apellido_paterno = 'MACHACA', --MAMANI
		perpre_apellido_materno = 'MAMANI'  --DELMIRA
	WHERE perpre_codigo = '20181114_VDSQRC'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '19: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	total:=total+1;
	--22.-  CE/LP-T367-801/2018
    --		2696980
    SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181029_LTFNMD'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.persona_preinscripcion', now(), 'Gabriel Casas M.', 'CORRECCION DE DEPARTAMENTO EXPEDICION');
	
	UPDATE acceso_externo.persona_preinscripcion
   	set
   		dep_codigo_expedicion = 2 --3
	WHERE perpre_codigo = '20181029_LTFNMD'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '22: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	total:=total+1;
	
	--30.-  CE/LP-T93-231/2017
    --		6944320
	select acceso_externo.changeCI(231, '6944320-LP', 'TORREZ', 'CORI', '6944320', 1) INTO _obj_informacion_afectada;
	if _obj_informacion_afectada.err_Existente != 0 then
		raise notice 'Roll back llamada a acceso_externo.changeCI';
		RAISE EXCEPTION transaction_rollback;
	end if;
	total:=total+1;
	--32.-  MU/LP-T28-756/2018
    --		6061571
    SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181025_ODZYTB'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'acceso_externo.persona_preinscripcion', now(), 'Gabriel Casas M.', 'CORRECCION DE NOMBRES');
	
	UPDATE acceso_externo.persona_preinscripcion
   	set
   		perpre_nombres = 'EDDY ARIEL' --ADDY ARIEL
	WHERE perpre_codigo = '20181025_ODZYTB'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '22: % ', my_var;
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