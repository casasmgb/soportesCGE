--====================================================================================
	/*
	HOJA DE RUTA GNAF 3717/2018 SGSIR/682/2018
	
	CENCAP/CI-633/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 08/10/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 11/10/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
--====================================================================================
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.correcionDatos()  
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
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
	my_var:=0;
	
	--1.-  	CE/LP-T332-630/2018
	--		3463897
	select seguimiento_capacitacion.changeCI('CE/LP-T332-630/2018', '3463897-LP','CUARITA','AJNO', '3463897', 1) into _obj_informacion_afectada;
	--2.-	MU/LP-T16-606/2018
	--		4852088
	select seguimiento_capacitacion.changeCI('MU/LP-T16-606/2018', '4852088-LP','ALTAMIRANO','LIMA', '4852088', 1) into _obj_informacion_afectada;
	--3.-	CE/LP-T347-737/2018
	--		3357396
	select seguimiento_capacitacion.changeCI('CE/LP-T347-737/2018', '3357396-LP','BARRERA','CORDERO', '3357396', 1) into _obj_informacion_afectada;		
	--4.-	MU/LP-T24-750/2018
	--		6951257
	select seguimiento_capacitacion.changeCI('MU/LP-T24-750/2018', '9093287','BARRIONUEVO','TENORIO', '6951257', 1) into _obj_informacion_afectada;		
	--5.-	CE/LP-T348-742/2018
	--		4803416
	select seguimiento_capacitacion.changeCI('CE/LP-T348-742/2018', '4803416-LP','CALDERON','RIVAS', '4803416', 1) into _obj_informacion_afectada;
	--6.-	CE/LP-T30-109/2018
	--		8250161
	select seguimiento_capacitacion.changeCI('CE/LP-T30-109/2018', '8251161','CALLIZAYA','LECOÑA', '8250161', 1) into _obj_informacion_afectada;
	--7.-	CE/LP-T230-439/2018
	--		5749440
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'JESUS CRISTIAN' --JESUYS CRISTIAN
        WHERE p.per_codigo = 25053 AND p.per_docidentidad='5749440';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--8.-	MU/SC-T39-785/2018
	--		6311253
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'LILHLIA MARLINA' --LILHLIA
        WHERE p.per_codigo = 29371 AND p.per_docidentidad='6311253';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--9.-	CE/LP-T363-794/2018
	--		6734268
	select seguimiento_capacitacion.changeCI('CE/LP-T363-794/2018', '6734268-LP','FLORES','CALZADA', '6734268', 1) into _obj_informacion_afectada;
	--10.-	CE/LP-T131-268/2018
	--		5817542
	select seguimiento_capacitacion.changeCI('CE/LP-T131-268/2018', '5817542-TJ','GÓMEZ','BORJA', '5817542', 1) into _obj_informacion_afectada;
	--11.-	MU/LP-A04-623/2018
	--		9945974
	select seguimiento_capacitacion.changeCI('MU/LP-A04-623/2018', '9945974-LP','GUTIERREZ','CHURA', '9945974', 1) into _obj_informacion_afectada;
	--12.-	CE/LP-T346-736/2018
	--		3359257
	select seguimiento_capacitacion.changeCI('CE/LP-T346-736/2018', '3359257-LP','LLAVE','ALVAREZ', '3359257', 1) into _obj_informacion_afectada;
	--13.-	MU/LP-T18-723/2018
	--		3467858
	select seguimiento_capacitacion.changeCI('MU/LP-T18-723/2018', '3467858-00','MACHACA','MAMANI', '3467858', 1) into _obj_informacion_afectada;
	--14.-	CE/LP-T10-630/2017
	--		4987779
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'NELSON' --NELSON MALDONADO ILLANES
        WHERE p.per_codigo = 12963 AND p.per_docidentidad='4987779';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--15.-	CE/LP-T291-524/2018
	--		8318608
	select seguimiento_capacitacion.changeCI('CE/LP-T291-524/2018', '8318608-LP','MARCA','CHOQUEHUANCA', '8318608', 1) into _obj_informacion_afectada;
	--16.-	CE/CB-T24-700/2018
	--		3618064
	--17.-	CE/PN-T03-622/2018
	--		1761518
	select seguimiento_capacitacion.changeCI('CE/PN-T03-622/2018', '1761518-PD','MUÑOZ','GARCIA', '1761518', 2) into _obj_informacion_afectada;
	--18.-	CE/PN-T06-671/2018
	--		3339102
	--19.-	CE/LP-A45-624/2018
	--		5470738
	select seguimiento_capacitacion.changeCI('CE/LP-A45-624/2018', '5470738-LP','QUISPE','MAMANI', '5470738', 1) into _obj_informacion_afectada;
	--20.-	CE/LP-T290-523/2018
	--		3460823
	select seguimiento_capacitacion.changeCI('CE/LP-T290-523/2018', '3460823-LP','ROCABADO','CERDA', '3460823', 1) into _obj_informacion_afectada;
	--21.-	MU/LP-T24-750/2018
	--		9093287
	select seguimiento_capacitacion.changeCI('MU/LP-T24-750/2018', '90932870','RODRIGUEZ','CANAVIRI', '9093287', 1) into _obj_informacion_afectada;
	--22.-	CE/LP-T352-746/2018
	--		3367022
	select seguimiento_capacitacion.changeCI('CE/LP-T352-746/2018', '3367022-LP','ROJAS','LEDEZMA', '3367022', 1) into _obj_informacion_afectada;
	--23.-	MU/SC-A03-477/2017
	--		6225064
	select seguimiento_capacitacion.changeCI('MU/SC-A03-477/2017', '6225064-SC','RUIZ','CRUZ', '6225064', 1) into _obj_informacion_afectada;
	--24.-	CE/LP-T10-582/2017
	--		6140497
	select seguimiento_capacitacion.changeCI('CE/LP-T10-582/2017', '6140497-LP','SILVA','LUNA', '6140497', 1) into _obj_informacion_afectada;
	--25.-	MU/TR-T09-042/2018
	--		5801241
	select seguimiento_capacitacion.changeCI('MU/TR-T09-042/2018', '581241','SURUGUAY','CARDOZO', '5801241', 1) into _obj_informacion_afectada;
	--26.-	CE/PN-T04-669/2018
	--		4203568
	
	    -- Retornamos los valores 
	_obj_informacion_afectada.inf_codigo		:= _mensaje;
	_obj_informacion_afectada.inf_complemento	:= 'SCRIPT FINALIZO';
	_obj_informacion_afectada.err_Existente		:= 0;
	_obj_informacion_afectada.err_Mensaje		:= _obj_informacion_afectada;
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