/*******************************************
 * NUMERO DE SOPORTE: 07109/2018
 * FUNCIONARIO: OSCAR LUIS SEGURA GUTIERREZ
 * DESCRIPCION:
 *       SOLICITO SE DESCONSOLIDE DEL SIGA EL SEMINARIO: CE/OR-CS03-873/2018 
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 29/10/2018
 * Base de datos: siga_soportes
 * Usuario: usr_academico
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 * 
 *******************************************/
/*
 * Para verificar los registros antes de modificar
 * 
 *  

select * from seguimiento_capacitacion.programacion_curso_codificacion AS pcc
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on pcc.procur_codigo = edpi.procur_codigo
where pcc.procurcod_sigla='CE/LP-T403-882/2018' and edpi.asidoc_codigo = 1

*/

select edpi.* from seguimiento_capacitacion.programacion_curso_codificacion pcc
inner join acceso_externo.persona_preinscripcion pp
on pp.procur_codigo = pcc.procur_codigo
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on pcc.procur_codigo = edpi.procur_codigo
where pcc.procurcod_sigla = 'CE/LP-T403-882/2018' and pp.perpre_numero_docidentidad = '4886229' and pp.perpre_estado=3



UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
SET
evadocperins_estado = 1 --2
WHERE edpi.asidoc_codigo = 1 and edpi.evadocperins_estado = 2 AND edpi.procur_codigo = 1583;
GET DIAGNOSTICS _actualizados = ROW_COUNT;	
-- si no es lo esperado , hacer un rollback
IF _actualizados != _nro_registros_actualizar	THEN   
	RAISE EXCEPTION transaction_rollback;
	return 'Roll back';
END IF ; 
	
-- select seguimiento_capacitacion.spr_upd_desconsolidar_evaluacion_evento('CE/OR-CS03-873/2018')
			

