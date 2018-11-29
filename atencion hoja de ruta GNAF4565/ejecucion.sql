update seguimiento_capacitacion.evaluacion_docente_personas_inscritas 
set evadocperins_estado=0--2
where perpre_codigo='20181010_XIIDLW';

select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-T389-859/2018', '6500501');
