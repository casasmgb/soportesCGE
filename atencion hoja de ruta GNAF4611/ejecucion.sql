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

--FACTURA NRO: 24267
-- 20180913_NSSTDR
select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-T347-737/2018', '5973672');

--FACTURA NRO: 31386
-- 20181011_GAODSL
select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-T372-813/2018', '6945964');

--FACTURA NRO: 34719
-- 20181023_EVZHTA
select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-T385-826/2018', '5636691');

