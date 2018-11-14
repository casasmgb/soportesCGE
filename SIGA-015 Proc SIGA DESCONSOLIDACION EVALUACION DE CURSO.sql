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
 * Ejemplo de ejecucion:
 * select seguimiento_capacitacion.spr_upd_desconsolidar_evaluacion_evento('CE/OR-CS03-873/2018')
 *******************************************/
/*
 * Para verificar los registros antes de modificar
 * 
 *  

select * from seguimiento_capacitacion.programacion_curso_codificacion AS pcc
inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
on pcc.procur_codigo = edpi.procur_codigo
where pcc.procurcod_sigla='CE/OR-CS03-873/2018' and edpi.asidoc_codigo = 1

*/

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.spr_upd_desconsolidar_evaluacion_evento(i_procurcod_sigla character varying)
 RETURNS varchar
 LANGUAGE plpgsql
 -- SECURITY DEFINER
AS $function$
	DECLARE
        -- Varialbles a utilizar en el proceso de actualización
      _procur_sigla character varying(50);
      _procur_codigo integer;
	  _estado character varying(50);
	  _actualizados integer;
	  _nro_registros_actualizar integer;
	-- Variables de Excepcion 		
	  _err_Mensaje CHARACTER VARYING (1000); 

begin
	_procur_sigla := i_procurcod_sigla;
	SELECT pcc.procur_codigo into _procur_codigo FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc WHERE pcc.procurcod_sigla=_procur_sigla;
	select count(*) into _nro_registros_actualizar from seguimiento_capacitacion.programacion_curso_codificacion AS pcc
					inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
					on pcc.procur_codigo = edpi.procur_codigo
					where pcc.procurcod_sigla=_procur_sigla and edpi.asidoc_codigo in (1,2) and edpi.evadocperins_estado = 2;
					
					
	
	if not exists (select * from seguimiento_capacitacion.programacion_curso_codificacion AS pcc
					inner join seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
					on pcc.procur_codigo = edpi.procur_codigo
					where pcc.procurcod_sigla=_procur_sigla and edpi.asidoc_codigo in (1,2) and edpi.evadocperins_estado = 2) then
					_err_Mensaje := 'NO SE PUEDE DESCONSOLIDAR';
					return _err_Mensaje;	
	else 
		UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
		SET
		evadocperins_estado = 1 --2
		WHERE edpi.asidoc_codigo  in (1,2) and edpi.evadocperins_estado = 2 AND edpi.procur_codigo = _procur_codigo;
		GET DIAGNOSTICS _actualizados = ROW_COUNT;	
		-- si no es lo esperado , hacer un rollback
		IF _actualizados != _nro_registros_actualizar	THEN   
			RAISE EXCEPTION transaction_rollback;
			return 'Roll back';
		END IF ; 
		return 'registros actualizados.';
	end if;
	exception
		WHEN OTHERS then
			GET STACKED DIAGNOSTICS _err_Mensaje := MESSAGE_TEXT;
			RAISE NOTICE 'Error de actualizacion :(%) ',_err_Mensaje;
			return _err_Mensaje;
	
END;
$function$

			
