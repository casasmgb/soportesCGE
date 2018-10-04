--====================================================================================
	/*
	HOJA DE RUTA GNAF 2645/2018
	SGSIR 528/2018
	CENCAP/CI 509/2018
	MODIFICAR DATOS DE PERSONAS
	SISTEMA:SIGA
	*/
--====================================================================================
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.hoja_ruta2645() 
  RETURNS  void AS
$BODY$
DECLARE 
	my_var INTEGER  ;
	_total INTEGER;
BEGIN
	--setenado la variable
        my_var:= 0;
       
--1.-'MU/CB-T20-383/2018'
        /*     
 	SELECT * FROM seguimiento_capacitacion.personas p
 	WHERE p.per_docidentidad LIKE '%5210073%'
 	
 	**/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'FRANKLIN YERZY' --FRANKLIN YERSY		
        WHERE p.per_codigo = 22170 AND p.per_docidentidad='5210073';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '1:%',1;
	
--2.-   'CE/LP-T10-351/2017'
	--	4330346
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%4330346-LP%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '4330346', --4126986-TJ
		per_codigopersona='MIH4330346' --MIH4330346-LP
        WHERE p.per_codigo = 8128 AND p.per_docidentidad='4330346-LP';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '2:%',2;
	
	       
--3.- 	'CE/LP-T126-262/2018'
	--	6450113
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6450113%'
 	
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_apmaterno = 'CERNANTES' --CERNANTES		
        WHERE p.per_codigo = 20309 AND p.per_docidentidad='6450113';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '3:%',3;
	
		
--4.-  'CE/LP-T204-401/2018'
		--  4372174
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%4372774%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '4372174', --4372774
		per_codigopersona='TCD4372174' --TCD4372774
        WHERE p.per_codigo = 22542 AND p.per_docidentidad='4372774';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '4:%',4;
	
		
--5.-  'CE/LP-T211-412/2018'
		--  1087441
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%1087441-CH%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '1087441', --1087441-CH
		per_codigopersona='FND1087441' --FND1087441-CH
        WHERE p.per_codigo = 23283 AND p.per_docidentidad='1087441-CH';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '5:%',5;
	   
--6.-  'CE/LP-T242-468/2018'
		--  4917337
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%4917337-LP%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '4917337', --4917337-LP
		per_codigopersona='FCJ4917337' --FCJ4917337-LP
        WHERE p.per_codigo = 23580 AND p.per_docidentidad='4917337-LP';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '6:%',6;
	   
	
--7.-  'CE/LP-T286-519/2018'
		--  7247286
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%7247286-TJ%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '7247286', --7247286-TJ
		per_codigopersona='RLM7247286' --RLM7247286-TJ
        WHERE p.per_codigo = 24484 AND p.per_docidentidad='7247286-TJ';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '7:%',7;
	   
	
--8.-  'CE/LP-T249-475/2018'
		--  5637973
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%5637976%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '5637973', --5637976
		per_codigopersona='PLD5637973' --PLD5637976
        WHERE p.per_codigo = 23979 AND p.per_docidentidad='5637976';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '8:%',8;
	   
	       
--9.-'CE/LP-T245-471/2018'
	--10780160
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%10780160%'
 	
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_apmaterno = 'ROSALES' --ROSALAES		
        WHERE p.per_codigo = 23392 AND p.per_docidentidad='10780160-1P';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '9:%',9;
	
	
--10.-  'CE/LP-T10-545/2018'
		--  3389837
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%3389837%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '3389837', --3389837-LP
		per_codigopersona='RVM3389837' --RVM3389837-LP
        WHERE p.per_codigo = 12612 AND p.per_docidentidad='3389837-LP';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '10:%',10;
	   
--11.-  'CE/LP-T161-328/2018'
		--  2638143
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%2613143%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '2638143', --2613143
		per_codigopersona='SAL2638143' --SAL2613143
        WHERE p.per_codigo = 22381 AND p.per_docidentidad='2613143';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '11:%',11;
	   
	   
--12.-  'MU/TR-T19-264/2018'
		--  7117078
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%7117076%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '7117078', --7117076
		per_codigopersona='HMJ7117078' --HMJ7117076
        WHERE p.per_codigo = 22488 AND p.per_docidentidad='7117076';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '12:%',12;
	   
		   
--13.-  'CE/LP-T244-470/2018'
		--  7105077
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%70105077%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '7105077', --70105077
		per_codigopersona='_SA7105077' --_SA70105077
        WHERE p.per_codigo = 23046 AND p.per_docidentidad='70105077';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '13:%',13;
	   
--14.-'CE/LP-T212-413/2018'
	--	5902706
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5902706%'
 	
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_apmaterno = 'ROJAS' --ROCHA		
        WHERE p.per_codigo = 23723 AND p.per_docidentidad='5902706';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '14:%',14;
	
		   
--15.-'CE/LP-T202-399/2018'
	--	7486229
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%7486229%'
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'WILFREDO' --WILFEDO		
        WHERE p.per_codigo = 22751 AND p.per_docidentidad='7486229';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '15:%',15;
	
--16.-'CE/LP-T247-473/2018'
	--	5671511
        /*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%5671511%'
	 	*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_nombres = 'MARIA ALEJANDRA' --MARÍA ALEJANDRA		
        WHERE p.per_codigo = 17573 AND p.per_docidentidad='5671511';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
	--seteando la variable
	my_var:= 0;
	raise notice '16:%',16;
	
		   
--17.-  'CE/LP-T255-481/2018'
		--  6178697
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%61786970%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '6178697', --61786970
		per_codigopersona='SEE6178697' --SEE61786970
        WHERE p.per_codigo = 24563 AND p.per_docidentidad='61786970';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '17:%',17;
	   
		   
--18.-  'CE/LP-T245-471/2018'
		--  3417369
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%3417369%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '3417369', --3417369-LP
		per_codigopersona='ESL3417369' --ESL3417369-LP
        WHERE p.per_codigo = 23003 AND p.per_docidentidad='3417369-LP';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '18:%',18;
	   
		   
--19.-  'CE/LP-A29-544/2018'
		--  3392092
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%3392091%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '3392092', --3392091
		per_codigopersona='PSI3392092' --PSI3392091
        WHERE p.per_codigo = 24018 AND p.per_docidentidad='3392091';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '19:%',19;
	   
		   
--21.-  'CE/LP-T245-471/2018'
		--  4212316
        /* 
         SELECT * FROM seguimiento_capacitacion.personas p
 		 WHERE p.per_docidentidad LIKE '%4212316%'
 		*/
 	
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = '4212316', --4212316-PN
		per_codigopersona='MDM4212316' --MDM4212316-PN
        WHERE p.per_codigo = 23588 AND p.per_docidentidad='4212316-PN';
		
	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '21:%',21;
	   

	
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100


  -- select * from seguimiento_capacitacion.hoja_ruta2645();