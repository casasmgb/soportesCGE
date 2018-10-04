/*******************************************
 * NUMERO DE SOPORTE: 06349/2018
 * FUNCIONARIO: OSCAR LUIS SEGURA GUTIERREZ
 * DESCRIPCION:
 *       FAVOR, DESCONSOLIDAR CURSO RESPONSABILIDAD POR LA FUNCION PUBLICA
 * PROCURCOD_SIGLA: MU/LP-T13-336/2018
 *
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 28/07/2018
 * Base de datos: siga_support
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 *
 *******************************************/
--
select * from seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi WHERE edpi.procur_codigo=1043 AND edpi.asidoc_codigo = 1
-- buscamos el procur_codigo con procurcod_sigla
SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T324-594/2018'
-- verificamos que no este desconsolidado
select * from seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi WHERE edpi.asidoc_codigo = 1 AND edpi.procur_codigo = 1302;
-- desconsolidar curso con procur_codigo
UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
SET
evadocperins_estado = 1 --2
WHERE edpi.asidoc_codigo = 1 AND edpi.procur_codigo = 1302;
