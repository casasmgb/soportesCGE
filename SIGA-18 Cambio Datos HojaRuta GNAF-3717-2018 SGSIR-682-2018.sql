CREATE OR REPLACE FUNCTION seguimiento_capacitacion.correcionDatos()  
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	_mensaje CHARACTER VARYING(9000);
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
	
	--1.-  	CE/LP-T332-630/2018
	--		3463897
	
	--2.-	
	--3.-
	--4.-	MU/LP-T24-750/2018
	--		6951257
	
	--5.-	CE/LP-T348-742/2018
	--		4803416
	--6.-	CE/LP-T30-109/2018
	--		8250161
	--7.-	CE/LP-T230-439/2018
	--		5749440
	--8.-
	--
	--9.-	CE/LP-T363-794/2018
	--		6734268
	--10.-
	--
	    -- Retornamos los valores 
	_obj_informacion_afectada.inf_codigo		:= _err_Mensaje_detalle;
	_obj_informacion_afectada.inf_complemento	:= 'TODOS LOS DATOS ACTUALIZADOS';
	_obj_informacion_afectada.err_Existente		:= 0;
	_obj_informacion_afectada.err_Mensaje		:= _obj_informacion_afectada.err_Mensaje;
	_obj_informacion_afectada.err_codigo		:= 0;
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