--====================================================================================
	/*
	HOJA DE RUTA GNAF 4387/2018 SGSIR/761/2018
	CENCAP/CI-712/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 15/11/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 20/11/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	SELECT seguimiento_capacitacion.correccionDatos4387()  
	*/
--====================================================================================
/*
select	pcc.procurcod_sigla, 
		p.perpre_numero_docidentidad, 
		p.perpre_apellido_paterno, 
		p.perpre_apellido_materno, 
		p.* 
FROM acceso_externo.persona_preinscripcion p
INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
ON p.procur_codigo = pcc.procur_codigo 
WHERE pcc.procurcod_sigla = 'CE/LP-T93-231/2017' 
AND p.perpre_numero_docidentidad = '10917527-LP'
*/

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.correccionDatos4387()  
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
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
	
	--4.-	CE/LP-T376-817/2018
	--		2394260
	select seguimiento_capacitacion.changeCI('CE/LP-T376-817/2018', '2394260-LP','URQUIDI','CARDENAS', '2394260', 1) into _obj_informacion_afectada;
	--6.-	CE/LP-T392-862/2018
	--		2448749
	select * from  seguimiento_capacitacion.changeCI('CE/LP-T392-862/2018', '2448749-LP','SALINAS','SARAVIA', '2448749', 1) into _obj_informacion_afectada;
	--8.-	CE/LP-T372-813/2018
	--		6988817
	select seguimiento_capacitacion.changeCI('CE/LP-T372-813/2018', '6988817-LP','ROMERO','CALLE', '6988817', 1) into _obj_informacion_afectada;
	--9.-	CE/LP-T354-749/2018
	--		6987176
	select seguimiento_capacitacion.changeCI('CE/LP-T354-749/2018', '6987176-LP','RAMOS','CORANI', '6987176', 1) into _obj_informacion_afectada;
	--11.-	CE/LP-A65-830/2018
	--		3390285
	select seguimiento_capacitacion.changeCI('CE/LP-A65-830/2018', '3390285-LP','PRADO','SARDINAS', '3390285', 1) into _obj_informacion_afectada;
	--12.-	CE/LP-T392-862/2018
	--		4849884
	select seguimiento_capacitacion.changeCI('CE/LP-T392-862/2018', '48498844','PARRA','GUTIERREZ', '4849884', 1) into _obj_informacion_afectada;
	--13.-	CE/LP-T321-584/2018
	--		3496837
	select seguimiento_capacitacion.changeCI('CE/LP-T321-584/2018', '3496637','MORALES','REYES', '3496837', 1) into _obj_informacion_afectada;
	--14.-	CE/SC-T20-562/2017
	--		8074859
	select seguimiento_capacitacion.changeCI('CE/SC-T20-562/2017', '8074859-SC','MONTAÑO','CALZADILLA', '8074859', 1) into _obj_informacion_afectada;
	--16.-	CE/LP-T378-819/2018
	--		9127475
	select seguimiento_capacitacion.changeCI('CE/LP-T378-819/2018', '9127475-LP','MOLLO','CHAMBILLA', '9127475', 1) into _obj_informacion_afectada;
	--17.-	CE/OR-T13-877/2018
	--		7315747
	SELECT row_to_json (row1) INTO _data_historico
		FROM (
		    SELECT * FROM seguimiento_capacitacion.personas p WHERE p.per_codigo = 31050 AND p.per_docidentidad='7315747'
		) row1;
	
	INSERT INTO seguimiento_capacitacion.historico_datos_primarios
		(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'Actualizacion de nombres');
	 
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'SHIRLEY KAREN' --SHIRLEY KEREN
        WHERE p.per_codigo = 31050 AND p.per_docidentidad='7315747';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--18.-	CE/LP-T373-814/2018
	--		8302036
	select seguimiento_capacitacion.changeCI('CE/LP-T373-814/2018', '8302036-LP','MALDONADO','HINOJOSA', '8302036', 1) into _obj_informacion_afectada;
	--19.-	CE/LP-A76-863/2018
	--		4751133
	select seguimiento_capacitacion.changeCI('CE/LP-A76-863/2018', '4751133-LP','LUNA','QUISPE', '4751133', 1) into _obj_informacion_afectada;
	--21.-	CE/LP-A76-863/2018
	--		6003928
	select seguimiento_capacitacion.changeCI('CE/LP-A76-863/2018', '6003928-LP','HUANCA','TICONA', '6003928', 1) into _obj_informacion_afectada;
	--22.-	CE/LP-E09-827/2018
	--		4446619
	SELECT row_to_json (row1) INTO _data_historico
		FROM (
		    SELECT * FROM seguimiento_capacitacion.personas p WHERE p.per_codigo = 30921 AND p.per_docidentidad='4446619'
		) row1;
	
	INSERT INTO seguimiento_capacitacion.historico_datos_primarios
		(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'Actualizacion de codigo de departamento');
	
	UPDATE seguimiento_capacitacion.personas p
	SET
		dep_codigo_expedicion = 3 --2
        WHERE p.per_codigo = 30921 AND p.per_docidentidad='4446619';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--23  24 - 35.-	CE/LP-T10-357/2017
	--		10917527
	select seguimiento_capacitacion.changeCI('CE/LP-T10-357/2017', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	
	--36.-	CE/LP-T221-430/2018
	--		3439746
	select seguimiento_capacitacion.changeCI('CE/LP-T221-430/2018', '3439746-LP','FARFAN','RAMOS', '3439746', 1) into _obj_informacion_afectada;
	--37.-	CE/LP-A76-863/2018
	--		6748152
	select seguimiento_capacitacion.changeCI('CE/LP-A76-863/2018', '6748152-LP','ESCOBAR','CABRERA', '6748152', 1) into _obj_informacion_afectada;
	--38.-	CE/LP-A76-863/2018
	--		4928721
	select seguimiento_capacitacion.changeCI('CE/LP-A76-863/2018', '4928721-LP','ESCOBAR','ZALLES', '4928721', 1) into _obj_informacion_afectada;
	--39.-	CE/LP-A76-863/2018
	--		8318732
	select seguimiento_capacitacion.changeCI('CE/LP-A76-863/2018', '8318732-LP','CONTRERAS','MAMANI', '8318732', 1) into _obj_informacion_afectada;
	--40.-	CE/PN-A06-679/2018
	--		3659709
	select seguimiento_capacitacion.changeCI('CE/PN-A06-679/2018', '3659709-CH','CHOQUE','TEJERINA', '3659709', 1) into _obj_informacion_afectada;
	--41.-	CE/LP-A21-313/2018
	--		4921547
	select seguimiento_capacitacion.changeCI('CE/LP-A21-313/2018', '4921547-LP','CHOQUE','ALAVE', '4921547', 1) into _obj_informacion_afectada;
	--42.-	MU/LP-T32-798/2018
	--		6784406
	select seguimiento_capacitacion.changeCI('MU/LP-T32-798/2018', '6784406-LP','CANAVIRI','FLORES', '6784406', 1) into _obj_informacion_afectada;
	--43.-	MU/LP-A04-623/2018
	--		8286453
	select seguimiento_capacitacion.changeCI('MU/LP-A04-623/2018', '8286453-LP','ASTURILLO','FLORES', '8286453', 1) into _obj_informacion_afectada;
	--45.-	CE/CB-T34-778/2018
	--		7956915
	select seguimiento_capacitacion.changeCI('CE/CB-T34-778/2018', '7956915-CB','ADRIAN','CONDORI', '7956915', 1) into _obj_informacion_afectada;
	--46.-	CE/LP-T225-434/2018
	--		6612586
	select seguimiento_capacitacion.changeCI('CE/LP-T225-434/2018', '6612586-PT','ACEBEY','ARISMENDI', '6612586', 1) into _obj_informacion_afectada;
	--47.-	CE/LP-A03-154/2018
	--		3334282
	select seguimiento_capacitacion.changeCI('CE/LP-A03-154/2018', '3334282-LP','LUNA','ALANOCA', '3334282', 1) into _obj_informacion_afectada;
	--48.-	CE/LP-T221-430/2018
	--		3439746
	select seguimiento_capacitacion.changeCI('CE/LP-T221-430/2018', '3439746-LP','FARFAN','RAMOS', '3439746', 1) into _obj_informacion_afectada;
	--49.-	CE/LP-T366-799/2018
	--		4888820
	select seguimiento_capacitacion.changeCI('CE/LP-T366-799/2018', '488820','ROJAS','', '4888820', 1) into _obj_informacion_afectada;
	
	SELECT row_to_json (row1) INTO _data_historico
		FROM (
		    SELECT * FROM seguimiento_capacitacion.personas p WHERE p.per_docidentidad='4888820'
		) row1;
	
	INSERT INTO seguimiento_capacitacion.historico_datos_primarios
		(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'Actualizacion de apellidos paterno y materno');
	
	UPDATE seguimiento_capacitacion.personas p
	set
		per_codigopersona = '_RA4888820', --R_A4888820
		per_appaterno = '', 	--ROJAS
		per_apmaterno = 'ROJAS'	-- 
        WHERE p.per_docidentidad='4888820';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 2 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	
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


