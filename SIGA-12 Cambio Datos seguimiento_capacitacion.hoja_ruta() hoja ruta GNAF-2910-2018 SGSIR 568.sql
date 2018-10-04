
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
 	
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.hoja_ruta2910() 
  RETURNS  void AS
$BODY$
DECLARE 
	my_var INTEGER  ;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN
	--setenado la variable
        my_var:= 0;
       
--1.-  'CE/LP-T171-340/2018'
	--  3430399
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%3430399%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '3430399', --3430399-LP
		per_codigopersona='POM3430399' --POM3430399-LP
        WHERE p.per_docidentidad='3430399-LP';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '1:%',1;
	
--2.-  'CE/LP-T245-471/2018'
		--  3645503	
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%3645503%'
 		*/	
	_res := seguimiento_capacitacion.changeCI('3645503-CH', '3645503');
	
 --4.-'MU/TR-T20-319/2018'
	-- 7161625
	-- orlandocolquealarcon@gmail.com	
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%7161625%'
 		*/	
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '7161625', --
		per_codigopersona='CAO7161625' --
        WHERE p.per_docidentidad='71061625';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '3:%',3;
	
 --5.-  'CE/LP-T258-484/2018'
		--  6488973
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%6488973%'
 		*/	
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '6488973', --
		per_codigopersona='CAO6488973' --
        WHERE p.per_docidentidad='6488673';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '5:%',5;	
	
 --6.-  'CE/LP-T10-618/2017'
		--  6996341
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%6996341%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('6996341-LP', '6996341');
	
  --7.-  'CE/LP-T285-518/2018'
		--  6996341
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%599530%'
 		*/	
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '5995390', --
		per_codigopersona='FQE5995390' --
        WHERE p.per_docidentidad='599530';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '7:%',7;		
	
 --8.-  'CE/LP-T241-467/2018'
		--  6948000
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%6948000%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('6948000-LP', '6948000');	
	
 --9.-  'CE/LP-T40-119/2018'
		--  3431803
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%3431803%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('3431803-LP', '3431803');		

 --10.-  'CE/LP-T300-534/2018'
		--  6759019
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%6759019%'
 		*/	
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '6759019', --
		per_codigopersona='LFG6759019' --
        WHERE p.per_docidentidad='67559019';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '10:%',10;	
	
  --11.-  'CE/LP-T284-517/2018'
		--  6570392
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%6570392%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('6570392-PT', '6570392');	
	
  --12.-  'CE/LP-T187-379/2018'
		--  8353969
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%8353969%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('8353969-LP', '8353969');		
	
  --13.-   'CE/LP-A40-591/2018'
		--  3743109
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3743109%'
 	
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'MABEL ELIANA' --MABEL ELINA		
        WHERE p.per_codigo = 17606 AND p.per_docidentidad='3743109';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '13:%',13;
	
  --14.-  'CE/LP-T213-422/2018'
		--  6865053
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%6865053%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('6865053-LP', '6865053');	
	
  --15.-  'CE/LP-T310-552/2018'
		--  8349320
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%8349320%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('8349320-LP', '8349320');	
	
  --16.-  'CE/LP-A19-310/2018'
		--  3339466
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%3339466%'
 		*/	
	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '3339466', --
		per_codigopersona='RFV3339466' --
        WHERE p.per_docidentidad='6110483';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '16:%',16;	
	
  --17.-  'CE/LP-T218-427/2018'
		--  2440639
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%2440639%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('2440639-LP', '2440639');	

  --18.-  'CE/LP-T10-630/2017'
		--  4329876
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%4329876%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('4329876-LP', '4329876');	
	
  --19.-  'CE/LP-T310-552/2018'
		--  8349781
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%8349781%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('8349781-LP', '8349781');	
		
	
  --22.-  'CE/LP-T310-552/2018'
		--  6961152
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%6961152%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('6961152-LP', '6961152');	
	
  --23.-  'CE/LP-T244-470/2018'
		--  4982521
		/* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%4982521%'
 		*/		
	_res :=  seguimiento_capacitacion.changeCI('4982521-LP', '4982521');	
	
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100


  -- select * from seguimiento_capacitacion.hoja_ruta2910();