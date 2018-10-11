
--====================================================================================
	/*
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA CREACION: 10/10/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.changeCI(procurcod_sigla character varying, docidentidad_old character varying, i_per_appaterno character varying, i_per_apmaterno character varying, docidentidad_new character VARYING, nro_registros INTEGER)  
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
	_docidentidad_old CHARACTER VARYING(30);
	_docidentidad_new CHARACTER VARYING(30);
	_nro_registros_a_afectar INTEGER;
	_per_codigopersona CHARACTER VARYING(30);
	_new_per_codigopersona VARCHAR(30);
	_procur_codigo INTEGER;
	_procurcod_sigla CHARACTER VARYING(30);
	
	_err_Mensaje CHARACTER VARYING(1000);
	_mensaje CHARACTER VARYING(1000);
	_err_Mensaje_detalle CHARACTER VARYING(8000);
	_obj_informacion_afectada public.objinformacion_afectada%rowtype;
	_obj_informacion_afectada_externo public.objinformacion_afectada%rowtype;
BEGIN
	-- Tipo de dato de retorno
	SELECT	'',            -- inf_codigo VARCHAR(1000),
			'',            -- inf_complemento VARCHAR(1000),
			0,             -- err_existente INTEGER,
			'',            -- err_mensaje VARCHAR(1000),
			0              -- err_codigo INTEGER
	INTO _obj_informacion_afectada;
	SELECT	'',            -- inf_codigo VARCHAR(1000),
			'',            -- inf_complemento VARCHAR(1000),
			0,             -- err_existente INTEGER,
			'',            -- err_mensaje VARCHAR(1000),
			0              -- err_codigo INTEGER
	INTO _obj_informacion_afectada_externo;


	 my_var:= 0;
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
	_nro_registros_a_afectar := nro_registros;
	_procurcod_sigla := procurcod_sigla;
 	
	SELECT pcc.procur_codigo INTO _procur_codigo FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc
	WHERE pcc.procurcod_sigla=_procurcod_sigla;
	IF NOT FOUND THEN
    	_obj_informacion_afectada.inf_codigo		:= 'NO SE ENCONTRO EL CURSO';
		_obj_informacion_afectada.inf_complemento	:= _procurcod_sigla;
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= '';
		_obj_informacion_afectada.err_codigo		:= 0;
		RETURN NEXT _obj_informacion_afectada;
	END IF;
	
		-- LLAMAR A ACCESO EXTERNO
	select acceso_externo.changeCI(_procur_codigo, _docidentidad_old, i_per_appaterno, i_per_apmaterno, _docidentidad_new, _nro_registros_a_afectar) INTO _obj_informacion_afectada_externo;
	if _obj_informacion_afectada_externo.err_Existente != 0 then
		RAISE EXCEPTION transaction_rollback;
		_obj_informacion_afectada.inf_codigo		:= 'Roll back llamada a acceso_externo.spr_desvincular_cuenta_participante';
		_obj_informacion_afectada.inf_complemento	:= _docidentidad_old;
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= '';
		_obj_informacion_afectada.err_codigo		:= 0;
		RETURN NEXT _obj_informacion_afectada;
	end if;
	
	IF EXISTS (SELECT * FROM seguimiento_capacitacion.personas p WHERE p.per_docidentidad = _docidentidad_old) THEN
		SELECT per_codigopersona into _per_codigopersona FROM seguimiento_capacitacion.personas p
 		WHERE p.per_docidentidad LIKE _docidentidad_old  AND per_appaterno = i_per_appaterno AND per_apmaterno = i_per_apmaterno;
 		-- REEMPLAZAR CI Y CODIGOPERSONA
	 	select REPLACE (_per_codigopersona, _docidentidad_old, _docidentidad_new) into _new_per_codigopersona;
	 
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = _docidentidad_new,
			per_codigopersona=_new_per_codigopersona
	        WHERE p.per_docidentidad=_docidentidad_old AND per_appaterno = i_per_appaterno AND per_apmaterno = i_per_apmaterno;
		/*--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != _nro_registros_a_afectar 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;
		*/ 
	ELSE
		RAISE NOTICE '======>CI NO SE ENCONTRO'; 
		_obj_informacion_afectada.inf_codigo		:= _docidentidad_old;
		_obj_informacion_afectada.inf_complemento	:= 'NO SE ENCONTRO EL DOCUMENTO DE IDENTIDAD-EXTERNO';
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= '';
		_obj_informacion_afectada.err_codigo		:= 0;
		RETURN NEXT _obj_informacion_afectada;
	END	IF; 
 	
    -- Retornamos los valores 
	_obj_informacion_afectada.inf_codigo		:= _new_per_codigopersona;
	_obj_informacion_afectada.inf_complemento	:= _docidentidad_new;
	_obj_informacion_afectada.err_Existente		:= 0;
	_obj_informacion_afectada.err_Mensaje		:= _obj_informacion_afectada_externo.err_Mensaje;
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
  
  