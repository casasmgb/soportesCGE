
--====================================================================================
	/*
	HOJA DE RUTA GNAF 2645/2018
	SGSIR 528/2018
	CENCAP/CI 509/2018
	MODIFICAR DATOS DE PERSONAS
	SISTEMA:SIGA
	*/
--====================================================================================
CREATE OR REPLACE FUNCTION acceso_externo.changeCI(procurcod_sigla character varying, docidentidad_old character varying, docidentidad_new character varying) 
RETURNS void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
	_procurcod_sigla VARCHAR(30);
	_docidentidad_old VARCHAR(30);
	_docidentidad_new VARCHAR(30);
begin
	_procurcod_sigla := procurcod_sigla;
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
	
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad=_docidentidad_new	                                      			
        WHERE pp.procur_codigo=(SELECT procur_codigo FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla=_procurcod_sigla) 
       	AND pp.perpre_numero_docidentidad=_docidentidad_old;
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice 'Sigla : %',procurcod_sigla;
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
 -- select * from acceso_externo.changeCI('CE/LP-T171-340/2018','3430399-LP', '3430399')
	

CREATE OR REPLACE FUNCTION acceso_externo.hoja_ruta2645() 
  RETURNS void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
BEGIN

--============================================================================================================

--1.-  'CE/LP-T171-340/2018'
		--  3430399
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T171-340/2018' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3430399' AND p.procur_codigo=1047
	*/
     select * from acceso_externo.changeCI('CE/LP-T171-340/2018','3430399-LP', '3430399');

--2.-  'CE/LP-T245-471/2018'
		--  3646503
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T245-471/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3645503' AND p.procur_codigo=1178
	*/
     select * from acceso_externo.changeCI('CE/LP-T245-471/2018','3645503-CH', '3645503');

--3.-  'CE/LP-T277-510/2018'
		--  10680488
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T277-510/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='10680488' AND p.procur_codigo=1228
		*/
     select * from acceso_externo.changeCI('CE/LP-T277-510/2018','1868', '10680488');     
    
 --4.-'MU/TR-T20-319/2018'
	-- 7161625
	-- orlandocolquealarcon@gmail.com
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/TR-T20-319/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='7161625' AND p.procur_codigo=1026
    	*/
    select * from acceso_externo.changeCI('MU/TR-T20-319/2018','71061625', '7161625');
   
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_correo_electronico='orlandocolquealarcon@gmail.com' --Orlandocolque@gmail.com	                                      			
        WHERE pp.procur_codigo=1026 AND pp.perpre_numero_docidentidad='7161625';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '3:%',3;   
    
 --5.-  'CE/LP-T258-484/2018'
		--  6488973
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T258-484/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6488973' AND p.procur_codigo=1191
		*/
     select * from acceso_externo.changeCI('CE/LP-T258-484/2018','6488673', '6488973');   
    
 --6.-  'CE/LP-T10-618/2017'
		--  6996341
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-618/2017'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6996341' AND p.procur_codigo=619
		*/
     select * from acceso_externo.changeCI('CE/LP-T10-618/2017','6996341-LP', '6996341');    
    
  --7.-  'CE/LP-T285-518/2018'
		--  6996341
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T285-518/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='5995390' AND p.procur_codigo=1238
		*/
     select * from acceso_externo.changeCI('CE/LP-T285-518/2018','599530', '5995390');      
    
 --8.-  'CE/LP-T241-467/2018'
		--  6948000
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T241-467/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6948000' AND p.procur_codigo=1174
		*/
     select * from acceso_externo.changeCI('CE/LP-T241-467/2018','6948000-LP', '6948000');     
    
 --9.-  'CE/LP-T40-119/2018'
		--  3431803
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T40-119/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3431803' AND p.procur_codigo=826
		*/
     select * from acceso_externo.changeCI('CE/LP-T40-119/2018','3431803-LP', '3431803');
    
 --10.-  'CE/LP-T300-534/2018'
		--  6759019
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T300-534/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6759019' AND p.procur_codigo=1254
		*/
     select * from acceso_externo.changeCI('CE/LP-T300-534/2018','67559019', '6759019');

  --11.-  'CE/LP-T284-517/2018'
		--  6570392
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T284-517/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6570392' AND p.procur_codigo=1237
		*/
     select * from acceso_externo.changeCI('CE/LP-T284-517/2018','6570392-PT', '6570392');   

  --12.-  'CE/LP-T187-379/2018'
		--  8353969
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T187-379/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='8353969' AND p.procur_codigo=1086
		*/
     select * from acceso_externo.changeCI('CE/LP-T187-379/2018','8353969-LP', '8353969');

  --13.-   'CE/LP-A40-591/2018'
		--  3743109
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-A40-591/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='3743109' AND p.procur_codigo=1299
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='MABEL ELIANA' --MABEL ELINA	                                      			
    WHERE pp.procur_codigo=1299 AND pp.perpre_numero_docidentidad='3743109';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '13:%',13;
	
  --14.-  'CE/LP-T213-422/2018'
		--  6865053
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T213-422/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6865053' AND p.procur_codigo=1129
		*/
     select * from acceso_externo.changeCI('CE/LP-T213-422/2018','6865053-LP', '6865053');	
	
  --15.-  'CE/LP-T310-552/2018'
		--  8349320
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T310-552/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='8349320' AND p.procur_codigo=1272
		*/
     select * from acceso_externo.changeCI('CE/LP-T310-552/2018','8349320-LP', '8349320');	
    
  --16.-  'CE/LP-A19-310/2018'
		--  3339466
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-A19-310/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3339466' AND p.procur_codigo=1017
		*/
     select * from acceso_externo.changeCI('CE/LP-A19-310/2018','6110483', '3339466');	    
    
  --17.-  'CE/LP-T218-427/2018'
		--  2440639
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T218-427/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='2440639' AND p.procur_codigo=1134
		*/
     select * from acceso_externo.changeCI('CE/LP-T218-427/2018','2440639-LP', '2440639');
    
  --18.-  'CE/LP-T10-630/2017'
		--  2440639
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-630/2017'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4329876' AND p.procur_codigo=631
		*/
        UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_numero_docidentidad='4329876' --4329876-LP	                                      			
	        WHERE pp.procur_codigo=631 AND pp.perpre_numero_docidentidad='4329876-LP';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 2	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
				
		--seteando la variable
		my_var:= 0;
		raise notice '18:%', 18;   
    
  --19.-  'CE/LP-T310-552/2018'
		--  8349781
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T310-552/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='8349781' AND p.procur_codigo=1272
		*/
     select * from acceso_externo.changeCI('CE/LP-T310-552/2018','8349781-LP', '8349781');	
	
  --20.-  'CE/LP-T132-269/2018'
		--  1008488
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T132-269/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='10084428' AND p.procur_codigo=976
		*/
     select * from acceso_externo.changeCI('CE/LP-T132-269/2018','10084428', '10084428');		
	
	
    
    
    
    
    
    
    
    
    


	
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
		perpre_nombres='MARIA ALEJANDRA' --MARÃƒï¿½A ALEJANDRA	                                      			
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