
--====================================================================================
	/*
	HOJA DE RUTA GNAF 3347/2018 SGSIR/628/2018
	
	CENCAP/CI-583/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 14/09/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 17/09/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
--====================================================================================
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.changeCI(docidentidad_old character varying, docidentidad_new character VARYING, nro_registros INTEGER) 
  RETURNS  void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_docidentidad_old VARCHAR(30);
	_docidentidad_new VARCHAR(30);
	_nro_registros_a_afectar INTEGER;
	_arr text[];
BEGIN
	--setenado la variable
    my_var:= 0;
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
	_nro_registros_a_afectar := nro_registros;
 	
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
	IF my_var != _nro_registros_a_afectar 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice 'dciIdentidad: %', _docidentidad_old;
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  -- select seguimiento_capacitacion.changeCI('3430399-LP', '3430399', 1);
  

-- ============================================================================================================
 	
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.hoja_ruta3347() 
  RETURNS  void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN
	--setenado la variable
        my_var:= 0;

       
--1.-   'CE/BE-T04-152/2018'
		--  1693292
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%1693292-1C%'
 	
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'MIRTHA' --MABEL ELINA		
        WHERE p.per_codigo = 26135 AND p.per_docidentidad='1693292-1C';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '1:%',1;   
	
--2.-   'CE/BE-T03-151/2018'
		--  1693292
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%1693292%'
 	
	 	*/
 	
--3.-  'CE/CB-CS01-592/2018'
		--  6536386
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6531386%'
 	
	 	*/
       
--4.-  CE/CB-CS01-592/2018
		--  3728219
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%207624%'
 	
 		SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_appaterno = 'NINA' and p.per_apmaterno = 'CABALLERO'
       
	 	*/       
       
--5.-   CE/CB-T04-307/2018
		--  4412354
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4412354%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('4412354-CB', '4412354', 1);
       
--6.-   CE/LP-A33-555/2018
		--  9227056
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%9227056%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('9227056-LP', '9227056', 1);
       
--7.-  CE/LP-A35-558/2018
		--  2546125
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%2546125%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('2545125-LP', '2546125', 1);       
       
--8.-   CE/LP-A37-576/2018
		--  3375524
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3375524%'
 	
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'MELECIO' --MELESIO
        WHERE p.per_codigo = 25427 AND p.per_docidentidad='3375524';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '8:%',8;   
	
--9.-  CE/LP-A43-609/2018
		--  6934804
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6934804%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '6934804', --
			per_codigopersona='QMV6934804' --
	        WHERE p.per_docidentidad='6034804';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
	
--10.-  CE/LP-T208-405/2018
		--  3794958
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3794958%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('3794958-CB', '3794958', 1);         
        
--11.-  CE/LP-T216-425/2018
		--  7069778
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%7069778%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '7069778', --
			per_codigopersona='CCN7069778' --
	        WHERE p.per_docidentidad='77069778';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;        
       
--12.-   CE/LP-T228-437/2018
		--  7494458
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%7494458%'
 	
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'CLAUDIA VALERIA' --MELESIO
        WHERE p.per_codigo = 10568 AND p.per_docidentidad='7494458';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '12:%',12; 
	
--13.-  CE/LP-T244-470/2018
		--  6952672
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6952672%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('6952672-LP', '6952672', 1);         
        		       
--14.-   CE/LP-T279-512/2018
		--  5749478
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5749478%'
        
	 	*/        
        	
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			per_appaterno = 'SIMON', -- SIMON YUCRA
			per_apmaterno = 'YUCRA', --
			per_codigopersona='SYC5749478' --S_C5749478
	        WHERE p.per_codigo = 24648 AND p.per_docidentidad='5749478';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		
		--seteando la variable
		my_var:= 0;
		raise notice '14:%',14;
	
--15.-  CE/LP-T281-514/2018
		--  4536110
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4536110%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '4536110', --
			per_codigopersona='HGR4536110' --
	        WHERE p.per_docidentidad='4336110';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;   	
        		       
--16.-  CE/LP-T281-514/2018
		--  6505324
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6505324%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '6505324', --
			per_codigopersona='UCF6505324' --
	        WHERE p.per_docidentidad='6205324';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;         
       
--17.-  CE/LP-T292-525/2018
		--  6143878
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6143878%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('6143878-LP', '6143878', 1);          
       
--18.-  CE/LP-T293-526/2018
		--  4789607
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4789607%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '4789607', --
			per_codigopersona='QGD4789607' --
	        WHERE p.per_docidentidad='4748607';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
	
--19.-  CE/LP-T304-538/2018
		--  6734469
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6734469%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('6734469-LP', '6734469', 1);   	
	
--20.-  CE/LP-T305-539/2018
		--  8441753
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%8441753%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '8441753', --
			per_codigopersona='CHG8441753' --
	        WHERE p.per_docidentidad='8441735';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 	
	
--21.-  CE/LP-T31-073/2017
		--  8339957
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%8339957%'
        
	 	*/
	
--22.-  CE/LP-T313-559/2018
		--  2666977
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%2666977%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('2666977-LP', '2666977', 1);   		
       
--23.-  CE/LP-T314-573/2018
		--  678411
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%678411%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '678411', --
			per_codigopersona='BVH678411' --
	        WHERE p.per_docidentidad='578411';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 	       
       
--24.-   CE/LP-T327-620/2018
		--  4269766
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4269766%'
        
	 	*/        
        	
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			per_appaterno = 'LIMACHI', -- ORTIZ
			per_apmaterno = 'ORTIZ', -- LIMACHI
			per_codigopersona='LOI4269766-LP' --OLI4269766-LP
	        WHERE p.per_codigo = 26644 AND p.per_docidentidad='4269766-LP';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		
		--seteando la variable
		my_var:= 0;
		raise notice '24:%',24;
	
		_res := seguimiento_capacitacion.changeCI('4269766-LP', '4269766', 1);
	
--25.-   CE/LP-T332-630/2018
		--  4804929
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4804929%'	
	
--26.-  CE/LP-T92-230/2017
		--  6724235
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6724235%'
        
	 	*/        	
       
--27.-  CE/OR-T10-588/2018
		--  3559894
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3559894%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '3559894', --3554894
			per_codigopersona='MCM3559894' --MCM3554894
	        WHERE p.per_docidentidad='3554894';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 	       
              
--28.-  CE/PN-T04-669/2018
		--  1761518
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%1761518%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('1761518-PD', '1761518', 1);	
       
--29.-   CE/SC-CS01-595/2018
		--  248175
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%248175%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			dep_codigo_expedicion = 2 -- 7
	        WHERE p.per_docidentidad='248175';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;
	
--30.-   CE/SC-CS01-595/2018
		--  2249057
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%2249057%'
 	
	 	*/
 	
 		UPDATE seguimiento_capacitacion.personas p
		SET
			dep_codigo_expedicion = 2 -- 7
	        WHERE p.per_docidentidad='2249057';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;
		
--32.-  CE/LP-T304-538/2018
		--  5803633
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5803633%'
        
	 	*/        
        	
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '5803633', --58036333
			per_codigopersona='MVA5803633', --MVA58036333
			dep_codigo_expedicion = 6 -- 3
	        WHERE p.per_docidentidad='58036333';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		
		--seteando la variable
		my_var:= 0;
		raise notice '32:%',32;
	
--33.-  MU/PN-T05-229/2017
		--  1767977
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%1767977%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('1767977-PD', '1767977', 1);			
	
--34.-  MU/TR-T21-320/2018
		--  4126986
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4126986%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('1767977-PD', '1767977', 1);			
	
--35.-  CE/LP-A23-373/2018
		--  3544485
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%3544485%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('3544485-OR', '3544485', 1);	
       
--36.-  CE/LP-E05-302/2018
		--  5960390
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5960390%'
        
	 	*/        
        	
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '5960390', --5960930
			per_codigopersona='QRL5960390', --QRL5960930
			dep_codigo_expedicion = 6 -- 3
	        WHERE p.per_docidentidad='5960930';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		
		--seteando la variable
		my_var:= 0;
		raise notice '36:%',36;
	       
--37.-  CE/LP-E05-302/2018
		--  6983958
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6983958%'
        
	 	*/        
        	
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '6983958', --6883958
			per_codigopersona='GMJ6983958', --GMJ6883958
			dep_codigo_expedicion = 6 -- 3
	        WHERE p.per_docidentidad='6883958';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		
		--seteando la variable
		my_var:= 0;
		raise notice '37:%',37;       
       
--38.-  CE/LP-A35-558/2018
		--  6720102
		
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6720102%'
        
	 	*/        
        	
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = '6720102', --6420102
			per_codigopersona='PCF6720102', --GMJ6883958
			dep_codigo_expedicion = 6 -- 3
	        WHERE p.per_docidentidad='6420102';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		
		--seteando la variable
		my_var:= 0;
		raise notice '38:%',38;           
	
--39.-  CE/LP-T82-214/2018
		--  4823439
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4823439%'
        
	 	*/        
        _res := seguimiento_capacitacion.changeCI('4823439-LP', '4823439', 1);		
	
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
--1.-   'CE/BE-T04-152/2018'
		--  1693292
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