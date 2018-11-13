/*******************************************
 * NUMERO DE SOPORTE: HOJA DE RUTA GNAF/4287/2018  SGSIR/751/2018
 * DESCRIPCION:
 *       DESVINCULACION DE FACTURAS  
 *
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 12/11/2018
 * Base de datos: siga_soportes
 * Usuario: usr_academico
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 * 
 * Ejemplo de ejecucion:
 * seguimiento_capacitacion.spr_desvincular_factura('CE/LP-E10-828/2018', '3613470');
 *******************************************/


--select seguimiento_capacitacion.spr_upd_desconsolidar_evento('CE/CB-CS04-689/2018') 
/*
 * Ejecutar el script para quitar la asociacion de las facturas siguientes:
 * 
 */
select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-E11-829/2018', '3613470');
select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-E11-829/2018', '4795261');

--
-- DATOS DE LA PERSONA AFECTADA
SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='MU/LP-E01-838/2018'
SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas e where e.procur_codigo=1547;
-- DESCANSOLIDAR EVENTO

select seguimiento_capacitacion.spr_upd_desconsolidar_evaluacion_evento('MU/LP-E01-838/2018');

/*
-- para verificar facturas desvinculadas:

 SELECT * FROM seguimiento_capacitacion.facturas_persona_inscripcion f WHERE f.perpre_codigo IN ('20180912_OPJJCM' ); 			  -- delete
 select * from seguimiento_capacitacion.facturas where fac_codigo = 425320; 														  -- update
 SELECT * FROM seguimiento_capacitacion.personas_inscripcion pe WHERE pe.perpre_codigo IN ( '20180912_OPJJCM' );		 			  -- delete	
--      acceso exteno
 SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo IN ( '20180912_OPJJCM' ) 					  -- delete
 select * from acceso_externo.persona_preinscripcion pe WHERE pe.perpre_codigo IN   ('20180912_OPJJCM') and pe.perpre_estado = 2;   -- update

*/
/* 
 * acceso externo de los participantes MU/LP-E01-838/2018
15111985-WOO    4825009
27081979-CLW    4285668
07061990-VDV    5967387
27061984-HYD    4872278
*/
