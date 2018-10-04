
--====================================================================================
	/*
	HOJA DE RUTA GNAF 3347/2018 SGSIR/628/2018
	
	CENCAP/CI-583/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 14/09/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	FECHA EJECUCION: 17/09/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
--====================================================================================
CREATE OR REPLACE FUNCTION acceso_externo.changeCI(procurcod_sigla character varying, docidentidad_old character varying, docidentidad_new character varying, nro_registros INTEGER) 
RETURNS void AS
$BODY$
DECLARE 
	my_var INTEGER;
	my_var_pass INTEGER;
	_err_Mensaje CHARACTER VARYING (1000);
	_new_pass varchar(50);
	_perpre_codigo acceso_externo.persona_preinscripcion.perpre_codigo%TYPE;
	_total INTEGER;
	_procurcod_sigla VARCHAR(30);
	_docidentidad_old VARCHAR(30);
	_docidentidad_new VARCHAR(30);
	_nro_registros_a_afectar INTEGER;
begin
	_procurcod_sigla := procurcod_sigla;
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
	_nro_registros_a_afectar := nro_registros;
	
	_perpre_codigo := (SELECT p.perpre_codigo
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 inner join seguimiento_capacitacion.personas_inscripcion as scpi
		 on p.perpre_codigo = scpi.perpre_codigo
		 where pcc.procurcod_sigla = _procurcod_sigla and p.perpre_numero_docidentidad = _docidentidad_old); 
	
	_new_pass := (select public.fn_encriptar_cadena(_docidentidad_new));
	
	update acceso_externo.cuenta_persona_inscripcion
	set cueperins_contrasenia = _new_pass
 		where perpre_codigo = _perpre_codigo;
	GET DIAGNOSTICS my_var_pass = ROW_COUNT;	
	
	-- si no es lo esperado , hacer un rollback
	IF my_var_pass != 1	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad=_docidentidad_new	                                      			
        WHERE pp.procur_codigo=(SELECT procur_codigo FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla=_procurcod_sigla) 
       	AND pp.perpre_numero_docidentidad=_docidentidad_old;
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	
	-- si no es lo esperado , hacer un rollback
	IF my_var != _nro_registros_a_afectar	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice 'Sigla : %',procurcod_sigla;
	
	EXCEPTION
			WHEN transaction_rollback THEN
			RAISE NOTICE 'Rollback';
			WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS _err_Mensaje := MESSAGE_TEXT;
				RAISE NOTICE 'Error de actualizacion :(%) ',_err_Mensaje;
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
 -- select * from acceso_externo.changeCI('CE/LP-T171-340/2018','3430399-LP', '3430399', 1)
	
--============================================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.hoja_ruta3347() 
  RETURNS void AS
$BODY$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN
	
--1.-   'CE/BE-T04-152/2018'
		--  1693292
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/BE-T04-152/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad like '%1693292%' AND p.procur_codigo=859
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='MARTHA' --MIRTHA                                     			
    WHERE pp.procur_codigo=859 AND pp.perpre_numero_docidentidad='1693292';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '1:%',1;
	
--2.-   'CE/BE-T03-151/2018'
		--  1693292
         /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/BE-T03-151/2018' 
                 
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE
         p.perpre_numero_docidentidad like '%1693292%' AND p.procur_codigo=858
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='MARTHA' --MIRTHA                                     			
    WHERE pp.procur_codigo=858 AND pp.perpre_numero_docidentidad='1693292';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '1:%',1;
	
--3.-  'CE/CB-CS01-592/2018'
		--  6536386
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/CB-CS01-592/2018'
        
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procur_codigo in (1189)
         SELECT * FROM acceso_externo.persona_preinscripcion p where p.perpre_numero_docidentidad like '%4071007%'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '6536386' AND p.procur_codigo=1300
	*/
     _res := acceso_externo.changeCI('CE/CB-CS01-592/2018','6531386', '6536386', 1);	
	
--4.-  CE/CB-CS01-592/2018
		--  3728219
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/CB-CS01-592/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '207624' AND p.procur_codigo=1300
         
         
         
         select * from acceso_externo.cuenta_persona_inscripcion
			where perpre_codigo = '20180813_OSLDQH';
	*/
	_res := acceso_externo.changeCI('CE/CB-CS01-592/2018','207624', '3728219', 2);
	
--5.-  CE/CB-T04-307/2018
		--  4412354
        /*
         SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/CB-T04-307/2018'
         
         SELECT * FROM acceso_externo.persona_preinscripcion p 
         WHERE 
         p.perpre_numero_docidentidad = '4412354' AND p.procur_codigo=1014
	*/	
	
	_res := acceso_externo.changeCI('CE/CB-T04-307/2018','4412354-CB', '4412354', 2);
	
--6.-  CE/LP-A33-555/2018
		--  9227056
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-A33-555/2018' and p.perpre_numero_docidentidad = '9227056'
         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-A33-555/2018','9227056-LP', '9227056', 3);
	
--7.-  CE/LP-A35-558/2018
		--  2546125
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-A35-558/2018' and p.perpre_numero_docidentidad = '2546125'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-A35-558/2018','2545125-LP', '2546125', 1);	
	
--8.-   CE/LP-A37-576/2018
		--  3375524
         /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-A37-576/2018' and p.perpre_numero_docidentidad = '3375524'
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='MELECIO' --MELESIO                                     			
    WHERE pp.procur_codigo=1284 AND pp.perpre_numero_docidentidad='3375524';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '8:%',8;	
	
--9.-  CE/LP-A43-609/2018
		--  6934804
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-A43-609/2018' and p.perpre_numero_docidentidad = '6934804'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-A43-609/2018','6034804', '6934804', 1);		
	
--10.-  CE/LP-T208-405/2018
		--  3794958
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T208-405/2018' and p.perpre_numero_docidentidad = '3794958'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T208-405/2018','3794958-CB', '3794958', 1);			
	
--11.-  CE/LP-T216-425/2018
		--  7069778
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T216-425/2018' and p.perpre_numero_docidentidad = '7069778'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T216-425/2018','77069778', '7069778', 1);
	
--12.-   CE/LP-T228-437/2018
		--  7494458
         /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T228-437/2018' and p.perpre_numero_docidentidad = '7494458'
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_nombres='CLAUDIA VALERIA' --CLUDIA VALERIA                                     			
    WHERE pp.procur_codigo=1144 AND pp.perpre_numero_docidentidad='7494458';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '12:%',12;		
	
--13.-  CE/LP-T244-470/2018
		--  6952672
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T244-470/2018' and p.perpre_numero_docidentidad = '6952672'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T244-470/2018','6952672-LP', '6952672', 1);	
	
--14.-   CE/LP-T279-512/2018
		--  5749478
         /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T279-512/2018' and p.perpre_numero_docidentidad = '5749478'
         */
     
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_paterno = 'SIMON', --SIMON YUCRA
		perpre_apellido_materno = 'YUCRA'                                    			
    WHERE pp.procur_codigo=1230 AND pp.perpre_numero_docidentidad='5749478';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '14:%',14;	
	
--15.-  CE/LP-T281-514/2018
		--  4536110
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T281-514/2018' and p.perpre_numero_docidentidad = '4536110'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T281-514/2018','4336110', '4536110', 1);		
	
--16.-  CE/LP-T281-514/2018
		--  6505324
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T281-514/2018' and p.perpre_numero_docidentidad = '6505324'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T281-514/2018','6205324', '6505324', 1);			
	
--17.-  CE/LP-T292-525/2018
		--  6143878
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T292-525/2018' and p.perpre_numero_docidentidad = '6143878'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T292-525/2018','6143878-LP', '6143878', 1);			
		
--18.-  CE/LP-T293-526/2018
		--  4789607
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T293-526/2018' and p.perpre_numero_docidentidad = '4789607'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T293-526/2018','4748607', '4789607', 1);			
	
--19.-  CE/LP-T304-538/2018
		--  6734469
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T304-538/2018' and p.perpre_numero_docidentidad = '6734469'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T304-538/2018','6734469-LP', '6734469', 1);		
	
--20.-  CE/LP-T305-539/2018
		--  8441753
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T305-539/2018' and p.perpre_numero_docidentidad = '8441753'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T305-539/2018','8441735', '8441753', 1);			
	
--21.-  CE/LP-T31-073/2017
		--  8339957
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T31-073/2017' and p.perpre_numero_docidentidad = '8339957'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T31-073/2017','8339957-LP', '8339957', 1);		
	
--22.-  CE/LP-T313-559/2018
		--  2666977
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T313-559/2018' and p.perpre_numero_docidentidad = '2666977'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T313-559/2018','2666977-LP', '2666977', 1);		
	
--23.-  CE/LP-T314-573/2018
		--  678411
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T314-573/2018' and p.perpre_numero_docidentidad = '678411'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T314-573/2018','578411', '678411', 1);		

--24.-   CE/LP-T327-620/2018
		--  4269766
         /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T327-620/2018' and p.perpre_numero_docidentidad like '%4269766%'
         */
    
	_res := acceso_externo.changeCI('CE/LP-T327-620/2018','4269766-LP', '4269766', 1);	
	
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_apellido_paterno = 'LIMACHI', --ORTIZ
		perpre_apellido_materno = 'ORTIZ'  --LIMACHI                                  			
    WHERE pp.procur_codigo=1329 AND pp.perpre_numero_docidentidad='4269766';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '24:%',24;		
	
--25.-   CE/LP-T332-630/2018
		--  4804929
         /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T332-630/2018' and p.perpre_numero_docidentidad like '%4804929%'
         */
    	
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_correo_electronico = 'berthammy777@gmail.com'                              			
    WHERE pp.procur_codigo=1339 AND pp.perpre_numero_docidentidad='4804929';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '25:%',25;	
	
--26.-  CE/LP-T92-230/2017
		--  6724235
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T92-230/2017' and p.perpre_numero_docidentidad like '%6724235%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T92-230/2017','6724235-LP', '6724235', 2);
	
--27.-  CE/OR-T10-588/2018
		--  3559894
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/OR-T10-588/2018' and p.perpre_numero_docidentidad like '%3559894%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/OR-T10-588/2018','3554894', '3559894', 1);	
	
--28.-  CE/PN-T04-669/2018
		--  1761518
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/PN-T04-669/2018' and p.perpre_numero_docidentidad like '%1761518%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/PN-T04-669/2018','1761518-PD', '1761518', 1);	
	
--29.-   CE/SC-CS01-595/2018
		--  248175
         /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/SC-CS01-595/2018' and p.perpre_numero_docidentidad like '%248175%' and perpre_codigo= '20180813_BUUHXB'
         */
    	
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		dep_codigo_expedicion = 2
    WHERE pp.procur_codigo=1303 AND pp.perpre_numero_docidentidad='248175' and perpre_codigo= '20180813_BUUHXB';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '29:%',29;		
	
--30.-   CE/SC-CS01-595/2018
		--  2249057
         /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/SC-CS01-595/2018' and p.perpre_numero_docidentidad like '%2249057%' and perpre_codigo= '20180813_MXFOMW'
         */
    	
    UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		dep_codigo_expedicion = 2
    WHERE pp.procur_codigo=1303 AND pp.perpre_numero_docidentidad='2249057' and perpre_codigo= '20180813_MXFOMW';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '30:%',30;			
	
--31.-  CE/SC-CS01-595/2018
		--  4620939
        /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/SC-CS01-595/2018' and p.perpre_numero_docidentidad like '%4620939%' and p.perpre_codigo = '20180813_HJPSDX'  
		
	*/		
	
	UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad = '4620939' --3189320
    WHERE pp.procur_codigo=1303 AND pp.perpre_numero_docidentidad='3189320' and perpre_codigo= '20180813_HJPSDX';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '31:%',31;	
	
--32.-  CE/LP-T304-538/2018
		--  5803633
        /*
         SELECT pcc.procur_codigo, p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T304-538/2018' and p.perpre_numero_docidentidad = '5803633'        
	*/		
	
	UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad = '5803633', --58036333
		dep_codigo_expedicion =  6 --3
    WHERE pp.procur_codigo=1258 AND pp.perpre_numero_docidentidad='58036333';

	        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	my_var:= 0;
	raise notice '31:%',31;		
	
--33.-  MU/PN-T05-229/2017
		--  1767977
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='MU/PN-T05-229/2017' and p.perpre_numero_docidentidad like '%1767977%'         
	*/		
	
	_res := acceso_externo.changeCI('MU/PN-T05-229/2017','1767977-PD', '1767977', 1);
	
--34.-  MU/TR-T21-320/2018
		--  4126986
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='MU/TR-T21-320/2018' and p.perpre_numero_docidentidad like '%4126986%'         
	*/		
	
	--_res := acceso_externo.changeCI('MU/PN-T05-229/2017','1767977-PD', '1767977', 1);	
	
--35.-  CE/LP-A23-373/2018
		--  3544485
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-A23-373/2018' and p.perpre_numero_docidentidad like '%3544485%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-A23-373/2018','3544485-OR', '3544485', 2);		
	
--36.-  CE/LP-E05-302/2018
		--  5960390
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-E05-302/2018' and p.perpre_numero_docidentidad like '%5960390%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-E05-302/2018','5960930', '5960390', 1);	
	
--37.-  CE/LP-E05-302/2018
		--  6983958
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-E05-302/2018' and p.perpre_numero_docidentidad like '%6883958%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-E05-302/2018','6883958', '6983958', 1);	
	
--38.-  CE/LP-A35-558/2018
		--  6720102
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-A35-558/2018' and p.perpre_numero_docidentidad like '%6720102%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-A35-558/2018','6420102', '6720102', 2);		
	
--39.-  CE/LP-T82-214/2018
		--  4823439
        /*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T82-214/2018' and p.perpre_numero_docidentidad like '%4823439%'         
	*/		
	
	_res := acceso_externo.changeCI('CE/LP-T82-214/2018','4823439-LP', '4823439', 1);

END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  
 -- select * from acceso_externo.hoja_ruta3347()
  
  