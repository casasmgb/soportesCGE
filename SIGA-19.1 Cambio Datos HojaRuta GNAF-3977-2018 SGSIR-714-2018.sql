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
/*
select	pcc.procurcod_sigla, 
		p.perpre_numero_docidentidad, 
		p.perpre_apellido_paterno, 
		p.perpre_apellido_materno, 
		p.* 
FROM acceso_externo.persona_preinscripcion p
INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
ON p.procur_codigo = pcc.procur_codigo 
WHERE pcc.procurcod_sigla = 'CE/LP-T369-804/2018' 
AND p.perpre_numero_docidentidad = '4251834-LP'
*/

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
	
	--1.-	CE/LP-T352-746/2018
	--		6876157
	select seguimiento_capacitacion.changeCI('CE/LP-T352-746/2018', '6876157-LP','ALANOCA','MARIÃ‘O', '6876157', 1) into _obj_informacion_afectada;
	--2.-	CE/LP-T348-742/2018
	--		3432081
	select seguimiento_capacitacion.changeCI('CE/LP-T348-742/2018', '3432081-LP','ALIAGA','HUARACHI', '3432081', 1) into _obj_informacion_afectada;
	--3.-	CE/CB-T30-774/2018
	--		7973949
	select seguimiento_capacitacion.changeCI('CE/CB-T30-774/2018', '7973948','ARCIENEGA','PAZ', '7973949', 1) into _obj_informacion_afectada;
	--4.-	CE/CB-T33-777/2018
	--		7973949
	select seguimiento_capacitacion.changeCI('CE/CB-T33-777/2018', '7973948','ARCIENEGA','PAZ', '7973949', 1) into _obj_informacion_afectada;
	--5.-	CE/LP-A03-205/2017
	--		6827356
	select seguimiento_capacitacion.changeCI('CE/LP-A03-205/2017', '6827356-LP','AZEÃ‘AS','DEL CARPIO', '6827356', 1) into _obj_informacion_afectada;
	--6.-	CE/CH-T09-661/2018
	--		3646089
	select seguimiento_capacitacion.changeCI('CE/CH-T09-661/2018', '3646189','BARRIOS','MEDRANO', '3646089', 1) into _obj_informacion_afectada;
	--7.-	CE/LP-T235-444/2018
	--		7333357
	UPDATE seguimiento_capacitacion.personas p
	SET
		dep_codigo_expedicion = 4 --7
        WHERE p.per_codigo = 25478 AND p.per_docidentidad='7333357';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--8.-	CE/CH-T06-658/2018
	--		4749988
	UPDATE seguimiento_capacitacion.personas p
	SET
		dep_codigo_expedicion = 2 --1
        WHERE p.per_codigo = 29957 AND p.per_docidentidad='4749988';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--9, 10, 11.-	MU/CH-T04-649/2018
	--		6649733
	-- select * from seguimiento_capacitacion.personas where per_docidentidad = '6649733'
	
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'EDDY RICHARD' --RICHARD
		-- per_codigopersona = 'CIE6649733' --CIR6649733
        WHERE p.per_codigo = 27124 AND p.per_docidentidad='6649733';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--13.-	CE/CH/A03-665/2018
	--		4729571
	UPDATE seguimiento_capacitacion.personas p
	SET
		dep_codigo_expedicion = 7 --1
        WHERE p.per_codigo = 28762 AND p.per_docidentidad='4729571';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--14.-	CE/LP-T356-754/2018
	--		2690158
	select seguimiento_capacitacion.changeCI('CE/LP-T356-754/2018', '2990158','CONDE','SILVA', '2690158', 1) into _obj_informacion_afectada;
	--15.-	MU/LP-T10-172/2017
	--		6073409
	select seguimiento_capacitacion.changeCI('MU/LP-T10-172/2017', '6073409-LP','COPA','HUANCA', '6073409', 1) into _obj_informacion_afectada;
	--16.-	CE/LP-T189-386/2018
	--		1145390
	select seguimiento_capacitacion.changeCI('CE/LP-T189-386/2018', '1145390-CH','DURAN','ALMENDRAS', '1145390', 1) into _obj_informacion_afectada;
	--17.-	CE/LP-T190-387/2018
	--		1145390
	select seguimiento_capacitacion.changeCI('CE/LP-T190-387/2018', '1145390-CH','DURAN','ALMENDRAS', '1145390', 1) into _obj_informacion_afectada;
	--17.-	CE/LP-T191-388/2018
	--		1145390
	select seguimiento_capacitacion.changeCI('CE/LP-T191-388/2018', '1145390-CH','DURAN','ALMENDRAS', '1145390', 1) into _obj_informacion_afectada;
	--18.-	CE/LP-T192-389/2018
	--		1145390
	select seguimiento_capacitacion.changeCI('CE/LP-T192-389/2018', '1145390-CH','DURAN','ALMENDRAS', '1145390', 1) into _obj_informacion_afectada;
	--19.-	CE/LP-T193-390/2018
	--		1145390
	select seguimiento_capacitacion.changeCI('CE/LP-T193-390/2018', '1145390-CH','DURAN','ALMENDRAS', '1145390', 1) into _obj_informacion_afectada;
	--20.-	CE/LP-T356-754/2018
	--		6169346
	select seguimiento_capacitacion.changeCI('CE/LP-T356-754/2018', '6169349','ESPINOZA','QUISPE', '6169346', 1) into _obj_informacion_afectada;
	--21.-	CE/CH-T04-656/2018
	--		8508672
	select seguimiento_capacitacion.changeCI('CE/CH-T04-656/2018', '8508672-PT','ESTRADA','GONZALES', '8508672', 1) into _obj_informacion_afectada;
	--22.-	CE/CH-T05-657/2018
	--		8508672
	select seguimiento_capacitacion.changeCI('CE/CH-T05-657/2018', '8508672-PT','ESTRADA','GONZALES', '8508672', 1) into _obj_informacion_afectada;
	--23.-	CE/LP-T388-858/2018
	--		6154723
	select seguimiento_capacitacion.changeCI('CE/LP-T388-858/2018', '61547223','FERNANDEZ','TORREZ', '6154723', 1) into _obj_informacion_afectada;
	--24.-	CE/LP-A58-738/2018
	--		6862062
	select seguimiento_capacitacion.changeCI('CE/LP-A58-738/2018', '6862062-LP','GISBERT','LIMACHI', '6862062', 1) into _obj_informacion_afectada;
	--25.-	CE/LP-E09-827/2018
	--		4446619
	--26, 27.-	MU/CH-T07-652/2018
	--		10703395
	UPDATE seguimiento_capacitacion.personas p
	set
		per_appaterno = 'HUAYLLANI', --HUYLLANI
		dep_codigo_expedicion = 6 --1
        WHERE p.per_codigo = 27357 AND p.per_docidentidad='10703395';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--28.-	MU/LP-T32-798/2018
	--		6026362
	select seguimiento_capacitacion.changeCI('MU/LP-T32-798/2018', '6026362-LP','MAMANI','CHOQUE', '6026362', 1) into _obj_informacion_afectada;
	--29, 30, 31.-	MU/CH-T04-649/2018
	--		7555219
	UPDATE seguimiento_capacitacion.personas p
	set
		dep_codigo_expedicion = 1 --6
        WHERE p.per_codigo = 27045 AND p.per_docidentidad='7555219';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	
	--32.-	CE/CH-T09-661/2018
	--		8075357
	UPDATE seguimiento_capacitacion.personas p
	set
		per_apmaterno='OROZCO',-- VELASQUEZ
		per_apmaterno='VELASQUEZ'--OROZCO
        WHERE p.per_codigo = 28660 AND p.per_docidentidad='8075357';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--33.-	CE/LP-A58-738/2018
	--		8278248
	select seguimiento_capacitacion.changeCI('CE/LP-A58-738/2018', '8278248-LP','PEÑA','VISCAFE', '8278248', 2) into _obj_informacion_afectada;
	--34.-	MU/CH-T04-649/2018
	--		7481233
	select seguimiento_capacitacion.changeCI('MU/CH-T04-649/2018', '4781233','PEÑARANDA','CHAVARRIA', '7481233', 1) into _obj_informacion_afectada;
	--35.-	MU/CH-T05-650/2018
	--		7481233
	select seguimiento_capacitacion.changeCI('MU/CH-T05-650/2018', '4781233','PEÑARANDA','CHAVARRIA', '7481233', 1) into _obj_informacion_afectada;
	--36.-	MU/CH-T06-651/2018
	--		7481233
	select seguimiento_capacitacion.changeCI('MU/CH-T06-651/2018', '4781233','PEÑARANDA','CHAVARRIA', '7481233', 1) into _obj_informacion_afectada;
	--37.-	CE/LP-T10-618/2017
	--		2309505
	select seguimiento_capacitacion.changeCI('CE/LP-T10-618/2017', '2309505-LP','QUINT','VARGAS', '2309505', 1) into _obj_informacion_afectada;
	--38.-	CE/LP-A46-631/2018
	--		2506512
	UPDATE seguimiento_capacitacion.personas p
	set
		per_nombres = 'LEONARDO' --LEONARDOD
        WHERE p.per_codigo = 27369 AND p.per_docidentidad='2506512';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--39.-	CE/LP-T172-362/2018
	--		6949019
	select seguimiento_capacitacion.changeCI('CE/LP-T172-362/2018', '6949019-LP','QUISPE','RAMOS', '6949019', 1) into _obj_informacion_afectada;
	--40.-	CE/LP-T173-363/2018
	--		6949019
	select seguimiento_capacitacion.changeCI('CE/LP-T173-363/2018', '6949019-LP','QUISPE','RAMOS', '6949019', 1) into _obj_informacion_afectada;
	--41.-	CE/LP-T174-364/2018
	--		6949019
	select seguimiento_capacitacion.changeCI('CE/LP-T174-364/2018', '6949019-LP','QUISPE','RAMOS', '6949019', 1) into _obj_informacion_afectada;
	--42.-	CE/LP-T175-365/2018
	--		6949019
	select seguimiento_capacitacion.changeCI('CE/LP-T175-365/2018', '6949019-LP','QUISPE','RAMOS', '6949019', 1) into _obj_informacion_afectada;
	--43.-	CE/LP-T176-366/2018
	--		6949019
	select seguimiento_capacitacion.changeCI('CE/LP-T176-366/2018', '6949019-LP','QUISPE','RAMOS', '6949019', 1) into _obj_informacion_afectada;
	--44.-	MU/LP-T32-798/2018
	--		6125423
	select seguimiento_capacitacion.changeCI('MU/LP-T32-798/2018', '6125423-LP','QUISPE','FRANCO', '6125423', 1) into _obj_informacion_afectada;
	--45.-	CE/LP-A49-634/2018
	--		3474720
	select seguimiento_capacitacion.changeCI('CE/LP-A49-634/2018', '3474720-P8','QUISPE','CARRILLO', '3474720', 1) into _obj_informacion_afectada;
	--46.-	CE/PN-T06-671/2018
	--		4203874
	select seguimiento_capacitacion.changeCI('CE/PN-T06-671/2018', '4203879','RAMIREZ','RODRIGUEZ', '4203874', 1) into _obj_informacion_afectada;
	--47.-	CE/LP-A58-738/2018
	--		9982331
	select seguimiento_capacitacion.changeCI('CE/LP-A58-738/2018', '9982331-LP','REVILLA','CORONEL', '9982331', 1) into _obj_informacion_afectada;
	--48.-	CE/LP-T371-811/2018
	--		3367022
	select seguimiento_capacitacion.changeCI('CE/LP-T371-811/2018', '3367022-LP','ROJAS','LEDEZMA', '3367022', 1) into _obj_informacion_afectada;
	--49.-	CE/LP-A66-831/2018
	--		2706248
	UPDATE seguimiento_capacitacion.personas p
	set
		per_nombres = 'MARTHA ANA MARIA' --MARTHA ANA
        WHERE p.per_codigo = 30332 AND p.per_docidentidad='2706248';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--50.-	CE/LP-T363-794/2018
	--		5132220
	UPDATE seguimiento_capacitacion.personas p
	set
		dep_codigo_expedicion = 5 -- 2
        WHERE p.per_codigo = 29532 AND p.per_docidentidad='5132220';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--51.-	MU/CH-T04-649/2018
	--		5076275
	select seguimiento_capacitacion.changeCI('MU/CH-T04-649/2018', '5690926','SANTOS','GOMEZ', '5076275', 1) into _obj_informacion_afectada;
	--52.-	MU/CH-T06-651/2018
	--		5076275
	select seguimiento_capacitacion.changeCI('MU/CH-T06-651/2018', '5690926','SANTOS','GOMEZ', '5076275', 1) into _obj_informacion_afectada;
	--53.-	CE/LP-A59-797/2018
	--		4774645
	select seguimiento_capacitacion.changeCI('CE/LP-A59-797/2018', '4774641','SEBASTIAN','QUISPE', '4774645', 1) into _obj_informacion_afectada;
	--54.-	MU/CH-T10-668/2018
	--		4149909
	UPDATE seguimiento_capacitacion.personas p
	set
		dep_codigo_expedicion = 6 -- 2
        WHERE p.per_codigo = 27774 AND p.per_docidentidad='4149909';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--55.-	CE/LP-T369-804/2018
	--		4251834
	select seguimiento_capacitacion.changeCI('CE/LP-T369-804/2018', '4251834-LP','ZEGARRUNDO','INOFUENTES', '4251834', 1) into _obj_informacion_afectada;
	--56.-	CE/LP-T356-754/2018
	--		2690158
	--57.-	CE/LP-T363-794/2018
	--		5765310
	UPDATE seguimiento_capacitacion.personas p
	set
		dep_codigo_expedicion = 4 -- 2
        WHERE p.per_codigo = 29536 AND p.per_docidentidad='5765310';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--58.-	CE/LP-E07-625/2018
	--		6119535
	--59.-	CE/LP-E07-625/2018
	--		4833703
	UPDATE seguimiento_capacitacion.personas p
	set
		per_apmaterno = 'LLANOS' --LLANO
        WHERE p.per_codigo = 26861 AND p.per_docidentidad='4833703';
   	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--60.-	CE/LP-A30-546/2018
	--		6130317
	--61.-	CE/LP-T272-503/2018
	--		3871311
	--62.-	MU/LP-A03-549/2018
	--		6989806
	select seguimiento_capacitacion.changeCI('MU/LP-A03-549/2018', '6989826','COYA','QUISBERT', '6989806', 1) into _obj_informacion_afectada;
	--63.-	CE/LP-T375-816/2018
	--		10903563
	select seguimiento_capacitacion.changeCI('CE/LP-T375-816/2018', '10923563','CONDORI','CALLA', '10903563', 1) into _obj_informacion_afectada;
	--64.-	CE/LP-T369-804/2018
	--		4251834
	--65.-	PO/OR-A02-479/2017
	--		7303900
	select seguimiento_capacitacion.changeCI('PO/OR-A02-479/2017', '7303900-OR','CHOQUE','CERROGRANDE', '7303900', 1) into _obj_informacion_afectada;
	
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


