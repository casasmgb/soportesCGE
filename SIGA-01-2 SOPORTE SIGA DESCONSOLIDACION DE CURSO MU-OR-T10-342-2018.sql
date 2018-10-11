/*******************************************
 * NUMERO DE SOPORTE: 06532/2018
 * FUNCIONARIO: OSCAR LUIS SEGURA GUTIERREZ
 * DESCRIPCION:
 *       FAVOR, DESCONSOLIDAR el evento CE/LP-T328-621/2018 "responsabilidad por la funcion publica para agregar notas.
 * PROCURCOD_SIGLA: CE/LP-T328-621/2018
 *
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 10/09/2018
 * Base de datos: siga_support
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 *
 *******************************************/
--
 
-- buscamos el procur_codigo con procurcod_sigla
SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla='CE/LP-T328-621/2018'
-- verificamos que no este desconsolidado
select * from seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi WHERE edpi.asidoc_codigo = 1 AND edpi.procur_codigo = 1330;

-- desconsolidar curso con procur_codigo
UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
SET
evadocperins_estado = 1 --2
WHERE edpi.asidoc_codigo = 2 AND edpi.procur_codigo = 1330;
