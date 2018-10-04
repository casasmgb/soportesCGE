
--====================================================================================
	/*
	HOJA DE RUTA GNAF 3063/2018
	
	CENCAP/CI 552/2018
	MODIFICAR DATOS DE PERSONAS
	SISTEMA:SIGA
	27082018
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

CREATE OR REPLACE FUNCTION acceso_externo.hoja_ruta3063() 
  RETURNS void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN
  --1.-   'CE/LP-T277-510/2018'
		--  8890544
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T277-510/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad like '%8890544%' AND p.procur_codigo=1228
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_paterno='CALCINA' --CELINA                                     			
    WHERE pp.procur_codigo=1228 AND pp.perpre_numero_docidentidad='8890544';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '1:%',1;
	
  --2.-  'CE/LP-T125-470/2018'
		--  4982521
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T125-470/2018'
         
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procur_codigo in (364,968,1118,1177)
         SELECT * FROM acceso_externo.persona_preinscripcion p where p.perpre_numero_docidentidad like '4982521'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4329876' AND p.procur_codigo=631
		*/

  --3.-   'MU/BE-T06-450/2018'
		--  7615822
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T06-450/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad like '%7615822%' AND p.procur_codigo=1157
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='YERANIA' --YERANI                                    			
    WHERE pp.procur_codigo=1157 AND pp.perpre_numero_docidentidad='7615822';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '3:%',3;	
	
--4.-  'CE-LP-T257-483/2018'
		--  4071007
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T257-483/2018'
        
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procur_codigo in (1189)
         SELECT * FROM acceso_externo.persona_preinscripcion p where p.perpre_numero_docidentidad like '%4071007%'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '4071007' AND p.procur_codigo=1189
	*/
     _res := acceso_externo.changeCI('CE/LP-T257-483/2018','4071007-OR', '4071007');	
	
  --5.-  'MU/BE-T07-451/2018'
		--  4200530
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T07-451/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad='4200530-1J' AND p.procur_codigo=1158
		*/
        UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_numero_docidentidad='4200530-1J' --4200530	                                      			
	        WHERE pp.procur_codigo=1158 AND pp.perpre_numero_docidentidad='4200530';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
				
		--seteando la variable
		my_var:= 0;
		raise notice '18:%', 18;   
		
  --6.-  'MU/BE-T06-450/2018'
		--  4200530
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T06-450/2018'
        
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procur_codigo in (1157)
         SELECT * FROM acceso_externo.persona_preinscripcion p where p.perpre_numero_docidentidad like '%4071007%'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '4200530-1J' AND p.procur_codigo=1157
	*/
     _res := acceso_externo.changeCI('MU/BE-T06-450/2018','4200530', '4200530-1J');	 
    
   --7.-  'MU/BE-T05-449/2018'
		--  4200530
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T05-449/2018'
        
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procur_codigo in (1156)
         SELECT * FROM acceso_externo.persona_preinscripcion p where p.perpre_numero_docidentidad like '%4071007%'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '4200530-1J' AND p.procur_codigo=1156
	*/
     _res := acceso_externo.changeCI('MU/BE-T05-449/2018','4200530', '4200530-1J');	 
	
  --8.-   'CE/LP-T224-433/2018'
		--  9181108
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T224-433/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad = '9181108' AND p.procur_codigo=1140
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='LAURA ALEJANDRA' --ALEJANDRA                                    			
    WHERE pp.procur_codigo=1140 AND pp.perpre_numero_docidentidad='9181108';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '8:%',8;		
	
  --9.-   'MU/BE-T06-450/2018'
		--  5702034
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T06-450/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad = '5702034' AND p.procur_codigo=1157
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='IVONNE' --IVONEE                                    			
    WHERE pp.procur_codigo=1157 AND pp.perpre_numero_docidentidad='5702034';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 2	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '9:%',9;
	
 --10.-  'CE/LP-A38-577/2018'
		--  6999733
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-A38-577/2018'
        
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procur_codigo in (1156)
         SELECT * FROM acceso_externo.persona_preinscripcion p where p.perpre_numero_docidentidad like '%4071007%'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '6999733' AND p.procur_codigo=1285
	*/
     _res := acceso_externo.changeCI('CE/LP-A38-577/2018','699733', '6999733');		
	
 --11.-  'CE/LP-T10-630/2017'
		--  2335510
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-630/2017'
        
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procur_codigo in (1156)
         SELECT * FROM acceso_externo.persona_preinscripcion p where p.perpre_numero_docidentidad like '%4071007%'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '2335510' AND p.procur_codigo=631
	*/
     _res := acceso_externo.changeCI('CE/LP-T10-630/2017','2335510-LP', '2335510');		
	
  --12.-   'CE/TR-T01-058/2017'
		--  5830261
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/TR-T01-058/2017' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad = '5830261' AND p.procur_codigo=59
         */
     
  --13.-   'MU/BE-T06-450/2018'
		--  5605039
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T06-450/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad = '5605039' AND p.procur_codigo=1157
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_materno='MORAES' --MORALES                                    			
    WHERE pp.procur_codigo=1157 AND pp.perpre_numero_docidentidad='5605039';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 2	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '13:%',13;

 --14.-  'CE/LP-T310-552/2018'
		--  6961152
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T310-552/2018'
        
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad like '6961152%' AND p.procur_codigo=1272
	*/

  --15.-   'MU/BE-T06-450/2018'
		--  5627775
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T06-450/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad = '5627775' AND p.procur_codigo=1157
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='SASHIKO' --SACHIKO                                    			
    WHERE pp.procur_codigo=1157 AND pp.perpre_numero_docidentidad='5627775';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 2	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '15:%',15;	
    
  --16.-  'CE/OR-T11-589/2018'
		--  3060560
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/OR-T11-589/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad = '3060560' AND p.procur_codigo=1297
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_paterno='LOPEZ', -- CHOQUE
		perpre_apellido_materno='CHOQUE' -- LOPEZ
    WHERE pp.procur_codigo=1297 AND pp.perpre_numero_docidentidad='3060560';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '16:%',16;	    
	
 --17.-  'CE/LP-A30-546/2018'
		--  8339957
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-A30-546/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '8339957-LP' AND p.procur_codigo=1266
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_numero_docidentidad='8339957' -- 8339957-LP	                                      			
	        WHERE pp.procur_codigo=1266 AND pp.perpre_numero_docidentidad='8339957-LP';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 2	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
				
		--seteando la variable
		my_var:= 0;
		raise notice '17:%', 17;   

 --18.-  'CE/LP-T302-536/2018'
		--  3618064
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T302-536/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '3618064' AND p.procur_codigo=1256
	*/
        UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_apellido_esposo = '' -- PRUDENCIO	                                      			
	        WHERE pp.procur_codigo=1256 AND pp.perpre_numero_docidentidad='3618064';
	        
	        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
				
		--seteando la variable
		my_var:= 0;
		raise notice '18:%', 18;   
	
 --19.-  'CE/LP-T11-087/2018'
		--  6158398
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T11-087/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '6158398' AND p.procur_codigo=787
	*/
     _res := acceso_externo.changeCI('CE/LP-T11-087/2018','6158398-LP', '6158398');			
	
  --20.-  'CE/LP-T245-471/2018'
		--  10780160
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T245-471/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad like '10780160%' AND p.procur_codigo=1178
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_materno='ROSALES' -- ROSALAES
    WHERE pp.procur_codigo=1178 AND pp.perpre_numero_docidentidad='10780160-1P';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '20:%',20;
	
 --21.-  'CE/LP-T216-425/2018'
		--  3362232
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T216-425/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '3362232' AND p.procur_codigo=1132
	*/
     _res := acceso_externo.changeCI('CE/LP-T216-425/2018','3362232-CI', '3362232');	
	
  --22.-  'CE/LP-T10-359/2017'
		--  6724235
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-359/2017'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '6724235' AND p.procur_codigo=360
	*/
     _res := acceso_externo.changeCI('CE/LP-T10-359/2017','6724235-LP', '6724235');	
	
  --23.-  'CE/LP-T287-520/2018'
		--  3330027
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T287-520/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '3330027' AND p.procur_codigo=1240
	*/
     _res := acceso_externo.changeCI('CE/LP-T287-520/2018','330027', '3330027');		
	
  --24.-  'MU/BE-T05-449/2018'   MU/BE-T06-450/2018    MU/BE-T07-451/2018
		--  7605174
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/BE-T07-451/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '7605174-1P' AND p.procur_codigo=1240
	*/
     _res := acceso_externo.changeCI('MU/BE-T05-449/2018','7605174', '7605174-1P');
     _res := acceso_externo.changeCI('MU/BE-T06-450/2018','7605174', '7605174-1P');
     _res := acceso_externo.changeCI('MU/BE-T07-451/2018','7605174', '7605174-1P');

  --27.-  'CE/BE-T13-407/2018'
		--  3128454
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/BE-T13-407/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad like '3128454' AND p.procur_codigo=1114
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		dep_codigo_expedicion = 3 -- 1
    WHERE pp.procur_codigo=1114 AND pp.perpre_numero_docidentidad='3128454';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '27:%',27;    

  --28.-  'CE/LP-A20-311/2018'
		--  7048492
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-A20-311/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '7048492' AND p.procur_codigo=1018
	*/
     _res := acceso_externo.changeCI('CE/LP-A20-311/2018','76595081', '7048492');	
    
  --29.-  'CE/LP-T10-464/2017'
		--  4888659
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T10-464/2017'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '4888659' AND p.procur_codigo=465
	*/
     _res := acceso_externo.changeCI('CE/LP-T10-464/2017','4888659-LP', '4888659');	

END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  
 -- select * from acceso_externo.hoja_ruta3063()
  
  