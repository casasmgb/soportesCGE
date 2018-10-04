
--====================================================================================
	/*
	HOJA DE RUTA GNAF 2910/2018
	SGSIR 568/2018
	CENCAP/CI 529/2018
	MODIFICAR DATOS DE PERSONAS
	SISTEMA:SIGA
	16082018
	*/
--====================================================================================
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.changeCI(docidentidad_old character varying, docidentidad_new character varying) 
  RETURNS  void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_docidentidad_old VARCHAR(30);
	_docidentidad_new VARCHAR(30);
	_arr text[];
BEGIN
	--setenado la variable
    my_var:= 0;
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
 	
	SELECT regexp_split_to_array((SELECT per_codigopersona FROM seguimiento_capacitacion.personas p
 	WHERE p.per_docidentidad LIKE _docidentidad_old), '-') into _arr;
     
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = _docidentidad_new,
		per_codigopersona=_arr[1]
        WHERE p.per_codigo = (SELECT per_codigo FROM seguimiento_capacitacion.personas p
 	WHERE p.per_docidentidad LIKE _docidentidad_old) AND p.per_docidentidad=_docidentidad_old;
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice 'dciIdentidad: %', _docidentidad_old;
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  -- select seguimiento_capacitacion.changeCI('3430399-LP', '3430399');
  

-- ============================================================================================================
 	
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.hoja_ruta3063() 
  RETURNS  void AS
$BODY$
DECLARE 
	my_var INTEGER  ;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN
	--setenado la variable
        my_var:= 0;
       
  --1.-   'CE/LP-T277-510/2018'
		--  8890544
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%8890544%'
 		*/
 	
  --2.-  'CE/LP-T125-470/2018'
		--  4982521
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%4982521%'
 		*/	
		
	
  --3.-   'MU/BE-T06-450/2018'
		--  7615822
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%7615822%'
 	
	 	*/
 	
  --4.-  'CE-LP-T257-483/2018'
		--  4071007
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4071007%'
 	
	 	*/
		_res :=  seguimiento_capacitacion.changeCI('4071007-OR', '4071007');
	
  --5, 6, 7.-  'MU/BE-T07-451/2018'
		--  4200530
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4200530%'
 	
	 	*/

  --8.-   'CE/LP-T224-433/2018'
		--  9181108
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%9181108%'
 	
	 	*/	
	
  --9.-   'MU/BE-T06-450/2018'
		--  5702034
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5702034%'
 	
	 	*/		
	
 --10.-  'CE/LP-A38-577/2018'
		--  6999733
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6999733%'
 		
	 	*/			
	
		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '6999733', --
			per_codigopersona='CCD6999733' --
	        WHERE p.per_docidentidad='699733';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
	
 --11.-  'CE/LP-T10-630/2017'
		--  2335510
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%2335510%'
 	
	 	*/
		_res := seguimiento_capacitacion.changeCI('2335510-LP', '2335510');	
	
  --12.-   'CE/TR-T01-058/2017'
		--  5830261
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5830261%'
 	
	 	*/	
	
  --13.-   'MU/BE-T06-450/2018'
		--  5605039
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5605039%'
 	
	 	*/		
	
 --14.-  'CE/LP-T310-552/2018'
		--  6961152
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6961152%'
 	
	 	*/			
	
  --15.-   'MU/BE-T06-450/2018'
		--  5627775
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5627775%'
 	
	 	*/		
	
  --16.-  'CE/OR-T11-589/2018'
		--  3060560
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3060560%'
 	
	 	*/		
	
	
 --17.-  'CE/LP-A30-546/2018'
		--  8339957
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%8339957%'
 	
	 	*/	
		_res := seguimiento_capacitacion.changeCI('8339957-LP', '8339957');
	
 --18.-  'CE/LP-T302-536/2018'
		--  3618064
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3618064%'
 
	 	*/	
	
 --19.-  'CE/LP-T11-087/2018'
		--  6158398
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6158398%'
 
	 	*/
		_res := seguimiento_capacitacion.changeCI('6158398-LP', '6158398');
	
 --20.-  'CE/LP-T245-471/2018'
		--  10780160
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%10780160%'
 
	 	*/

 --21.-  'CE/LP-T216-425/2018'
		--  3362232
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3362232%'
 
	 	*/
		_res := seguimiento_capacitacion.changeCI('3362232-CI', '3362232');
	
 --22.-  'CE/LP-T10-359/2017'
		--  6724235
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6724235%'
 
	 	*/
		_res := seguimiento_capacitacion.changeCI('6724235-LP', '6724235');
	
 --23.-  'CE/LP-T287-520/2018'
		--  3330027
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3330027%'	
	 	*/
		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '3330027', --
			per_codigopersona='VAC3330027' --
	        WHERE p.per_docidentidad='330027';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
	
 --24.-  'MU/BE-T05-449/2018'   MU/BE-T06-450/2018    MU/BE-T07-451/2018
		--  7605174
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%7605174%'	
	 	*/	
	
 --27.-  'CE/BE-T13-407/2018'
		--  3128454
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3128454%'	
	 	*/	
		UPDATE seguimiento_capacitacion.personas p
		SET
			dep_codigo_expedicion = 3
	        WHERE p.per_docidentidad='3128454';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;
	
 --28.-  'CE/LP-A20-311/2018'
		--  7048492
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%7048492%'	
	 	*/
		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '7048492', --
			per_codigopersona='CCG7048492' --
	        WHERE p.per_docidentidad='76595081';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
	
 --29.-  'CE/LP-T10-464/2017'
		--  4888659
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4888659%'	
	 	*/	
		_res := seguimiento_capacitacion.changeCI('4888659-LP', '4888659');
	
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100


  -- select * from seguimiento_capacitacion.hoja_ruta3063();