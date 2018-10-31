--====================================================================================
	/*
	HOJA DE RUTA GNAF 3717/2018 SGSIR/682/2018
	CENCAP/CI-633/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 08/10/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA CREACION: 10/10/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	select acceso_externo.correccionDatosNombres();
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.correccionDatosNombres() 
  RETURNS  void AS
$BODY$
DECLARE
	my_var INTEGER;
BEGIN
	my_var:=0;
	
	--7.-	CE/LP-T235-444/2018
	--		7333357
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 4 --7
	WHERE perpre_codigo = '20180803_NGUHSV'; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '7: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--8.-	CE/CH-T06-658/2018
	--		4749988
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 2 --1
	WHERE perpre_codigo = '20181003_ISVRGB';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '8: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--9, 10, 11.-	MU/CH-T04-649/2018
	--		6649733
    UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'EDDY RICHARD' --RICHARD
	WHERE perpre_numero_docidentidad = '6649733';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '9,10,11: % ', my_var;
	IF my_var != 3 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--13.-	CE/CH/A03-665/2018
	--		4729571
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 7 -- 1
	WHERE perpre_codigo = '20180828_BQPHGQ';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '13: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--25.-	CE/LP-E09-827/2018
	--		4446619
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_correo_electronico = 'sasgo2013_@hotmail.es'
	WHERE perpre_codigo = '20181016_RGKAGY';
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '25: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--26, 27.-	MU/CH-T07-652/2018
	--		10703395
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'HUAYLLANI', -- HUYLLANI
		perpre_numero_docidentidad = 6
	WHERE perpre_numero_docidentidad = '10703395';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '27: % ', my_var;
	IF my_var != 3 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--29, 30, 31.-	MU/CH-T04-649/2018
	--		7555219
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 1 --6
	WHERE perpre_numero_docidentidad = '7555219';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '29, 30, 31: % ', my_var;
	IF my_var != 3 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--32.-	CE/CH-T09-661/2018
	--		8075357
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_paterno = 'OROZCO',-- VELASQUEZ
		perpre_apellido_materno = 'VELASQUEZ'-- OROZCO
	WHERE perpre_codigo = '20180921_XXVBYK';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '32: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--38.-	CE/LP-A46-631/2018
	--		2506512
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'LEONARDO'-- LEONARDOD
	WHERE perpre_codigo = '20180907_FDWVHH';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '38: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--49.-	CE/LP-A66-831/2018
	--		2706248
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'MARTHA ANA MARIA'-- MARTHA ANA
	WHERE perpre_codigo = '20181008_LMKQLV';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '49: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--50.-	CE/LP-T363-794/2018
	--		5132220
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 5 -- 2
	WHERE perpre_codigo = '20180927_TBRIJH';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '50: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--54.-	MU/CH-T10-668/2018
	--		4149909
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 6 --1
	WHERE perpre_codigo = '20180911_OJJGBA';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '54: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--57.-	CE/LP-T363-794/2018
	--		5765310
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		dep_codigo_expedicion = 4 --2
	WHERE perpre_codigo = '20180927_QLXRMK';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '57: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--58.-	CE/LP-E07-625/2018
	--		6119535
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_materno = 'BADANI' -- BADINI
	WHERE perpre_codigo = '20180829_KMJRYW';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '58: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--59.-	CE/LP-E07-625/2018
	--		4833703
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_materno = 'LLANOS' -- LLANO
	WHERE perpre_codigo = '20180829_EBAHGK';
	RAISE NOTICE '59: % ', my_var;
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--60.-	CE/LP-A30-546/2018
	--		6130317
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'RAUL ALVARO' -- RAUL LAVARO
	WHERE perpre_codigo = '20180724_RCFIXO';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '60: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--61.-	CE/LP-T272-503/2018
	--		3871311
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'JACQUELINE' -- JACQELINE
	WHERE perpre_codigo = '20180817_QNLQFW';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '61: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  

  