--====================================================================================
	/*
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA CREACION: 10/10/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.changeCI(procur_codigo integer, docidentidad_old character varying, i_per_appaterno character varying, i_per_apmaterno character varying, docidentidad_new character varying, nro_registros INTEGER) 
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
	my_var_pass INTEGER;
	_err_Mensaje CHARACTER VARYING(1000);
	_mensaje CHARACTER VARYING(1000);
	_err_Mensaje_detalle CHARACTER VARYING(8000);
	_new_pass CHARACTER VARYING(50);
	_perpre_codigo CHARACTER VARYING(30);
	_procur_codigo INTEGER;
	_docidentidad_old CHARACTER VARYING(30);
	_docidentidad_new CHARACTER VARYING(30);
	_nro_registros_a_afectar INTEGER;
	_obj_informacion_afectada public.objinformacion_afectada%rowtype;
BEGIN
	-- Tipo de dato de retorno
	SELECT	'',            -- inf_codigo VARCHAR(1000),
			'',            -- inf_complemento VARCHAR(1000),
			0,             -- err_existente INTEGER,
			'',            -- err_mensaje VARCHAR(1000),
			0              -- err_codigo INTEGER
	INTO _obj_informacion_afectada;
	
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
	_nro_registros_a_afectar := nro_registros;
	_procur_codigo:=procur_codigo;
	-- perpre_codigo del participante que esta inscrito

		SELECT p.perpre_codigo INTO _perpre_codigo
		FROM acceso_externo.persona_preinscripcion p 
		WHERE p.perpre_numero_docidentidad = _docidentidad_old 
		AND p.perpre_estado = 3
		AND p.perpre_apellido_paterno = i_per_appaterno
		AND p.perpre_apellido_materno = i_per_apmaterno
		AND p.procur_codigo = _procur_codigo;

	RAISE NOTICE 'perpre_codigo: % ', _perpre_codigo;
	
	_new_pass := (select public.fn_encriptar_cadena(_docidentidad_new));
	RAISE NOTICE 'cambiando contraseña por: % ', _new_pass;
	
	UPDATE acceso_externo.cuenta_persona_inscripcion
	SET cueperins_contrasenia = _new_pass
 	WHERE perpre_codigo = _perpre_codigo;
 	IF NOT FOUND THEN
		_err_Mensaje := '#ERROR AL MOMENTO DE ACTUALIZAR LA CAMBIO DE PASSWORD.';
        RAISE EXCEPTION transaction_rollback; 
	END IF; 
 
	UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad=_docidentidad_new	                                      			
        WHERE pp.procur_codigo=_procur_codigo 
       	AND pp.perpre_numero_docidentidad=_docidentidad_old AND pp.perpre_apellido_paterno = i_per_appaterno
		AND pp.perpre_apellido_materno = i_per_apmaterno;
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var := ROW_COUNT;
	-- si no es lo esperado , hacer un rollback
	IF my_var != _nro_registros_a_afectar	THEN   
		_err_Mensaje := '#ERROR AL MOMENTO DE ACTUALIZAR CI.';
		RAISE EXCEPTION transaction_rollback;
	END IF; 
			
	--seteando la variable
	my_var:= 0;
	RAISE NOTICE 'ci: % cambiado por: %', _docidentidad_old, _docidentidad_new;
		        -- Retornamos los valores 
	_obj_informacion_afectada.inf_codigo		:= _docidentidad_old;
	_obj_informacion_afectada.inf_complemento	:= _docidentidad_new;
	_obj_informacion_afectada.err_Existente		:= 0;
	_obj_informacion_afectada.err_Mensaje		:= _new_pass;
	_obj_informacion_afectada.err_codigo		:= 0;
	RETURN NEXT _obj_informacion_afectada;
	
EXCEPTION
	WHEN transaction_rollback THEN
	BEGIN
		GET STACKED DIAGNOSTICS _obj_informacion_afectada.err_Codigo = RETURNED_SQLSTATE;                
		RAISE NOTICE 'Error de validacion :(%) ', _err_Mensaje;                
                _obj_informacion_afectada.inf_codigo		:= -1;
                _obj_informacion_afectada.inf_complemento	:= 'error rollback';
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= _err_Mensaje;
                
		RETURN NEXT _obj_informacion_afectada;
	END;
			
	WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS _obj_informacion_afectada.err_Mensaje := MESSAGE_TEXT,
		_err_Mensaje_detalle := PG_EXCEPTION_CONTEXT;                
		RAISE NOTICE 'Error: (%), Detalle: [%] ', _obj_informacion_afectada, _err_Mensaje_detalle;                
		_obj_informacion_afectada.err_Existente		:= 1;
        _obj_informacion_afectada.inf_codigo		:= -1;
        _obj_informacion_afectada.inf_complemento	:= 'otro error';                
		RETURN NEXT _obj_informacion_afectada;
	
END;
$function$
  
  