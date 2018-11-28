-- Ejecutar con usuario: USRACADEMICO
CREATE TABLE seguimiento_capacitacion.historico_participantes(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(150),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria PRIMARY KEY (id)
);
-- Ejecutar con usuario: EXTACADEMICO
CREATE TABLE acceso_externo.historico_participantes(
    id SERIAL NOT NULL,
    tabla CHARACTER VARYING(150),
    traza JSON,
    fecha_ejecucion TIMESTAMP WITH TIME ZONE,
    funcionario_sgsir_responsable CHARACTER VARYING(50),
    comentario_accion_realizada  CHARACTER VARYING(200),
    CONSTRAINT pk_auditoria PRIMARY KEY (id)
);

--FACTURA NRO: 32733
delete from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where perpre_codigo='20181010_XIIDLW';
select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-T389-859/2018', '6500501');
