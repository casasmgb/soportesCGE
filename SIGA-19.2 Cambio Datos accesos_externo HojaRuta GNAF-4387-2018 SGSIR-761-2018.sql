--====================================================================================
	/*
	HOJA DE RUTA GNAF 4387/2018 SGSIR/761/2018
	CENCAP/CI-712/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 15/11/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 20/11/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	select acceso_externo.correccionDatosNombres4387();
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.correccionDatosNombres4387() 
  RETURNS  void AS
$BODY$
DECLARE
	my_var INTEGER;
	_data_historico JSON;
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
	
	--1.-	CE/LP-T273-504/2018
	--		6062848
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '6062848' and  pp.perpre_codigo = '20180822_EQFGHY'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'actualizar nombre');
	 
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'LORENA PACESA' --LORENAPACESA
	WHERE perpre_numero_docidentidad = '6062848' 
	and  perpre_codigo = '20180822_EQFGHY';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '1 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF; 
	--2.-	CE/LP-T33-075/2017  --75
	--		6724235
	select acceso_externo.changeCI('75', '6724235-LP','VARGAS','PACO', '6724235', 1) into _obj_informacion_afectada;
	--3.-	CE/LP-T202-399/2018
	--		3290423
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '3290423' and  pp.perpre_codigo = '20180622_CUDMQP'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'acturalizar apellidos paterno y materno');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'BALLESTERO', --ANTELO
		perpre_apellido_materno = 'ANTELO'		--BALLESTERO
	WHERE perpre_numero_docidentidad = '3290423' 
	and  perpre_codigo = '20180622_CUDMQP';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '3 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF; 
	--5.-	MU/SC-T41-792/2018
	--		7737021
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '7737021' and  pp.perpre_codigo = '20180926_WMSGGW'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'acturalizar apellido materno');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_materno = 'VACA'		--CAVA
	WHERE perpre_numero_docidentidad = '7737021' 
	and  perpre_codigo = '20180926_WMSGGW';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '5 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF; 
	--7.-	CE/LP-T388-858/2018
	--		5963141
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '5963141' and  pp.perpre_codigo = '20181004_RNYKID'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'acturalizar nombres');
	
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
	--10.-	MU/LP-T32-798/2018  --1507
	--		6125423
	select acceso_externo.changeCI('1507', '6125423-LP','QUISPE','FRANCO', '6125423', 1) into _obj_informacion_afectada;
	--15.-	MU/LP-A10-851/2018
	--		4799716
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '4799716' and  pp.perpre_codigo = '20181017_ALKROH'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'acturalizar apellidos paterno');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'MONTAÑO'		--MOTAÑO
	WHERE perpre_numero_docidentidad = '4799716' 
	and  perpre_codigo = '20181017_ALKROH';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '15 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF;
	--17.-	CE/OR-T13-877/2018
	--		7315747
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '7315747' and  pp.perpre_codigo = '20181017_JYTRMT'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'acturalizar nombres');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'SHIRLEY KAREN'		--SHIRLEY KEREN
	WHERE perpre_numero_docidentidad = '7315747' 
	and  perpre_codigo = '20181017_JYTRMT';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '17 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF;
	--19.-	PO/LP-A17-425/2017
	--		7041289
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '7041289'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'acturalizar apellido paterno');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'HUANCA'		--HUANACA
	WHERE perpre_numero_docidentidad = '7041289';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '20 Ok : % ', my_var;
	IF my_var != 2 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF;
	--21.-	CE/LP-E09-827/2018
	--		4446619
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181016_RGKAGY'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'Cambio codigo de expedicion');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 3 --2
	WHERE perpre_codigo = '20181016_RGKAGY'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '22: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 

	--24.-	CE/LP-T10-616/2017   --617 
	--		10917527
	select acceso_externo.changeCI('617', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--25.-	CE/LP-T10-617/2017  --618
	--		10917527
	select acceso_externo.changeCI('618', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--26.-	CE/LP-T10-618/2017  --619
	--		10917527
	select acceso_externo.changeCI('619', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--27.-	CE/LP-T10-620/2017  --621
	--		10917527
	select acceso_externo.changeCI('621', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--28.-	CE/LP-T11-087/2018  --787
	--		10917527
	select acceso_externo.changeCI('787', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--29.-	CE/LP-T12-088/2018  --788
	--		10917527
	select acceso_externo.changeCI('788', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--30.-	CE/LP-T13-089/2018  --789
	--		10917527
	select acceso_externo.changeCI('789', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--31.-	CE/LP-T14-090/2018  --797
	--		10917527
	select acceso_externo.changeCI('797', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--32.-	CE/LP-T15-091/2018  --798
	--		10917527
	select acceso_externo.changeCI('798', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--33.-	CE/LP-T32-074/2017  --74
	--		10917527
	select acceso_externo.changeCI('74', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	--34.-	CE/LP-T93-231/2017  --231
	--		10917527
	select acceso_externo.changeCI('231', '10917527-LP','FERNANDEZ','CHAMBI', '10917527', 1) into _obj_informacion_afectada;
	
	--43.-	CE/LP-T379-820/2018
	--		4308607
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181018_LPQMVF'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'quitar apellido de esposo');
	
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_esposo = '' --BARRIOS
	WHERE perpre_codigo = '20181018_LPQMVF'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '44: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--48.-	CE/LP-T366-799/2018
	--		4888820
	-- 20181030_XRBRAE
	-- 20180930_BMSHUJ
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_codigo = '20181030_XRBRAE' or pp.perpre_codigo = '20180930_BMSHUJ'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'cambio de apellidos paterno y materno ');
	
	UPDATE acceso_externo.persona_preinscripcion
   	set
   		perpre_apellido_paterno = '',		--ROJAS
		perpre_apellido_materno = 'ROJAS' 	--''
	WHERE perpre_codigo = '20181030_XRBRAE' or perpre_codigo = '20180930_BMSHUJ'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '49: % ', my_var;
	IF my_var != 2 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
