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
delete from seguimiento_capacitacion.certificacion_persona where perpre_codigo = '20181014_MYORRQ';
delete from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where perpre_codigo='20181014_MYORRQ';
select seguimiento_capacitacion.spr_desvincular_factura('MU/LP-E01-838/2018', '4285668');

--FACTURA NRO: 32772
delete from seguimiento_capacitacion.certificacion_persona where perpre_codigo = '20181009_QRZHLR';
delete from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where perpre_codigo='20181009_QRZHLR';
select seguimiento_capacitacion.spr_desvincular_factura('MU/LP-E01-838/2018', '4825009');

--FACTURA NRO: 32771
delete from seguimiento_capacitacion.certificacion_persona where perpre_codigo = '20181018_ACZBDL';
delete from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where perpre_codigo='20181018_ACZBDL';
select seguimiento_capacitacion.spr_desvincular_factura('MU/LP-E01-838/2018', '4872278');

--FACTURA NRO: 34091
delete from seguimiento_capacitacion.certificacion_persona where perpre_codigo = '20181014_ACXJKM';
delete from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where perpre_codigo='20181014_ACXJKM';
select seguimiento_capacitacion.spr_desvincular_factura('MU/LP-E01-838/2018', '5967387');