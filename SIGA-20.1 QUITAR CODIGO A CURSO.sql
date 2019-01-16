--====================================================================================
	/*
	QUITAR CODIGO DE PREINSCRIPCION A UN CURSO
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA CREACION: 16/01/2019
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUCION:
	SELECT * from seguimiento_capacitacion.tmp_mantenimiento_quitar_codigo_curso('CE/LP-T27-028/2019')  
	*/
--====================================================================================
	
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.tmp_mantenimiento_quitar_codigo_curso(procurcod_sigla character varying)  
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
	_procur_codigo INTEGER;
	_procurcod_sigla CHARACTER VARYING(30);
	
	_rows_afected INTEGER;
	_err_Mensaje CHARACTER VARYING(1000);
	_obj_informacion_afectada public.objinformacion_afectada%rowtype;
BEGIN
	-- Tipo de dato de retorno
	SELECT	'',            -- inf_codigo VARCHAR(1000),
			'',            -- inf_complemento VARCHAR(1000),
			0,             -- err_existente INTEGER,
			'',            -- err_mensaje VARCHAR(1000),
			0              -- err_codigo INTEGER
	INTO _obj_informacion_afectada;


	 my_var:= 0;
	_procurcod_sigla:=procurcod_sigla;
	
	if not exists (	SELECT *
					FROM seguimiento_capacitacion.programacion_curso pc
					INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion pcc
					ON pc.procur_codigo = pcc.procur_codigo
					WHERE pcc.procurcod_sigla = _procurcod_sigla 
					AND pc.procur_estado=2) THEN
		_obj_informacion_afectada.inf_codigo		:= 'EL CURSO NO TIENE CONDICIONES PARA QUITAR EL CODIGO';
		_obj_informacion_afectada.inf_complemento	:= _procurcod_sigla;
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= '';
		_obj_informacion_afectada.err_codigo		:= 0;
		RETURN NEXT _obj_informacion_afectada;
	end if;
	
	SELECT pc.procur_codigo 
	INTO _procur_codigo 
	FROM seguimiento_capacitacion.programacion_curso pc
	INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion pcc
	ON pc.procur_codigo = pcc.procur_codigo
	WHERE pcc.procurcod_sigla = _procurcod_sigla AND pc.procur_estado=2;
	
	if not exists (	select * from  seguimiento_capacitacion.acuerdo_interinstitucional a 
					where a.procur_codigo = _procur_codigo) THEN
		_obj_informacion_afectada.inf_codigo		:= 'NO EXISTE CODIGO PARA ESTE CURSO';
		_obj_informacion_afectada.inf_complemento	:= _procurcod_sigla;
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= '';
		_obj_informacion_afectada.err_codigo		:= 0;
		RETURN NEXT _obj_informacion_afectada;
	end if;
	 -- insert historico
	insert into seguimiento_capacitacion.historico_acuerdo_interinstitucional
	(procur_codigo, acuins_codigo, acuins_estado, acuins_fecha_registro, acuins_usuario_base_datos, fecha_ejecucion, funcionario_ejecucion, comentario_ejecucion)
	select *, now() as fecha_ejecucion, 'Gabriel Casas M' as funcionario_ejecucion, 'borrado de registro en seguimiento_capacitacion.historico_acuerdo_interinstitucional' as  comentario_ejecucion
	from seguimiento_capacitacion.acuerdo_interinstitucional 
	where procur_codigo = _procur_codigo;
	
	delete from seguimiento_capacitacion.acuerdo_interinstitucional
	where procur_codigo = _procur_codigo;
	GET DIAGNOSTICS _rows_afected := ROW_COUNT;
	-- si no es lo esperado , hacer un rollback
	IF _rows_afected != 1	THEN   
		_err_Mensaje := '#ERROR AL MOMENTO DE BORRAR.';
		RAISE EXCEPTION transaction_rollback;
	END IF; 
	
	-- Retornamos los valores 
	_obj_informacion_afectada.inf_codigo		:= 1;
	_obj_informacion_afectada.inf_complemento	:= _procurcod_sigla;
	_obj_informacion_afectada.err_Existente		:= 0;
	_obj_informacion_afectada.err_Mensaje		:= 'SE QUITO EL CODIGO DEL CURSO';
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
		GET STACKED DIAGNOSTICS _obj_informacion_afectada.err_Mensaje := MESSAGE_TEXT;          
		RAISE NOTICE 'Error: (%) ', _obj_informacion_afectada;                
		_obj_informacion_afectada.err_Existente		:= 1;
        _obj_informacion_afectada.inf_codigo		:= -1;
        _obj_informacion_afectada.inf_complemento	:= 'otro error';                
		RETURN NEXT _obj_informacion_afectada;
	
END;
$function$
  