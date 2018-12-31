--====================================================================================
	/*
	HOJA DE RUTA GNAF/5191/2018 SGSIR/842/2018
	CENCAP/CI-806/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 26/12/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 27/12/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	SELECT seguimiento_capacitacion.correccionDatos5191()  
	drop function seguimiento_capacitacion.correccionDatos5191()
	*/
--====================================================================================
/*
select	pcc.procurcod_sigla, 
		p.perpre_numero_docidentidad, 
		p.perpre_apellido_paterno, 
		p.perpre_apellido_materno, 
		p.* 
FROM acceso_externo.persona_preinscripcion p
INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
ON p.procur_codigo = pcc.procur_codigo 
WHERE pcc.procurcod_sigla = 'CE/LP-T93-231/2017' 
AND p.perpre_numero_docidentidad = '10917527-LP'
*/

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.correccionDatos5191()  
RETURNS SETOF objinformacion_afectada
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE 
	my_var INTEGER;
	total INTEGER;
	_mensaje CHARACTER VARYING(9000);
	_data_historico JSON;
	_err_Mensaje_detalle CHARACTER VARYING(8000);
	_obj_informacion_afectada public.objinformacion_afectada%rowtype;
BEGIN
	-- Tipo de dato de retorno
	SELECT	'',            -- inf_codigo VARCHAR(1000),
			'',            -- inf_complemento VARCHAR(1000),
			0,             -- err_existente INTEGER,
			'',            -- err_mensaje VARCHAR(1000),
			0              -- err_codigo INTEGER
	INTO _obj_informacion_afectada;
	my_var:=0;
	total:=0;
	
    --1.-   CE/LP-T367-801/2018
    --		4888820
    
    --2.-   CE/LP-A52-682/2018
    --		340250
    select seguimiento_capacitacion.changeCI('CE/LP-A52-682/2018', '0340250-LP','AGUILAR','GOMEZ', '340250', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --3.-   CE/LP-A64-807/2018
    --		340250
    select seguimiento_capacitacion.changeCI('CE/LP-A64-807/2018', '340250-LP','AGUILAR','GOMEZ', '340250', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --4.-   CE/LP-T435-951/2018
    --		4745501
	select seguimiento_capacitacion.changeCI('CE/LP-T435-951/2018', '4745501-LP','ALMANZA','ACNO', '4745501', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
	--5.-   CE/LP-T428-939/2018
    --		5108955
    select seguimiento_capacitacion.changeCI('CE/LP-T428-939/2018', '5108955-PT','BLANCO','VEDIA', '5108955', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --6.-   CE/BE-T27-907/2018
    --		1709697
    select seguimiento_capacitacion.changeCI('CE/BE-T27-907/2018', '1789697','BRAVO','BECERRA', '1709697', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --7.-   CE/LP-T380-821/2018
    --		6156950
    select seguimiento_capacitacion.changeCI('CE/LP-T380-821/2018', '6156950-LP','BUTRON','ARROYO', '6156950', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --8.-   MU/TR-T05-038/2018
    --		7255585
    select seguimiento_capacitacion.changeCI('MU/TR-T05-038/2018', '7255585-TJ','CASTRO','AGUILERA', '7255585', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --9.-   CE/LP-T416-914/2018
    --		6157781
    select seguimiento_capacitacion.changeCI('CE/LP-T416-914/2018', '6157781-LP','CHAVEZ','LIMACHI', '6157781', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
	--10.-  MU/LP-T29-757/2018
    --		4338759
    select seguimiento_capacitacion.changeCI('MU/LP-T29-757/2018', '4337759','CHUQUIMIA','QUISPE', '4338759', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --11.-  CE/LP-T382-823/2018
    --		5998612
    select seguimiento_capacitacion.changeCI('CE/LP-T382-823/2018', '5998612-LP','CLAURE','MOLINA', '5998612', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
    --12.-  CE/LP-A71-836/2018
    --		6198110 errado 6196110
    select seguimiento_capacitacion.changeCI('CE/LP-A71-836/20188', '6196110','CORI','MAMANI', '6198110', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;      
    --15.-  CE/LP-T409-894/2018
    --		6768073
    select seguimiento_capacitacion.changeCI('CE/LP-T409-894/2018', '6768073-LP','ESPINOZA','CHOQUE', '6768073', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --16.-  CE/CB-T23-699/2018
    --		3754942
    select seguimiento_capacitacion.changeCI('CE/CB-T23-699/2018', '37544942','FLORES','CORTEZ', '3754942', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --17.-  CE/LP-T332-630/2018
    --		3416880
    select seguimiento_capacitacion.changeCI('CE/LP-T332-630/2018', '3416880-LP','HUANCA','CRUZ', '3416880', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --18.-  CE/SC-T11-780/2018
    --		6358257
    --20.-  CE/PN-A06-679/2018
    --		4207006
    select seguimiento_capacitacion.changeCI('CE/PN-A06-679/2018', '42070069','MANU','ROCA', '4207006', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --21.-  CE/LP-T416-914/2018
    --		3972223
    select seguimiento_capacitacion.changeCI('CE/LP-T416-914/2018', '3972223-PT','ORIHUELA','SILVERTH', '3972223', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --23.-  CE/LP-T416-914/2018
    --		6133660
    select seguimiento_capacitacion.changeCI('CE/LP-T416-914/2018', '6133660-CI','QUENALLATA','PAYE', '6133660', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --24.-  CE/CH-T09-661/2018
    --		7478167
    select seguimiento_capacitacion.changeCI('CE/CH-T09-661/2018', '7478165','RIVAS','CABEZAS', '7478167', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --25.-  MU/LP-A09-850/2018
    --		4043564
    select seguimiento_capacitacion.changeCI('MU/LP-A09-850/2018', '4043564-OR','ROJAS','GARCIA', '4043564', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --26.-  CE/LP-T382-823/2018
    --		4872623
    select seguimiento_capacitacion.changeCI('CE/LP-T382-823/2018', '4872623-LP','ROJAS','BERNAL', '4872623', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --27.-  CE/LP-T366-799/2018
    --		1913662
    select seguimiento_capacitacion.changeCI('CE/LP-T366-799/2018', '1913665','SORIA','CUELLAR', '1913662', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --28.-  CE/LP-T416-914/2018
    --		6093819
    select seguimiento_capacitacion.changeCI('CE/LP-T416-914/2018', '6093819-CI','TAVEL','SAAVEDRA', '6093819', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    --29.-  CE/LP-T32-074/2017
    --		6944320
    select seguimiento_capacitacion.changeCI('CE/LP-T32-074/2017', '6944320-LP','TORREZ','CORI', '6944320', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;  
    
    --31.-  CE/LP-T422-932/2018
    --		3772590
    select seguimiento_capacitacion.changeCI('CE/LP-T422-932/2018', '3772590-CB','VARGAS','MONTAÑO', '3772590', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if; 
    --32.-  MU/LP-T28-756/2018
    --		6061571
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM seguimiento_capacitacion.personas pp WHERE pp.per_codigo = 32141
	) row1;
	
	INSERT INTO seguimiento_capacitacion.historico_participantes
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, 'seguimiento_capacitacion.personas', now(), 'Gabriel Casas M.', 'CORRECCION DE NOMBRES');
	
	UPDATE seguimiento_capacitacion.personas
   	set
   		per_nombres = 'EDDY ARIEL', --ADDY ARIEL
   		per_codigopersona = 'VLE6061571'
	WHERE per_codigo = 32141; 
	GET DIAGNOSTICS my_var = ROW_COUNT;
	RAISE NOTICE '32: % ', my_var;
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	total:=total+1;
	-- Retornamos los valores 
	_obj_informacion_afectada.inf_codigo		:= _mensaje;
	_obj_informacion_afectada.inf_complemento	:= 'SCRIPT FINALIZO';
	_obj_informacion_afectada.err_Existente		:= 0;
	_obj_informacion_afectada.err_Mensaje		:= _obj_informacion_afectada;
	_obj_informacion_afectada.err_codigo		:= total;
	RETURN NEXT _obj_informacion_afectada;

EXCEPTION
	WHEN transaction_rollback THEN
	BEGIN
		GET STACKED DIAGNOSTICS _obj_informacion_afectada.err_Codigo = RETURNED_SQLSTATE;                
		RAISE NOTICE 'Error actualizando datos :(%) ', _obj_informacion_afectada;                
                _obj_informacion_afectada.inf_codigo		:= -1;
                _obj_informacion_afectada.inf_complemento	:= 'error rollback';
		_obj_informacion_afectada.err_Existente		:= 1;
		_obj_informacion_afectada.err_Mensaje		:= _err_Mensaje;
                
		RETURN NEXT _obj_informacion_afectada;
	END;
			
	WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS _obj_informacion_afectada.err_Mensaje := MESSAGE_TEXT,
		_err_Mensaje_detalle := PG_EXCEPTION_CONTEXT;                
		RAISE NOTICE 'Error: (%)', _obj_informacion_afectada;                
		_obj_informacion_afectada.err_Existente		:= 1;
        _obj_informacion_afectada.inf_codigo		:= -1;
        _obj_informacion_afectada.inf_complemento	:= 'otro error';                
		RETURN NEXT _obj_informacion_afectada;
END;
$function$
