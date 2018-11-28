	--6.-	CE/LP-T392-862/2018
	--		2448749
DO $$
DECLARE 
my_var INTEGER;
_data_historico json;
_old_ci  CHARACTER VARYING(10);
_new_ci  CHARACTER VARYING(10);
_paterno CHARACTER VARYING(50);
_materno CHARACTER VARYING(50);
_per_codigopersona CHARACTER VARYING(20);

-- select * from seguimiento_capacitacion.personas where per_docidentidad like '%2448749%'; 
begin
	_old_ci:= '2448749-LP';
	_new_ci:= '2448749';
	_paterno:='SALINAS';
	_materno:='SARAVIA';
	_per_codigopersona:='SSV2448749';
	

	SELECT row_to_json (row1) INTO _data_historico 
	FROM (
	    SELECT * FROM seguimiento_capacitacion.personas p WHERE p.per_docidentidad= _old_ci
	    AND p.per_appaterno = _paterno 
	    AND p.per_apmaterno = _materno
	) row1;
	raise notice '_data_historico %', _data_historico;
	INSERT INTO seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico,'seguimiento_capacitacion.personas' ,now(), 'Gabriel Casas M.', 'Cambio de CI');
	 	
	UPDATE seguimiento_capacitacion.personas p
		SET
			per_docidentidad = _new_ci,
			per_codigopersona=_per_codigopersona
	        WHERE p.per_docidentidad=_old_ci 
	        AND p.per_appaterno = _paterno 
	        AND p.per_apmaterno = _materno;
		--obteniendo cuantas filas fueron afectadas
		GET DIAGNOSTICS my_var = ROW_COUNT;	
				
		-- si no es lo esperado , hacer un rollback
		IF my_var != 1 	THEN
			raise notice 'Transaccion Roll Back';
			RAISE EXCEPTION transaction_rollback;
		END IF ;
END
$$;
