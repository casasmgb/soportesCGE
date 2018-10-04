
--====================================================================================
	/*
	HOJA DE RUTA GNAF 3522/2018 SGSIR/644/2018
	
	CENCAP/CI-615/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 27/09/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	ESQUEMA: seguimiento_capacitacion
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 02/10/2018
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
	_per_codigopersona VARCHAR(30);
	_new_per_codigopersona VARCHAR(30);
BEGIN
	--setenado la variable
    my_var:= 0;
	_docidentidad_old := docidentidad_old;
	_docidentidad_new := docidentidad_new;
	_nro_registros_a_afectar := nro_registros;
 	SELECT per_codigopersona into _per_codigopersona FROM seguimiento_capacitacion.personas p
 	WHERE p.per_docidentidad LIKE _docidentidad_old;
 	
 	
	-- SELECT regexp_split_to_array(_per_codigopersona, '-') into _arr;
    select REPLACE (_per_codigopersona, _docidentidad_old, _docidentidad_new) into _new_per_codigopersona;
	 
	 
 	UPDATE seguimiento_capacitacion.personas p
	SET
		per_docidentidad = _docidentidad_new,
		per_codigopersona=_new_per_codigopersona
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
	raise notice '=======>>dociIdentidad: % per_codigopersona:  %', _docidentidad_old, _new_per_codigopersona;
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  -- select seguimiento_capacitacion.changeCI('3430399-LP', '3430399', 1);
  

-- ============================================================================================================

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.hoja_ruta3522() 
RETURNS character varying
 LANGUAGE plpgsql
 SECURITY DEFINER
 AS $function$
DECLARE 
	my_var INTEGER;
	_total INTEGER;
	_res VARCHAR(30);
BEGIN
	--setenado la variable
        my_var:= 0;
       
--1.-   'CE/LP-T292-525/2018'
		--  8422506
        _res = seguimiento_capacitacion.changeCI('8422506-LP', '8422506', 1); 
		raise notice 'res: %',1;
	
--2.-   CE/LP-A36-575/2018
		--  2618019
		_res = seguimiento_capacitacion.changeCI('1618019', '2618019', 1); 
		raise notice 'res: %',2;
	
--3, 4 .-   CE/LP-T180-370/2018  CE/LP-T82-214/2018
		--  2635486
		_res = seguimiento_capacitacion.changeCI('2635486-LP', '2635486-1D', 1); 
		raise notice 'res: %, %',3,4;
	
--6.-   CE/LP-A57-733/2018
		--  8291280
		_res = seguimiento_capacitacion.changeCI('8291280-LP', '8291280', 1); 
		raise notice 'res: %',6;
--7.-   CE/LP-T352-746/2018
		--  6120346
	 	UPDATE seguimiento_capacitacion.personas p
		SET
			dep_codigo_expedicion = 2 -- 7
	        WHERE p.per_docidentidad='6120346';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;
		raise notice 'res: %',7;	
--8.-   CE/LP-A46-631/2018
		--  8337325
		_res = seguimiento_capacitacion.changeCI('8337325-LP', '8337325', 1); 
		raise notice 'res: %',8;
--9.-   CE/LP-A46-631/2018
		--  8442166
		_res = seguimiento_capacitacion.changeCI('8442166-LP', '8442166', 1); 
		raise notice 'res: %',9;
--10.-   CE/LP-A55-693/2018
		--  4916914
		_res = seguimiento_capacitacion.changeCI('4516914', '4916914', 1); 
		raise notice 'res: %',10;
--11.-   CE/LP-A46-631/2018
		--  9124316
		_res = seguimiento_capacitacion.changeCI('9124316-LP', '9124316', 1);
		raise notice 'res: %',11;
--13.-  MU/LP-A04-623/2018
		--  3434254
		_res = seguimiento_capacitacion.changeCI('343425', '3434254', 1);
		raise notice 'res: %',13;
--15.-  CE/LP-T354-749/2018
		--  2524661
		_res = seguimiento_capacitacion.changeCI('2524661-LP', '2524661', 1);
		raise notice 'res: %',15;
--16.-  CE/LP-T295-528/2018
		--  5797532
		_res = seguimiento_capacitacion.changeCI('57975312', '5797532', 1);
		raise notice 'res: %',16;
--18.- 	CE/LP-A46-631/2018
		--  11108271
		_res = seguimiento_capacitacion.changeCI('11108271-LP', '11108271', 1);
		raise notice 'res: %',18;
--19.- 	MU/LP-T17-704/2018
		--  2603936
		_res = seguimiento_capacitacion.changeCI('4603936', '2603936', 1);
		raise notice 'res: %',19;
--20.- 	CE/LP-A46-631/2018
		--  3381075
		_res = seguimiento_capacitacion.changeCI('3381075-LP', '3381075', 1);
		raise notice 'res: %',20;
--22.- 	CE/LP-T292-525/2018
		--  6080974
		_res = seguimiento_capacitacion.changeCI('6080974-LP', '6080974', 1);
		raise notice 'res: %',20;
--25.- 	CE/LP-A46-631/2018
		--  5973766
		raise notice 'res: %',25;
--27.-   CE/PN-T04-669/2018
		--  5942123
	    UPDATE seguimiento_capacitacion.personas p
		SET
			per_nombres = 'CINTHIA MABEL'
	        WHERE p.per_docidentidad='5942123';
			
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN  
			RAISE EXCEPTION transaction_rollback;
		END IF ;
		raise notice 'res: %',27;
--28.- 	CE/LP-T340-707/2018
		--  9212968
		_res = seguimiento_capacitacion.changeCI('9212968-LP', '9212968', 1);
		raise notice 'res: %',28;
--30.- 	CE/LP-A46-631/2018
		--  2225279
		_res = seguimiento_capacitacion.changeCI('225279', '2225279', 1);
		raise notice 'res: %',30;
--31.- 	MU/TR-T11-063/2018
		--  5801241
		_res = seguimiento_capacitacion.changeCI('581241', '5801241', 1);
		raise notice 'res: %',31;	
		/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%4788239%'
		*/
--32.- 	CE/LP-T340-707/2018
		--  6757868
		_res = seguimiento_capacitacion.changeCI('6757868-LP', '6757868', 1);
		raise notice 'res: %',32;	
--34.- 	CE/LP-T333-636/2018
		--  2525836
		_res = seguimiento_capacitacion.changeCI('2525836-LP', '2525836', 1);
		raise notice 'res: %',34;	
--35.- 	CE/LP-A46-631/2018
		--  6952731
		_res = seguimiento_capacitacion.changeCI('6952731-LP', '6952731', 1);	
		raise notice 'res: %',35;	
--36.- 	CE/LP-A45-624/2018
		--  4788329
		_res = seguimiento_capacitacion.changeCI('4788239', '4788329', 1);	
		raise notice 'res: %',36;		
	/*     
	 	SELECT * FROM seguimiento_capacitacion.personas p
	 	WHERE p.per_docidentidad LIKE '%6531386%'
	*/	  
       	raise notice 'actualizados';
		return 'registros actualizados';
end;
$function$


  -- select * from seguimiento_capacitacion.hoja_ruta3522();