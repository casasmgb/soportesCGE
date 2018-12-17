/*******************************************
 * Solicitud por Correo
 * FUNCIONARIO: Jeaninne Benavides Vargas 
 * DESCRIPCION:
 *       MODIFICACIÓN EN EL SISTEMA S.I.G.A EN LA CARGA HORARIA DE LA DIRECTRIZ "AULAS REMOTAS 2018" MISMA QUE DEBERÁ MODIFICARSE DE 40 HRS. A 33 HRS. PARA FINES DE CERTIFICACIÓN A PARTICIPANTES.
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 06/12/2018
 * Usuario: usr_academico
 * Base de datos: siga_support
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 *******************************************/
DO $$
DECLARE 
_actualizados INTEGER;
_cur_codigo INTEGER;
_cur_codigo_sigla character varying(25);
_nueva_carga_horaria INTEGER;
BEGIN
	
	_cur_codigo_sigla:=	'D-24/CE/T-01/CUR-17';
	_nueva_carga_horaria:=33; --40
	
	-- buscamos el curso de la directriz
	select c.cur_codigo into _cur_codigo from seguimiento_capacitacion.curso c where c.cur_codigo_sigla = _cur_codigo_sigla; 
	
	insert into seguimiento_capacitacion.historico_participantes 
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT
	(
		SELECT
			array_to_json ( array_agg ( row_to_json ( t ) ) )
	    FROM (
		   SELECT * FROM seguimiento_capacitacion.curso
		   WHERE cur_codigo = _cur_codigo AND cur_codigo_sigla = _cur_codigo_sigla
		   ) as t
	) as traza,
	'seguimiento_capacitacion.curso' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas' as funcionario_sgsir_responsable, 
	'cambio de carga horaria' as comentario_accion_realizada;
	
	-- cambiamos la carga horaria del curso
	UPDATE seguimiento_capacitacion.curso
	SET
	cur_carga_horaria = _nueva_carga_horaria
	WHERE cur_codigo = _cur_codigo AND cur_codigo_sigla = _cur_codigo_sigla;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 1 THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
	raise notice '% registros actualizados.',_actualizados;
END
$$;

 
-- SELECT * FROM seguimiento_capacitacion.curso WHERE cur_codigo = 176 AND cur_codigo_sigla = 'D-24/CE/T-01/CUR-17';	   
-- select * from seguimiento_capacitacion.historico_participantes