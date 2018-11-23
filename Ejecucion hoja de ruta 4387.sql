--====================================================================================
	/*
	HOJA DE RUTA GNAF 3717/2018 SGSIR/682/2018
	
	CENCAP/CI-633/2018
	DE: LIC. GLORIA DEL SALVADOR SAMORANO LUJAN
	FECHA REMICION DE HR: 08/10/2018
	MODIFICAR DATOS DE PERSONAS EN EL SISTEMA SIGA
	SISTEMA:SIGA
	USUARIO DB: USRACADEMICO
	USUARIO DB: EXTACADEMICO
	MOTOR BASE DE DATOS: POSTGRES
	FECHA EJECUCION: 11/10/2018
	POR: LIC. GABRIEL CASAS MAMANI.
	EJECUTAR:
	SELECT seguimiento_capacitacion.correccionDatos4387()  
	*/
--====================================================================================
-- Ejecutar con usuario: USRACADEMICO
CREATE TABLE seguimiento_capacitacion.historico_participantes(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(50),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria PRIMARY KEY (id)
);
-- Ejecutar con usuario: EXTACADEMICO
CREATE TABLE acceso_externo.historico_participantes(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(50),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria PRIMARY KEY (id)
);

-- Ejecutar con usuario: USRACADEMICO
SELECT seguimiento_capacitacion.correccionDatos4387_01();
SELECT seguimiento_capacitacion.correccionDatos4387_02();
SELECT seguimiento_capacitacion.correccionDatos4387_03();
-- Ejecutar con usuario: EXTACADEMICO
SELECT acceso_externo.correccionDatosNombres4387_01();
SELECT acceso_externo.correccionDatosNombres4387_02();
SELECT acceso_externo.correccionDatosNombres4387_03();

-- visualizar los registros afectados
-- Ejecutar con usuario: USRACADEMICO
select * from seguimiento_capacitacion.historico_participantes
-- Ejecutar con usuario: EXTACADEMICO
select * from acceso_externo.historico_participantes

