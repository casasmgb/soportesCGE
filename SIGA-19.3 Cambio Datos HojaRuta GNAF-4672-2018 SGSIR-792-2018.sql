--====================================================================================
	/*
	HOJA DE RUTA GNAF 4387/2018 SGSIR/761/2018
	CENCAP/CI-712/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 15/11/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 20/11/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	SELECT seguimiento_capacitacion.correccionDatos4387()  
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
CREATE OR REPLACE FUNCTION seguimiento_capacitacion.correccionDatos4387()  
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
	
	--1.-	CE/PN-A06-679/2018
	--    	6276516
	select seguimiento_capacitacion.changeCI('CE/PN-A06-679/2018', '6276516-SC','AGUILERA','QUIROGA', '6276516', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
	--2.- 	CE/LP-T312-557/2018
	--    	4820558
	select seguimiento_capacitacion.changeCI('CE/LP-T312-557/2018', '482055','CAREAGA','LLANOS', '4820558', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
	--3.- 	CE/LP-T385-826/2018
	--    	4900359
	select seguimiento_capacitacion.changeCI('CE/LP-T385-826/2018', '4900359-LP','CONTRERAS','PACO', '4900359', 1) into _obj_informacion_afectada;
	IF _obj_informacion_afectada.err_Existente != 0 THEN  RAISE EXCEPTION transaction_rollback; ELSE total:=total+1; end if;
	--4.- 	CE/LP-T379-820/2018
	--    	1762559
	--5.- 	CE/SC-T11-780/2018
	--    	4708986
	--6.- 	CE/CH-T03-655/2018
	--    	1099296
	--7.- 	CE/LP-A76-863/2018
	--    	6003928
	--8.- 	CE/LP-T387-857/2018
	--    	4243302
	--9.- 	CE/LP-T387-857/2018
	--    	4741269
	--10.-	CE/LP-T387-857/2018
	--    	4741269
	--11.-	CE/SC-T11-780/2018
	--    	6358257
	--12.-	CE/LP-T373-814/2018
	--    	3656498
	--13.-	CE/CB-T36-921/2018
	--    	6559729
	--14.- 	CE/CH-T03-655/2018
	--    	10329839
	--15.-	CE/LP-T406-885/2018
	--    	3499637
	--16.-	CE/CH-T12-664/2018
	--    	5688242
	--17.-	CE/LP-A70-835/2018
	--    	6149172
	--18.-	CE/LP-T379-820/2018
	--    	4744451
	--19.-	CE/LP-T389-859/2018
	--    	4306826
	--20.-	CE/LP-A64-807/2018
	--    	2129566
	--21.-	CE/LP-A70-807/2018
	--    	6948835
	--22.-	CE/LP-T387-857/2018
	--    	2022841
	--23.-	CE/CH-T07-659/2018
	--    	4095906
	--24.-	CE/LP-T375-816/2018
	--    	9860573
	--25.-	CE/LP-T385-826/2018
	--    	7495506
	
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
