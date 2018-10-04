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
 * select acceso_externo.spr_desvincular_cuenta_participante('CE/CB-CS04-689/2018')
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
		if not exists (SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo IN (_perpre_codigo)) then
			_err_Mensaje := 'REGISTRO EN acceso_externo.cuenta_persona_inscripcion NO SE PUEDE ELIMINAR';
            
			_ret := false;
			return _ret;	
		else 
			RAISE NOTICE 'DELETE acceso externo';
			DELETE
			FROM acceso_externo.cuenta_persona_inscripcion cpi
			WHERE cpi.perpre_codigo = _perpre_codigo;
            
            if not found then 
             raise notice 'no se ejecuto el scrip de borrado de la cuenta';
            end if;
			
			GET DIAGNOSTICS _registros_actualizados = ROW_COUNT;	
            
           raise notice 'el valor------------  %'  ,_registros_actualizados;

			--RAISE NOTICE 'DELETE acceso externo afectados: ', _registros_actualizados;
			-- if doesn't it is that we will wish, we will make rollback
			IF _registros_actualizados != 1	THEN   
				_ret := false;
				RAISE NOTICE 'error DELETE acceso externo';
				RAISE EXCEPTION transaction_rollback;
				--return _ret;
			END IF ; 
			_ret := true;
			_operaciones := _operaciones || '**DELETE ';
		raise notice 'paso por aquí';
			-- SECOND STEP
			if not exists ( select * from acceso_externo.persona_preinscripcion pe 
						    WHERE pe.perpre_codigo IN   (_perpre_codigo) and pe.perpre_estado = 3) then
				_ret := false;
				_err_Mensaje := 'REGISTRO EN acceso_externo.persona_preinscripcion NO SE PUEDE ACTUALIZAR';
				RAISE EXCEPTION transaction_rollback;
				--return _ret;	
			else 
				RAISE NOTICE 'UPDATE';
				UPDATE acceso_externo.persona_preinscripcion pe
				SET perpre_estado = 2 --3
				WHERE pe.perpre_codigo IN   (_perpre_codigo) and 
				      pe.perpre_estado = 3;
				      
				GET DIAGNOSTICS _registros_actualizados = ROW_COUNT;
			
				RAISE NOTICE 'UPDATE afectados:% ', _registros_actualizados;
				-- if doesn't it is that we will wish, we will make rollback
				IF _registros_actualizados != 1	THEN   
					_ret := false;	
                    _err_mensaje := 'Error en actualización de datos';
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
     when transaction_rollback then 
     begin 
  			GET STACKED DIAGNOSTICS _err_Mensaje := PG_EXCEPTION_HINT;
			GET STACKED DIAGNOSTICS _err_Mensaje2 := MESSAGE_TEXT;
			GET STACKED DIAGNOSTICS _err_Mensaje3 := PG_EXCEPTION_CONTEXT;
            
     			RAISE NOTICE 'Error de actualizacion acceso externo :(%) ',_err_Mensaje;
			RAISE NOTICE 'Error de actualizacion acceso externo :(%) ',_err_Mensaje2;
			RAISE NOTICE 'Error de actualizacion acceso externo :(%) ',_err_Mensaje3;
     
     end;
    
		WHEN OTHERS then
			GET STACKED DIAGNOSTICS _err_Mensaje := PG_EXCEPTION_HINT;
			GET STACKED DIAGNOSTICS _err_Mensaje2 := MESSAGE_TEXT;
			GET STACKED DIAGNOSTICS _err_Mensaje3 := PG_EXCEPTION_CONTEXT;
			RAISE EXCEPTION transaction_rollback;
			RAISE NOTICE 'Error de actualizacion acceso externo :(%) ',_err_Mensaje;
			RAISE NOTICE 'Error de actualizacion acceso externo :(%) ',_err_Mensaje2;
			RAISE NOTICE 'Error de actualizacion acceso externo :(%) ',_err_Mensaje3;
			--return 'Excepcion accesos externo';
	
END;
$function$

-- select acceso_externo.spr_desvincular_cuenta_participante('20180926_EYCONK')
-- SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo IN ( '20180926_EYCONK' )  -- delete
-- select * from acceso_externo.persona_preinscripcion pe WHERE pe.perpre_codigo IN   ('20180926_EYCONK') and pe.perpre_estado = 2;  -- update
