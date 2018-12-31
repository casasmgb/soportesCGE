/*******************************************
 * NUMERO DE SOPORTE: por correo
 * FUNCIONARIO: 
 * DESCRIPCION:
 *       FAVOR, QUITAR LA ASOCIACION DE FACTURAS A PARTICIPANTES.  
 *
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 27/08/2018
 * Base de datos: siga_soportes
 * Usuario: usr_academico
 * Esquema: seguimiento_capacitacion
 * Motor de base de datos: PostgreSql
 * 
 * Ejemplo de ejecucion:
 * select select seguimiento_capacitacion.spr_desvincular_factura('CE/LP-E10-828/2018', '3613470');
 *******************************************/

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.spr_desvincular_factura(i_procur_sigla character varying, i_docidentidad character varying)
 RETURNS character varying
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
	declare
	    -- variables that we will use
	    _procur_sigla character varying(100);
	    _procur_codigo integer;
	    _docidentidad character varying(50);
		_perpre_codigo character varying(50);
		_per_codigo integer;
		_fac_codigo integer;
		_facperins_codigo integer;
	   	_registros_actualizados integer;
		_registros_actualizar integer;
		_fac_saldo_total numeric;
		_total_costo_curso numeric;
		_operaciones character varying(1000);
		_acceso_externo_estado boolean;
		-- exception's variables 		
		_err_Mensaje  character varying(1000); 
		_err_Mensaje2 character varying(1000); 
		_err_Mensaje3 character varying(1000); 
	
	begin
		-- set values to variables
		_acceso_externo_estado:=false;
		_procur_sigla := i_procur_sigla;
		_docidentidad := i_docidentidad;
	    _operaciones := 'Operacione ';
	   
		SELECT
		     d.procur_codigo into _procur_codigo
		FROM seguimiento_capacitacion.programacion_curso d
		     INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion pc ON pc.procur_codigo = d.procur_codigo
		     inner join seguimiento_capacitacion.curso c
		     on c.cur_codigo=d.cur_codigo
		WHERE  pc.procurcod_sigla = _procur_sigla; 
		raise notice '_procur_codigo:%',_procur_codigo;
		
		SELECT
		     tab.total_costo_curso,
		     tab.perpre_codigo into _total_costo_curso, _perpre_codigo
		FROM seguimiento_capacitacion.spr_sel_pre_inscritos ( 
			 '', --perpre_codigo varchar,
		     3, --  perpre_estado integer,
		     '',     --  perpre_codigo_preinscripcion varchar
		     - 1, -- dep_codigo_prog integer,
		     _procur_codigo, -- procur_codigo INTEGER
		     - 1, --  cur_codigo integer,
		     '1900-01-01',     --  fecha_inicio date,
		     '1900-01-01',     --  fecha_fin date,
		     '',     --  cadena_busqueda varchar
		     - 1 --  tipo_publicacion integer
		     ) AS tab
		WHERE tab.perpre_numero_docidentidad = _docidentidad;
		raise notice '_perpre_codigo:%',_perpre_codigo;
		
		SELECT
		     f.per_codigo,
		     f.fac_codigo,
		     f.facperins_codigo into _per_codigo, _fac_codigo, _facperins_codigo
		FROM seguimiento_capacitacion.facturas_persona_inscripcion f
		WHERE f.perpre_codigo  =_perpre_codigo;

		raise notice '_per_codigo 3:%',_per_codigo;
		raise notice '_fac_codigo 4:%',_fac_codigo;
		raise notice '_facperins_codigo 5:%',_facperins_codigo;
		-- NOW WE CAN EXECUTE UPDATE AND DELETE INFORMATION ABOUT BILL
		
		-- FIRST STEP
		if not exists (SELECT * FROM seguimiento_capacitacion.facturas_persona_inscripcion f WHERE f.perpre_codigo =_perpre_codigo) then
			_err_Mensaje := 'REGISTRO EN facturas_persona_inscripcion NO SE PUEDE ELIMINAR';
			return _err_Mensaje;	
		else 
			update seguimiento_capacitacion.facturas_persona_inscripcion f
			set facperins_estado=0
			WHERE f.perpre_codigo =_perpre_codigo;
			GET DIAGNOSTICS _registros_actualizados = ROW_COUNT;	
			-- si no es lo esperado , hacer un rollback
			IF _registros_actualizados != 1	then
				RAISE EXCEPTION transaction_rollback;
				return 'Roll back';
			END IF ; 
			_operaciones := _operaciones || 'DELETE ';
		
			-- SECOND STEP
			if not exists (select * from seguimiento_capacitacion.facturas where fac_codigo = _fac_codigo) then
				_err_Mensaje := 'REGISTRO EN facturas NO SE PUEDE ACTUALIZAR';
				RAISE EXCEPTION transaction_rollback;
				return _err_Mensaje;	
			else 
				select fac_saldo_total into _fac_saldo_total from seguimiento_capacitacion.facturas where fac_codigo = _fac_codigo;
				
				update seguimiento_capacitacion.facturas f
				set
				fac_saldo_total = (_fac_saldo_total + _total_costo_curso)
				where f.fac_codigo =_fac_codigo;
			
				GET DIAGNOSTICS _registros_actualizados = ROW_COUNT;
				IF _registros_actualizados != 1	THEN   
					RAISE EXCEPTION transaction_rollback;
					return 'Roll back';
				END IF ;
				
				_operaciones := _operaciones || 'UPDATE ';
				-- PREVIOUS STEP
					-- now we call to acceso_externo.spr_desvincular_cuenta_participante method.
					_acceso_externo_estado:=acceso_externo.spr_desvincular_cuenta_participante(_perpre_codigo);
					if _acceso_externo_estado=false then
						RAISE EXCEPTION transaction_rollback;
						return 'Roll back';
					end if;
					_operaciones := _operaciones || '**DELETE-UPDATE acceso_externo** ';	
				-- THIRD STEP
				if not exists (SELECT * FROM seguimiento_capacitacion.personas_inscripcion pe WHERE pe.perpre_codigo =_perpre_codigo) then
					_err_Mensaje := 'REGISTRO EN personas_inscripcion NO SE PUEDE ELIMINAR';
					RAISE EXCEPTION transaction_rollback;
					return _err_Mensaje;	
				else 
					update seguimiento_capacitacion.personas_inscripcion pe
					set perins_estado=0
					WHERE pe.perpre_codigo = _perpre_codigo;
					GET DIAGNOSTICS _registros_actualizados = ROW_COUNT;	
					IF _registros_actualizados != 1	THEN   
						RAISE EXCEPTION transaction_rollback;
						return 'Roll back';
					END IF ; 
					_operaciones := _operaciones || 'DELETE :: fac_codigo: ' || _fac_codigo || '  perpre_codigo: ' || _perpre_codigo  ;
					
					return _operaciones::character varying;
				end if;
			end if;
		end if;
		--RAISE EXCEPTION transaction_rollback;
		return _operaciones::character varying;
	exception
		WHEN OTHERS then
			GET STACKED DIAGNOSTICS _err_Mensaje := PG_EXCEPTION_HINT;
			GET STACKED DIAGNOSTICS _err_Mensaje2 := MESSAGE_TEXT;
			GET STACKED DIAGNOSTICS _err_Mensaje3 := PG_EXCEPTION_CONTEXT;
			RAISE NOTICE 'Error de actualizacion :(%) ',_err_Mensaje2;
			RAISE EXCEPTION transaction_rollback;
			return 'Excepcion ' || _err_Mensaje || _err_Mensaje2 || _err_Mensaje3 || _operaciones;
END;
$function$

-- drop function seguimiento_capacitacion.spr_desvincular_factura

select seguimiento_capacitacion.spr_desvincular_factura('MU/LP-E01-838/2018', '4872278');