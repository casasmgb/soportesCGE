/*******************************************
 * NUMERO DE SOPORTE: por correo
 * FUNCIONARIO: 
 * DESCRIPCION:
 *       FAVOR, QUITAR LA ASOCIACION DE FACTURAS A PARTICIPANTES.  
 *
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 27/08/2018
 * Base de datos: siga_soportes
 * Usuario: EXTACADEMICO 
 * Esquema: acceso_externo
 * Motor de base de datos: PostgreSql
 * 
 * Ejemplo de ejecucion:
 * select acceso_externo.spr_desvincular_cuenta_participante('20180912_FZOKJN')
 *******************************************/


CREATE OR REPLACE FUNCTION acceso_externo.spr_desvincular_cuenta_participante(i_perpre_codigo character varying)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
	declare
	    -- variables that we will use
	    _ret boolean;
		_perpre_codigo character varying(50);
		_registros_actualizados integer;
		_operaciones character varying(1000);
		-- exception's variables 		
		_err_Mensaje  character varying(1000); 
		_err_Mensaje2 character varying(1000); 
		_err_Mensaje3 character varying(1000); 
	
	begin
		-- set values to variables
		_perpre_codigo := i_perpre_codigo;
	   
		-- NOW WE CAN EXECUTE UPDATE AND DELETE INFORMATION ABOUT AN ACOUNT
		
		-- FIRST STEP
		if not exists (SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo = _perpre_codigo) then
			_err_Mensaje := 'REGISTRO EN acceso_externo.cuenta_persona_inscripcion NO SE PUEDE ELIMINAR';
			_ret := false;
			return _ret;	
		else 
			DELETE
			FROM acceso_externo.cuenta_persona_inscripcion cpi
			WHERE cpi.perpre_codigo = _perpre_codigo;
			
			GET DIAGNOSTICS _registros_actualizados = ROW_COUNT;	
			IF _registros_actualizados != 1	THEN   
				_ret := false;
				RAISE EXCEPTION transaction_rollback;
				return _ret;
			END IF ; 
			_ret := true;
			_operaciones := _operaciones || '**DELETE ';
		
			-- SECOND STEP
			if not exists ( select * from acceso_externo.persona_preinscripcion pe 
						    WHERE pe.perpre_codigo =_perpre_codigo and pe.perpre_estado = 3) then
				_ret := false;
				_err_Mensaje := 'REGISTRO EN acceso_externo.persona_preinscripcion NO SE PUEDE ACTUALIZAR';
				RAISE EXCEPTION transaction_rollback;
				return _ret;	
			else 
			
				UPDATE acceso_externo.persona_preinscripcion pe
				SET perpre_estado = 2 --3
				WHERE pe.perpre_codigo =_perpre_codigo and 
				      pe.perpre_estado = 3;
				GET DIAGNOSTICS _registros_actualizados = ROW_COUNT;
				IF _registros_actualizados != 1	THEN   
					_ret := false;	
					RAISE EXCEPTION transaction_rollback;
					return _rest;
				END IF ;
				_ret := true;
				_operaciones := _operaciones || 'UPDATE** ';
				return _ret;
			end if;
		end if;
		-- RAISE EXCEPTION transaction_rollback;
		return _ret;
	exception
		WHEN OTHERS then
			GET STACKED DIAGNOSTICS _err_Mensaje := PG_EXCEPTION_HINT;
			GET STACKED DIAGNOSTICS _err_Mensaje2 := MESSAGE_TEXT;
			GET STACKED DIAGNOSTICS _err_Mensaje3 := PG_EXCEPTION_CONTEXT;
			RAISE EXCEPTION transaction_rollback;
			RAISE NOTICE 'Error de actualizacion :(%) ',_err_Mensaje;
			return 'Excepcion ' || _err_Mensaje || _err_Mensaje2 || _err_Mensaje3 || _operaciones;
END;
$function$

-- drop function acceso_externo.spr_desvincular_cuenta_participante