/*******************************************
 * NUMERO DE SOPORTE: 06046/2018
 * FUNCIONARIO: OSCAR LUIS SEGURA GUTIERREZ
 * DESCRIPCION:
 *       FAVOR, CAMBIAR CANTIDAD DE HORAS DEL EVENTO CE/LP-CS09-586/2018 DE 16 A 8
 *
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 30/07/2018
 * Base de datos: siga_support
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 *
 *
 *******************************************/
-- buscamos el curso de la directriz D-23
select * from seguimiento_capacitacion.curso c where c.cur_codigo_sigla = 'D-23/CE/CS-07/CUR-20'; 

-- cambiamos la carga horaria del curso
UPDATE seguimiento_capacitacion.curso
SET
cur_carga_horaria = 8 --estaba con 16
WHERE cur_codigo = 200 AND cur_codigo_sigla = 'D-23/CE/CS-07/CUR-20';

-- buscamos procur_codigo con cur_codigo
select * from seguimiento_capacitacion.programacion_curso where cur_codigo = 200;  -- 1294

-- eliminamos una asignacion de aula
delete from seguimiento_capacitacion.asignacion_aula where procur_codigo = 1294 and asiaul_codigo = 2

-- cambiamos fecha finalizacion en programacion curso
UPDATE seguimiento_capacitacion.programacion_curso
SET
procur_fecha_final = '2018-07-26' -- antes 2018-07-27   se descuenta 1 dia
WHERE procur_codigo = 1294



