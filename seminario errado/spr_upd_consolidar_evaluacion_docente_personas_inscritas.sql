-- Function: seguimiento_capacitacion.spr_upd_consolidar_evaluacion_docente_personas_inscritas(integer, integer)

-- DROP FUNCTION seguimiento_capacitacion.spr_upd_consolidar_evaluacion_docente_personas_inscritas(integer, integer);

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.spr_upd_consolidar_evaluacion_docente_personas_inscritas(
    procur_codigo integer,
    asidoc_codigo integer)
  RETURNS SETOF objinformacion_afectada AS
$BODY$
	DECLARE
		-- DeclaraciÃ³n de variables locales
		_procur_codigo INTEGER;
		_asidoc_codigo INTEGER;
		_evadocperins_estado INTEGER;
		
		-- Para los datos de la codificaciÃ³n del certificado
		_codcer_numero CHARACTER VARYING (20);
		_codcer_gestion INTEGER;
		_codcer_sigla CHARACTER VARYING (40);
		_codcer_estado INTEGER;
		_usuario_bd CHARACTER VARYING (50);
		_fecha_registro TIMESTAMP;
        _ran_codigo INTEGER;
		
		_cont_intentos INTEGER;
		_cant_intentos INTEGER;    
		_record RECORD;
		
		-- Definicion de variables de excepcion
		_err_Existente INTEGER;
		_err_Mensaje CHARACTER VARYING (1000);
		_err_Mensaje_Detalle CHARACTER VARYING(80000);
		_err_Codigo INTEGER;
		
		-- Variable de retorno de informaciÃ³n
		_objrespuesta_general PUBLIC.objinformacion_afectada%rowtype;
	BEGIN
		-- AsignaciÃ³n de valores a las variables locales
		_procur_codigo := fn_valida_nulos(procur_codigo::CHARACTER VARYING, 1)::INTEGER;
		_asidoc_codigo := fn_valida_nulos(asidoc_codigo::CHARACTER VARYING, 1)::INTEGER;
		
		_codcer_numero := '1'; -- Semilla
		_codcer_gestion := EXTRACT (YEAR FROM CURRENT_DATE);
		_codcer_sigla := 'CENCAP/CC';
		_codcer_estado := 1;
		_usuario_bd := SESSION_USER;
		_fecha_registro := CURRENT_TIMESTAMP;
		
		_cont_intentos := 1;
		_cant_intentos := 1000;
		
		_evadocperins_estado := 2; -- 2 : Valor que representa el estado de consolidado
		
		-- Inicializacion del objeto de retorno
		SELECT 	'-1', -- inf_codigo CHARACTER VARYING(1000),
			'',   -- inf_complemento CHARACTER VARYING(1000),
			0,    -- err_existente INTEGER,
			'',   -- err_mensaje CHARACTER VARYING(1000),
			0     -- err_codigo INTEGER
		INTO _objrespuesta_general;
		
		_err_Existente := 0;
		_err_Mensaje := '#SE CONSOLIDO LA INFORMACION DE MANERA SATISFACTORIA.';
		_err_Mensaje_Detalle := '';
		_err_Codigo := 0;
		
		SELECT min(dce.asidoc_codigo)
		INTO _asidoc_codigo
		FROM seguimiento_capacitacion.docente_criterios_evaluacion AS dce
		WHERE dce.procur_codigo = _procur_codigo  and dce.doccrieva_estado = 2
		GROUP BY dce.procur_codigo;
		
		IF NOT EXISTS (SELECT edpi.procur_codigo
		               FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi
		               WHERE edpi.procur_codigo = _procur_codigo AND edpi.asidoc_codigo = _asidoc_codigo
			       LIMIT 1) THEN
		        _err_Mensaje := '#NO EXISTEN NOTAS EN EL EVENTO, POR FAVOR REVISE LA TRANSCRIPCION.' || _asidoc_codigo;
			raise exception transaction_rollback;      	
		END IF;
		
		-- Validaciones necesarias
		IF (SELECT err_existente
		    FROM seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas (
			-1, -- _per_codigo INTEGER,
			'', -- _perpre_codigo CHARACTER VARYING,
			'', -- _perpre_codigo_preinscripcion CHARACTER VARYING,
			'', -- criterio_busqueda CHARACTER VARYING,
			_procur_codigo, -- _procur_codigo INTEGER,
			_asidoc_codigo, -- _asidoc_codigo INTEGER,
			1 -- _reporte INTEGER
		    ) as t
            order by t.estado_opcion DESC
		    LIMIT 1) = 1 THEN
			_err_Mensaje := '#EXISTEN DIFICULTADES AL MOMENTO DE CONSOLIDAR LA INFORMACION .';
			raise exception transaction_rollback;
		END IF;
        


        
        IF EXISTS (
            SELECT
                 edpi.procur_codigo
            FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas EDPI
            WHERE edpi.evadocperins_estado = 2 AND
                  edpi.procur_codigo = _procur_codigo
        )THEN 
	  			_err_Mensaje := '#LAS NOTAS YA FUERON CONSOLIDADAS, POR FAVOR NO LO INTENTE DE NUEVO.';
			raise exception transaction_rollback;
        END IF;
        
		
		FOR _record IN (
        --
        	SELECT t.per_codigo, t.perpre_codigo,  t.procur_codigo,t.evadocperins_nota_total
		                FROM seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas (
					-1, -- _per_codigo INTEGER,
					'', -- _perpre_codigo CHARACTER VARYING,
					'', -- _perpre_codigo_preinscripcion CHARACTER VARYING,
					'', -- criterio_busqueda CHARACTER VARYING,
					_procur_codigo, -- _procur_codigo INTEGER,
					_asidoc_codigo, -- _asidoc_codigo INTEGER,
					1 -- _reporte INTEGER
		                ) AS t
		                WHERE substr(t.calificacion_descripcion, 1, 3) = 'APR') LOOP
                      
    			--	raise notice 'Entro por aqui';
                    
                 SELECT
                      r.ran_codigo
                 INTO _ran_codigo
                 FROM seguimiento_capacitacion.rangos r
                 WHERE r.ran_estado = 1 AND
                       _record.evadocperins_nota_total BETWEEN r.ran_inicio AND
                       r.ran_fin;
			
			-- Verificando que anteriormente no se le haya dado ya un numero de certificado, que pueda comprometer la integridad de informacion en la tabla
			IF NOT EXISTS (SELECT cp.per_codigo, cp.perpre_codigo
			               FROM seguimiento_capacitacion.certificacion_persona AS cp
			               WHERE cp.per_codigo = _record.per_codigo AND cp.perpre_codigo = _record.perpre_codigo) THEN

				WHILE _cont_intentos <= _cant_intentos LOOP
				BEGIN
					SELECT COALESCE(max(cc.codcer_numero::INTEGER) +1 , _codcer_numero::INTEGER)::CHARACTER VARYING
					INTO _codcer_numero
					FROM seguimiento_capacitacion.codificacion_certificado AS cc
					WHERE cc.codcer_gestion = _codcer_gestion;
                    
                    if (length(_codcer_numero) < 3) then
                    _codcer_numero :=  lpad( _codcer_numero, 3, '0');
                    end if;
					
					INSERT INTO seguimiento_capacitacion.codificacion_certificado
					(
						codcer_numero,
						codcer_gestion,
						codcer_sigla,
						codcer_estado,
						codcer_fecha_registro,
						codcer_usuario_base_datos
					)
					VALUES
					(
						_codcer_numero,
						_codcer_gestion,
						_codcer_sigla,
						_codcer_estado,
						_fecha_registro,
						_usuario_bd
					);
					
					INSERT INTO seguimiento_capacitacion.certificacion_persona
					(
						per_codigo,
						perpre_codigo,
						cerper_nota_total,
						cerper_estado,
						cerper_fecha_registro,
						cerper_usuario_base_datos,
						codcer_numero,
						codcer_gestion,
                        ran_codigo
					)
					VALUES
					(
						_record.per_codigo,
						_record.perpre_codigo,
						_record.evadocperins_nota_total,
						1,
						_fecha_registro,
						_usuario_bd,
						_codcer_numero,
						_codcer_gestion,
                        _ran_codigo
                        );
					
					if found then
						exit;
					end if;

					EXCEPTION WHEN unique_violation THEN
						raise notice 'SE LLEGO AL NUMERO MAXIMO DE INTENTOS PARA LA ASIGNACION DEL CODIGO.';
						_cont_intentos := _cont_intentos + 1;
					END;
				
					IF(_codcer_numero IS NULL)THEN
						_err_Mensaje := '#ERROR AL ASIGNAR EL NUMERO DE CERTIFICADO CORRESPONDIENTE.';
						RAISE EXCEPTION transaction_rollback;
					END IF;
				END LOOP;
			END IF;
			
			-- ConsolidaciÃ³n de informaciÃ³n de manera masiva
			UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
			SET
				-- evadocperins_codigo -- this column value is auto-generated
				evadocperins_nota_total = CASE WHEN evadocperins_nota_total <> _record.evadocperins_nota_total THEN evadocperins_nota_total
								ELSE _record.evadocperins_nota_total END,
				evadocperins_estado = _evadocperins_estado
			WHERE edpi.asidoc_codigo = _asidoc_codigo
				AND edpi.procur_codigo = _record.procur_codigo
				AND edpi.per_codigo = _record.per_codigo
				AND edpi.perpre_codigo = _record.perpre_codigo;
		END LOOP;
		/*
		-- ConsolidaciÃ³n de informaciÃ³n de manera masiva
		UPDATE seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
		SET
			-- evadocperins_codigo -- this column value is auto-generated
			evadocperins_nota_total = CASE WHEN evadocperins_nota_total <> record.evadocperins_nota_total THEN evadocperins_nota_total
							ELSE record.evadocperins_nota_total END,
			evadocperins_estado = _evadocperins_estado
		FROM  seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas (
			-1, -- _per_codigo INTEGER,
			'', -- _perpre_codigo CHARACTER VARYING,
			'', -- _perpre_codigo_preinscripcion CHARACTER VARYING,
			'', -- criterio_busqueda CHARACTER VARYING,
			_procur_codigo, -- _procur_codigo INTEGER,
			_asidoc_codigo, -- _asidoc_codigo INTEGER,
			1 -- _reporte INTEGER
		) ssedpi
		WHERE edpi.asidoc_codigo = ssedpi.asidoc_codigo
			AND edpi.procur_codigo = ssedpi.procur_codigo;
		*/	
		_objrespuesta_general.inf_codigo := _procur_codigo;
		_objrespuesta_general.inf_complemento := ''::CHARACTER VARYING;
		_objrespuesta_general.err_existente := _err_existente;
		_objrespuesta_general.err_mensaje := _err_mensaje;
		_objrespuesta_general.err_codigo := _err_codigo;
		
		RETURN NEXT _objrespuesta_general;
		
		EXCEPTION
			WHEN transaction_rollback THEN
			BEGIN
				GET STACKED DIAGNOSTICS _objrespuesta_general.err_Codigo = RETURNED_SQLSTATE;
				RAISE NOTICE 'Error de validacion :(%) ', _err_Mensaje;
				_objrespuesta_general.inf_codigo := -1;
				_objrespuesta_general.err_Existente := 1;
				_objrespuesta_general.err_Mensaje := _err_Mensaje;
				RETURN NEXT _objrespuesta_general;
			END;
            
			WHEN OTHERS THEN
			BEGIN
				GET STACKED DIAGNOSTICS _objrespuesta_general.err_Mensaje := MESSAGE_TEXT,
                                                _err_Mensaje_detalle := PG_EXCEPTION_CONTEXT;
				RAISE NOTICE 'Error de validacion :(%) ', _objrespuesta_general;
				RAISE NOTICE 'Detalle:[%] ', _err_Mensaje_detalle;
				_objrespuesta_general.err_Existente := 1;
				_objrespuesta_general.inf_codigo := -1;
				RETURN NEXT _objrespuesta_general;
			END;
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION seguimiento_capacitacion.spr_upd_consolidar_evaluacion_docente_personas_inscritas(integer, integer)
  OWNER TO usr_academico;
COMMENT ON FUNCTION seguimiento_capacitacion.spr_upd_consolidar_evaluacion_docente_personas_inscritas(integer, integer) IS '
---------------------------------------------------------------------------
Autor : Lic. Andres Miguel Altamirano IbaÃ±ez
Fecha : 16/05/2017
DescripciÃ³n : Realiza el proceso de consolidaciÃ³n de informaciÃ³n de las 
notas transcritas por el docente.

Ejemplo de uso:

SELECT * FROM  seguimiento_capacitacion.spr_upd_consolidar_evaluacion_docente_personas_inscritas (
16, --  procur_codigo integer,
-1	--  asidoc_codigo integer
)

La columna asidoc_codigo por el momento sera -1

Salida : Tipo de dato objinformacion_afectada
---------------------------------------------------------------------------';
