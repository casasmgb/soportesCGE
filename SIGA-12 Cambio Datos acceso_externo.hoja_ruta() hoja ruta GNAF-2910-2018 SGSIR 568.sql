
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
	
--============================================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.hoja_ruta2910() 
  RETURNS void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN

--1.-  'CE/LP-T171-340/2018'
		--  3430399
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T171-340/2018' --3
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3430399' AND p.procur_codigo=1047
	*/
     _res := acceso_externo.changeCI('CE/LP-T171-340/2018','3430399-LP', '3430399');

--2.-  'CE/LP-T245-471/2018'
		--  3645503
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T245-471/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3645503' AND p.procur_codigo=1178
	*/
     _res := acceso_externo.changeCI('CE/LP-T245-471/2018','3645503-CH', '3645503');

--3.-  'CE/LP-T277-510/2018'
		--  10680488
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T277-510/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='10680488' AND p.procur_codigo=1228
		*/
     _res := acceso_externo.changeCI('CE/LP-T277-510/2018','1868', '10680488');     
    
 --4.-'MU/TR-T20-319/2018'
	-- 7161625
	-- orlandocolquealarcon@gmail.com
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/TR-T20-319/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='7161625' AND p.procur_codigo=1026
    	*/
    _res := acceso_externo.changeCI('MU/TR-T20-319/2018','71061625', '7161625');
   
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
     _res := acceso_externo.changeCI('CE/LP-T258-484/2018','6488673', '6488973');   
    
 --6.-  'CE/LP-T10-618/2017'
		--  6996341
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-618/2017'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6996341' AND p.procur_codigo=619
		*/
     _res := acceso_externo.changeCI('CE/LP-T10-618/2017','6996341-LP', '6996341');    
    
  --7.-  'CE/LP-T285-518/2018'
		--  5995390
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T285-518/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='5995390' AND p.procur_codigo=1238
		*/
     _res := acceso_externo.changeCI('CE/LP-T285-518/2018','599530', '5995390');      
    
 --8.-  'CE/LP-T241-467/2018'
		--  6948000
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T241-467/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6948000' AND p.procur_codigo=1174
		*/
     _res := acceso_externo.changeCI('CE/LP-T241-467/2018','6948000-LP', '6948000');     
    
 --9.-  'CE/LP-T40-119/2018'
		--  3431803
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T40-119/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3431803' AND p.procur_codigo=826
		*/
     _res := acceso_externo.changeCI('CE/LP-T40-119/2018','3431803-LP', '3431803');
    
 --10.-  'CE/LP-T300-534/2018'
		--  6759019
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T300-534/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6759019' AND p.procur_codigo=1254
		*/
     _res := acceso_externo.changeCI('CE/LP-T300-534/2018','67559019', '6759019');

  --11.-  'CE/LP-T284-517/2018'
		--  6570392
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T284-517/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6570392' AND p.procur_codigo=1237
		*/
     _res := acceso_externo.changeCI('CE/LP-T284-517/2018','6570392-PT', '6570392');   

  --12.-  'CE/LP-T187-379/2018'
		--  8353969
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T187-379/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='8353969' AND p.procur_codigo=1086
		*/
     _res := acceso_externo.changeCI('CE/LP-T187-379/2018','8353969-LP', '8353969');

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
     _res := acceso_externo.changeCI('CE/LP-T213-422/2018','6865053-LP', '6865053');	
	
  --15.-  'CE/LP-T310-552/2018'
		--  8349320
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T310-552/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='8349320' AND p.procur_codigo=1272
		*/
     _res := acceso_externo.changeCI('CE/LP-T310-552/2018','8349320-LP', '8349320');	
    
  --16.-  'CE/LP-A19-310/2018'
		--  3339466
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-A19-310/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='3339466' AND p.procur_codigo=1017
		*/
     _res := acceso_externo.changeCI('CE/LP-A19-310/2018','6110483', '3339466');	    
    
  --17.-  'CE/LP-T218-427/2018'
		--  2440639
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T218-427/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='2440639' AND p.procur_codigo=1134
		*/
     _res := acceso_externo.changeCI('CE/LP-T218-427/2018','2440639-LP', '2440639');
    
  --18.-  'CE/LP-T10-630/2017'
		--  4329876
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
     _res := acceso_externo.changeCI('CE/LP-T310-552/2018','8349781-LP', '8349781');	
	
  --20.-  'CE/LP-T132-269/2018'
		--  1008488
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T132-269/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='10084428' AND p.procur_codigo=976
		*/
     _res := acceso_externo.changeCI('CE/LP-T132-269/2018','10084428', '10084428');
	
 --21.-'MU/TR-T20-319/2018'
	-- 4154734
	-- orlandocolquealarcon@gmail.com
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/TR-T20-319/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='4154734' AND p.procur_codigo=1026
    	*/
   
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_correo_electronico='albazur07@gmail.com' --albazur07@Dmail.com	                                      			
        WHERE pp.procur_codigo=1026 AND pp.perpre_numero_docidentidad='4154734';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '3:%',3;  
	
  --22.-  'CE/LP-T310-552/2018'
		--  6961152
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T310-552/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='6961152' AND p.procur_codigo=1272
		*/
     _res := acceso_externo.changeCI('CE/LP-T310-552/2018','6961152-LP', '6961152');	
	
  --23.-  'CE/LP-T244-470/2018'
		--  4982521
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T244-470/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4982521' AND p.procur_codigo=1177
		*/
     _res := acceso_externo.changeCI('CE/LP-T244-470/2018','4982521-LP', '4982521');
	
  --24.-'CE/OR-T11-589/2018'
	--  3060560
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/OR-T11-589/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad='3060560' AND p.procur_codigo=1297
         */
     
        UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_materno='CHOQUE', --LOPEZ
		perpre_apellido_paterno='LOPEZ' -- CHOQUE                               			
        WHERE pp.procur_codigo=1297 AND pp.perpre_numero_docidentidad='3060560';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '24:%',24;
	
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  
 -- select * from acceso_externo.hoja_ruta2910()