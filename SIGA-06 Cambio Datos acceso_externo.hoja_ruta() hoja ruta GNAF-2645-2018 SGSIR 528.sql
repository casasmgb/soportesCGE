
--====================================================================================
	/*
	HOJA DE RUTA GNAF 2645/2018
	SGSIR 528/2018
	CENCAP/CI 509/2018
	MODIFICAR DATOS DE PERSONAS
	SISTEMA:SIGA
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.hoja_ruta2645() 
  RETURNS  void AS
$BODY$
DECLARE 
	my_var INTEGER  ;
	_total INTEGER;
BEGIN

	
	--2.-  'CE/LP-T10-351/2017'
		--  4330346
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-351/2017' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4330346' AND p.procur_codigo=350
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='4330346' --4330346-LP	                                      			
        WHERE pp.procur_codigo=350 AND pp.perpre_numero_docidentidad='4330346-LP';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 2	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '2:%',2;       

       

--3.-'CE/LP-T126-262/2018'
	--6450113
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T126-262/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='6450113' AND p.procur_codigo=969
         */
     
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_materno='CERVANTES' --CERNANTES	                                      			
        WHERE pp.procur_codigo=969 AND pp.perpre_numero_docidentidad='6450113';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '3:%',3;
	
--4.-  'CE/LP-T204-401/2018'
		--  4372174
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T204-401/2018' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4372774' AND p.procur_codigo=1108
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='4372174' --4372774	                                      			
        WHERE pp.procur_codigo=1108 AND pp.perpre_numero_docidentidad='4372774';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '4:%',4;   

--5.-  'CE/LP-T211-412/2018'
		--  1087441
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T211-412/2018' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='1087441-CH' AND p.procur_codigo=1119
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='1087441' --1087441-CH	                                      			
        WHERE pp.procur_codigo=1119 AND pp.perpre_numero_docidentidad='1087441-CH';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '5:%',5; 
	
--6.-  'CE/LP-T242-468/2018'
		--  4917337
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T242-468/2018' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4917337-LP' AND p.procur_codigo=1175
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='4917337' --4917337-LP
        WHERE pp.procur_codigo=1175 AND pp.perpre_numero_docidentidad='4917337-LP';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '6:%',6; 
	
		
--7.-  'CE/LP-T286-519/2018'
		--  7247286
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T286-519/2018' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='7247286-TJ' AND p.procur_codigo=1239
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='7247286' --7247286-TJ	                                      			
        WHERE pp.procur_codigo=1239 AND pp.perpre_numero_docidentidad='7247286-TJ';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '7:%',7; 
	
--8.-  'CE/LP-T249-475/2018'
		--  5637973
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T249-475/2018' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='5637976' AND p.procur_codigo=1182
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='5637973' --5637976
        WHERE pp.procur_codigo=1182 AND pp.perpre_numero_docidentidad='5637976';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '8:%',8; 
	

--9.-'CE/LP-T245-471/2018'
	--10780160
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T245-471/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='10780160-1P' AND p.procur_codigo=1178
         */
     
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_materno='ROSALES' --ROSALAES	                                      			
        WHERE pp.procur_codigo=1178 AND pp.perpre_numero_docidentidad='10780160-1P';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '9:%',9;
	
	
--10.-  'CE/LP-T10-545/2018'
		--  3389837
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-545/2017' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3389837-LP' AND p.procur_codigo=547
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='3389837' --3389837-LP
        WHERE pp.procur_codigo=547 AND pp.perpre_numero_docidentidad='3389837-LP';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '10:%',10; 
	
--11.-  'CE/LP-T161-328/2018'
		--  2638143
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T161-328/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='2613143' AND p.procur_codigo=1035
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='2638143' --2613143
        WHERE pp.procur_codigo=1035 AND pp.perpre_numero_docidentidad='2613143';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '11:%',11; 
	
	
--12.-  'MU/TR-T19-264/2018'
		--  7117078
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/TR-T19-264/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='7117076' AND p.procur_codigo=971
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='7117078' --7117076
        WHERE pp.procur_codigo=971 AND pp.perpre_numero_docidentidad='7117076';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '12:%',12; 
	
--13.-  'CE/LP-T244-470/2018'
		--  7105077
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T244-470/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='70105077' AND p.procur_codigo=1177
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='7105077' --70105077
        WHERE pp.procur_codigo=1177 AND pp.perpre_numero_docidentidad='70105077';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 2	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '13:%',13; 
	
	
	
--14.-'CE/LP-T212-413/2018'
	--	5902706
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T212-413/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='5902706' AND p.procur_codigo=1120
         */
     
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_materno='ROJAS' --ROCHA	                                      			
        WHERE pp.procur_codigo=1120 AND pp.perpre_numero_docidentidad='5902706';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '14:%',14;
	
--15.-'CE/LP-T202-399/2018'
	--	7486229
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T202-399/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='7486229' AND p.procur_codigo=1106
         */
     
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='WILFREDO' --WILFEDO	                                      			
        WHERE pp.procur_codigo=1106 AND pp.perpre_numero_docidentidad='7486229';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '15:%',15;
	
	
--16.-'CE/LP-T247-473/2018'
	--	5671511
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T247-473/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='5671511' AND p.procur_codigo=1180
         */
     
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='MARIA ALEJANDRA' --MARÃ�A ALEJANDRA	                                      			
        WHERE pp.procur_codigo=1180 AND pp.perpre_numero_docidentidad='5671511';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '16:%',16;
	
--17.-  'CE/LP-T255-481/2018'
		--  6178697
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T255-481/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='61786970' AND p.procur_codigo=1188
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='6178697' --61786970
        WHERE pp.procur_codigo=1188 AND pp.perpre_numero_docidentidad='61786970';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '17:%',17; 
	
	
--18.-  'CE/LP-T245-471/2018'
		--  3417369
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T245-471/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3417369-LP' AND p.procur_codigo=1178
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='3417369' --3417369-LP
        WHERE pp.procur_codigo=1178 AND pp.perpre_numero_docidentidad='3417369-LP';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '18:%',18; 
	
	
		
--19.-  'CE/LP-A29-544/2018'
		--  3392092
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-A29-544/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3392091' AND p.procur_codigo=1264
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='3392092' --3392091
        WHERE pp.procur_codigo=1264 AND pp.perpre_numero_docidentidad='3392091';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '19:%',19; 
	
	
--20.-  'CE/LP-T255-481/2018'
		--  6162613
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T255-481/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6178697' AND p.procur_codigo=1188  and p.perpre_codigo_preinscripcion = 'KJMHMU'
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='6162613' --6178697
        WHERE pp.procur_codigo=1188 AND pp.perpre_numero_docidentidad='6178697' and pp.perpre_codigo_preinscripcion = 'KJMHMU';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '20:%',20; 
	
	
		
--21.-  'CE/LP-T245-471/2018'
		--  4212316
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T245-471/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4212316-PN' AND p.procur_codigo=1178
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad='4212316' --4212316-PN
        WHERE pp.procur_codigo=1178 AND pp.perpre_numero_docidentidad='4212316-PN';
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice '21:%',21; 
	
	
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  
 --select * from acceso_externo.hoja_ruta2645()