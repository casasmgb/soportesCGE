/*******************************************
 * HOJA DE RUTA: GNAF/4532/2018
 *               SGSIR/771/2018
 *               CENCAP/-1562
 * REMITENTE: MARIA ESCALANTE
 * DESCRIPCION:
 *       SOLICITUD DE DESCONSOLIDAR DEL SIGA EL EVENTO: CE/LP-T403-882/2018
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha Ejecucion: 26/11/2018
 * Base de datos: siga_soportes
 * Usuario: usr_academico
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 * 
 *******************************************/
/*
 * Para verificar los registros antes de modificar
 * 
 */

/*
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
-- VERIFICAR LOS REGISTROS.
select edpi.*, * from seguimiento_capacitacion.personas_inscripcion peri 
inner join acceso_externo.persona_preinscripcion pp
on peri.perpre_codigo = pp.perpre_codigo
inner join seguimiento_capacitacion.programacion_curso_codificacion pcc
on pp.procur_codigo = pcc.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on edpi.procur_codigo = pcc.procur_codigo and edpi.perpre_codigo = pp.perpre_codigo
where pcc.procurcod_sigla = 'CE/LP-T14-090/2018' 
*/

DO $$
DECLARE 
_actualizados INTEGER;
BEGIN
	
	insert into seguimiento_capacitacion.historico_participantes 
	(traza, tabla, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	SELECT 
	row_to_json (row1) as traza, 
	'seguimiento_capacitacion.evaluacion_docente_personas_inscritas' as tabla, 
	now() as fecha_ejecucion, 
	'Gabriel Casas M.' as funcionario_sgsir_responsable, 
	'desconsolidacion edicion de notas' as comentario_accion_realizada
	FROM (
	   SELECT * FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi 
	   WHERE edpi.evadocperins_estado = 2 
	   AND edpi.procur_codigo = 1593 
	   AND edpi.asidoc_codigo = 1
	) row1;
	
	UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
	SET
	evadocperins_estado = 1 --2
	WHERE edpi.evadocperins_estado = 2 AND edpi.procur_codigo = 1593 AND edpi.asidoc_codigo = 1;
	GET DIAGNOSTICS _actualizados = ROW_COUNT;	
	-- si no es lo esperado , hacer un rollback
	IF _actualizados != 23	THEN   
		RAISE EXCEPTION transaction_rollback;
	END IF ; 
END
$$;

-- select * from seguimiento_capacitacion.historico_participantes

select * from seguimiento_capacitacion