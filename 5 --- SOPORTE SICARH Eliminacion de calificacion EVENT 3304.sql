/*******************************************
 * NUMERO DE SOPORTE: 06210/2018
 * FUNCIONARIO: LAURA APAZA JOSE LUIS
 * DESCRIPCION:
 *       FAVOR, ELIMINAR DOS CALIFICACION DEL EVENTO "SIGEP"
 * COD EV: 3304  
 * COD: 1G12G2774
 * TIPO DE EVENTO: SEMINARIO 
 * 
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 17/08/2018
 * Base de datos: SSCRRHH
 * Verion Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 *******************************************/
 
SELECT * FROM dbo.EvaluacionEvento WHERE CodCorrEvEjec = 3304

UPDATE EvaluacionEvento 
SET CodCorrEvEjec = -3304
WHERE CodCorrEAE IN (9123, 9124)

UPDATE EjecucionEventos
SET    CalificacionesConsolidadas = 'S' -- ANTES -
WHERE  CodCorrEvEjec = 3304