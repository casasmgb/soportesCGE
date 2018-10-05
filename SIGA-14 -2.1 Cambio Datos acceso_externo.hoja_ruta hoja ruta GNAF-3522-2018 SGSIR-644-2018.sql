
--====================================================================================
	/*
	HOJA DE RUTA GNAF 3522/2018 SGSIR/644/2018
	
	CENCAP/CI-615/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 27/09/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	ESQUEMA: acceso_externo
	FECHA EJECUCION: 02/10/2018
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
	_perpre_codigo_unico  VARCHAR(30);
	_total INTEGER;
	_procurcod_sigla VARCHAR(30);
	_procur_codigo integer;
	_docidentidad_old VARCHAR(30);
	_docidentidad_new VARCHAR(30);
	_nro_registros_a_afectar INTEGER;
begin
	_procurcod_sigla := procurcod_sigla;
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
	_nro_registros_a_afectar := nro_registros;
	
	-- perpre_codigo del participante que esta inscrita
	/*SELECT p.perpre_codigo into _perpre_codigo
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 inner join seguimiento_capacitacion.personas_inscripcion as scpi
		 on p.perpre_codigo = scpi.perpre_codigo
		 where pcc.procurcod_sigla = _procurcod_sigla and p.perpre_numero_docidentidad = _docidentidad_old; 
		*/
		
	SELECT p.perpre_codigo into _perpre_codigo
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla=_procurcod_sigla and p.perpre_numero_docidentidad = _docidentidad_old;
	
	select perpre_codigo into _perpre_codigo_unico from acceso_externo.persona_preinscripcion pe WHERE pe.perpre_codigo IN  (_perpre_codigo) and pe.perpre_estado = 3;
		
	-- raise notice 'perpre_codigo: % ', _perpre_codigo;
	-- raise notice 'perpre_codigo_unico: % ', _perpre_codigo_unico;
	_new_pass := (select public.fn_encriptar_cadena(_docidentidad_new));
	raise notice 'cambiando contraseña: % ', _new_pass;
	
	update acceso_externo.cuenta_persona_inscripcion
	set cueperins_contrasenia = _new_pass
 		where perpre_codigo = _perpre_codigo_unico;
	GET DIAGNOSTICS my_var_pass := ROW_COUNT;
	-- si no es lo esperado , hacer un rollback
	IF my_var_pass != 1	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF;
	
	SELECT procur_codigo into _procur_codigo FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla=_procurcod_sigla;
   
	UPDATE acceso_externo.persona_preinscripcion pp
	SET 
		perpre_numero_docidentidad=_docidentidad_new	                                      			
        WHERE pp.procur_codigo=_procur_codigo 
       	AND pp.perpre_numero_docidentidad=_docidentidad_old;
        
        --obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var := ROW_COUNT;
	-- si no es lo esperado , hacer un rollback
	IF my_var != _nro_registros_a_afectar	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
			
	--seteando la variable
	my_var:= 0;
	raise notice 'ci: % cambiado por: %', _docidentidad_old, _docidentidad_new;
	
	EXCEPTION
			WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS _err_Mensaje := MESSAGE_TEXT;
				RAISE NOTICE 'Error de actualizacion :(%) ',_err_Mensaje;
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
 -- select * from acceso_externo.changeCI('CE/LP-T171-340/2018','3430399-LP', '3430399', 1)
	
--============================================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.hoja_ruta3522() 
 RETURNS character varying
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN
	
--1.-   'CE/LP-T292-525/2018'
		--  8422506
         
		_res := acceso_externo.changeCI('CE/LP-T292-525/2018','8422506-LP', '8422506', 1);	
		raise notice 'res: %',1;
	
--2.-   CE/LP-A36-575/2018
		--  2618019
		_res := acceso_externo.changeCI('CE/LP-T292-525/2018','1618019', '2618019', 1);	
		raise notice 'res: %',2;
	
--3, 4 .-   CE/LP-T180-370/2018  CE/LP-T82-214/2018
		--  2635486
		_res := acceso_externo.changeCI('CE/LP-T180-370/2018','2635486-LP', '2635486-1D', 2);	
		_res := acceso_externo.changeCI('CE/LP-T82-214/2018','2635486-LP', '2635486-1D', 1);	
		raise notice 'res: %, %',3,4;
--5.-   CE/LP-T226-435/2018
		--  7813441
		UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			dep_codigo_expedicion = 7
	    WHERE pp.procur_codigo=1142 AND pp.perpre_numero_docidentidad='7813441';
	
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 2	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		 		
		raise notice 'res: %',5;
	
	
	
--6.-   CE/LP-A57-733/2018
		--  8291280
		_res := acceso_externo.changeCI('CE/LP-A57-733/2018','8291280-LP', '8291280', 1);	
		raise notice 'res: %',6;
	
--7.-   CE/LP-T352-746/2018
		--  6120346
		
		UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			dep_codigo_expedicion = 2
	    WHERE pp.procur_codigo=1455 AND pp.perpre_numero_docidentidad='6120346' and perpre_codigo= '20180917_YXMMEX';
	
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		 		
		raise notice 'res: %',7;	 
--8.-   CE/LP-A46-631/2018
		--  8337325
		_res := acceso_externo.changeCI('CE/LP-A46-631/2018','8337325-LP', '8337325', 1);	
		raise notice 'res: %',8;
--9.-   CE/LP-A46-631/2018
		--  8442166
		_res := acceso_externo.changeCI('CE/LP-A46-631/2018','8442166-LP', '8442166', 1);
		raise notice 'res: %',9;
--10.-   CE/LP-A55-693/2018
		--  4916914
		_res := acceso_externo.changeCI('CE/LP-A55-693/2018','4516914', '4916914', 1);
		raise notice 'res: %',10;
--11.-   CE/LP-A46-631/2018
		--  9124316
		_res := acceso_externo.changeCI('CE/LP-A55-693/2018','9124316-LP', '9124316', 1);
		raise notice 'res: %',11;
--12.-   CE/PN-T04-669/2018
		--  4046386
	    UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_correo_electronico = 'machm2005@gmail.com'                              			
	    WHERE pp.procur_codigo=1377 AND pp.perpre_numero_docidentidad='4046386';
	
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		raise notice 'res: %',12;
--13.-  MU/LP-A04-623/2018
		--  3434254
		_res := acceso_externo.changeCI('MU/LP-A04-623/2018','343425', '3434254', 1);
		raise notice 'res: %',13;
--14.-  CE/CB-T24-700/2018
		--  4412354
		_res := acceso_externo.changeCI('CE/CB-T24-700/2018','4412354-CB', '4412354', 1);
		raise notice 'res: %',14;
--15.-  CE/LP-T354-749/2018
		--  5797532
		_res := acceso_externo.changeCI('CE/LP-T354-749/2018','2524661-LP', '2524661', 1);
		raise notice 'res: %',15;
--16.-  CE/LP-T295-528/2018
		--  2524661
		_res := acceso_externo.changeCI('CE/LP-T295-528/2018','57975312', '5797532', 1);
		raise notice 'res: %',16;
--18.- 	CE/LP-A46-631/2018
		--  11108271
		_res := acceso_externo.changeCI('CE/LP-T281-514/2018','11108271-LP', '11108271', 1);
		raise notice 'res: %',18;
--19.- 	MU/LP-T17-704/2018
		--  2603936
		_res := acceso_externo.changeCI('MU/LP-T17-704/2018','4603936', '2603936', 1);
		raise notice 'res: %',19;
--20.- 	CE/LP-A46-631/2018
		--  3381075
		_res := acceso_externo.changeCI('MU/LP-T17-704/2018','3381075-LP', '3381075', 1);
		raise notice 'res: %',20;
--21.- 	CE/PN-T04-669/2018
		--  4140745
		UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_correo_electronico = 'melinamirandaflores@gmail.com'                              			
	    WHERE pp.procur_codigo=1377 AND pp.perpre_numero_docidentidad='4140745';
	
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		 		
		raise notice 'res: %',21;
--22.- 	CE/LP-T292-525/2018
		--  6080974
		_res := acceso_externo.changeCI('CE/LP-T292-525/2018','6080974-LP', '6080974', 1);
		raise notice 'res: %',20;
--23.- 	CE/PN-T04-669/2018
		--  6120102
		UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_correo_electronico = 'luzmarpcz@gmail.com'                              			
	    WHERE pp.procur_codigo=1377 AND pp.perpre_numero_docidentidad='6120102';
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		 		
		raise notice 'res: %',23;
--24.- 	CE/PN-T05-670/2018
		--  6120102
		UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_correo_electronico = 'luzmarpcz@gmail.com'                              			
	    WHERE pp.procur_codigo=1378 AND pp.perpre_numero_docidentidad='6120102';
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		 		
		raise notice 'res: %',24;
--25.- 	CE/LP-A46-631/2018
		--  5973766
		_res := acceso_externo.changeCI('CE/LP-A46-631/2018','5973766-LP', '5973766', 1);	
		raise notice 'res: %',25;
--27.-   CE/PN-T04-669/2018
		--  5942123
	    UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_nombres = 'CINTHIA MABEL'   --CINTHIA                          			
	    WHERE pp.procur_codigo=598 AND pp.perpre_numero_docidentidad='5942123';
	
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		raise notice 'res: %',27;
--28.- 	CE/LP-T340-707/2018
		--  9212968
		
	    _res := acceso_externo.changeCI('CE/LP-T340-707/2018','9212968-LP', '9212968', 2);	
		raise notice 'res: %',28;
--29.- 	MU/TR-T09-042/2018
		--  7124105
		UPDATE acceso_externo.persona_preinscripcion pp
		SET 
			perpre_correo_electronico = 'm_a_jimenita_star_t@hotmail.com'                              			
	    WHERE pp.procur_codigo=743 AND pp.perpre_numero_docidentidad='7124105';
	
		        --obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var := ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ; 
		my_var:= 0;
		 		
		raise notice 'res: %',29;
--30.- 	CE/LP-A46-631/2018
		--  2225279
		
	    _res := acceso_externo.changeCI('CE/LP-A46-631/2018','225279', '2225279', 1);
		raise notice 'res: %',30;
--32.- 	CE/LP-T340-707/2018
		--  6757868
		
	    _res := acceso_externo.changeCI('CE/LP-T340-707/2018','6757868-LP', '6757868', 1);
		raise notice 'res: %',32;	
--33.- 	CE/LP-T303-537/2018
		--  10084428
		
	    _res := acceso_externo.changeCI('CE/LP-T303-537/2018','10084428-LP', '10084428', 1);
		raise notice 'res: %',33;	
--34.- 	CE/LP-T333-636/2018
		--  2525836
		
	    _res := acceso_externo.changeCI('CE/LP-T333-636/2018','2525836-LP', '2525836', 1);	
		raise notice 'res: %',34;	
--35.- 	CE/LP-A46-631/2018
		--  6952731
		
	    _res := acceso_externo.changeCI('CE/LP-A46-631/2018','6952731-LP', '6952731', 1);	
		raise notice 'res: %',35;	
--36.- 	CE/LP-A45-624/2018
		--  4788329
		
	    _res := acceso_externo.changeCI('CE/LP-A45-624/2018','4788239', '4788329', 1);	
		raise notice 'res: %',36;	
----.- 	CE/LP-A45-624/2018
		--  581241
		
	    _res := acceso_externo.changeCI('CE/LP-A45-624/2018','581241', '5801241', 1);	
		raise notice 'res: %',36;	
	
	/*
         SELECT p.*
         FROM acceso_externo.persona_preinscripcion p 
		 INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc
		 ON p.procur_codigo = pcc.procur_codigo
		 where pcc.procurcod_sigla='CE/LP-T82-214/2018' and p.perpre_numero_docidentidad = '4823439'
	*/	
	
	raise notice 'actualizados';
	return 'registros actualizados';
	
end;
$function$
  
 -- select * from acceso_externo.hoja_ruta3522()
  
  