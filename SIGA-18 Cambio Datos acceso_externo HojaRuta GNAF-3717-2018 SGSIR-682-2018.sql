--====================================================================================
	/*
	HOJA DE RUTA GNAF 3717/2018 SGSIR/682/2018
	CENCAP/CI-633/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 08/10/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: EXTACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA CREACION: 10/10/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	*/
--====================================================================================

CREATE OR REPLACE FUNCTION acceso_externo.correccionDatosNombres() 
  RETURNS  void AS
$BODY$
DECLARE
	my_var INTEGER;
BEGIN
	my_var:=0;
	--7.-	CE/LP-T230-439/2018
	--		5749440
    UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'JESUS CRISTIAN' --JESUYS CRISTIAN
	WHERE perpre_codigo='20180802_KJCUNI';
   	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	--8.-	MU/SC-T39-785/2018
	--		6311253
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'LILHLIA MARLINA' --LILHLIA
	WHERE perpre_codigo='20180927_XAUNOM';
   	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--14.-	CE/LP-T10-630/2017
	--		4987779
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'NELSON' --LILHLIA
	WHERE perpre_codigo='20171115_TEVVBM';
   	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--16.-	CE/CB-T24-700/2018
	--		3618064
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_apellido_esposo = '' --DE PRUDENCIO
	WHERE perpre_codigo='20180928_NCYDLS';
   	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--18.-	CE/PN-T06-671/2018
	--		3339102
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_correo_electronico = 'gunther2013.bio@gmail.com' --gunther@gmail.com
	WHERE perpre_codigo='20180928_NCYDLS';
   	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	--26.-	CE/PN-T04-669/2018
	--		4203568
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_correo_electronico = 'dariana212009@hotmail.com' --DAARIANA212009@HOTMAIL.COM
	WHERE perpre_codigo='20180903_XKCWWG';
   	--obteniendo cuantas filas fueron afectadas
	GET DIAGNOSTICS my_var = ROW_COUNT;	
			
	-- si no es lo esperado , hacer un rollback
	IF my_var != 1 	THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF ;
	
END;      
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  
 -- select * from acceso_externo.correccionDatosNombres();