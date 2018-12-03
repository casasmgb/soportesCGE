-- Function: seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas(integer, character varying, character varying, character varying, integer, integer, integer)

-- DROP FUNCTION seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas(integer, character varying, character varying, character varying, integer, integer, integer);

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas(
    IN _per_codigo integer,
    IN _perpre_codigo character varying,
    IN _perpre_codigo_preinscripcion character varying,
    IN _criterio_busqueda character varying,
    IN _procur_codigo integer,
    IN _asidoc_codigo integer,
    IN _reporte integer)
  RETURNS TABLE(per_codigo integer, perpre_codigo character varying, perpre_codigo_preinscripcion character varying, perpre_numero_docidentidad character varying, perpre_apellido_paterno character varying, perpre_apellido_materno character varying, perpre_apellido_esposo character varying, perpre_nombres character varying, perpre_genero integer, perpre_genero_descripcion character varying, perpre_fecha_nacimiento date, perpre_correo_electronico character varying, perpre_numero_celular character varying, dep_codigo_expedicion integer, dep_descripcion_expedicion character varying, nivest_codigo integer, nivest_descripcion character varying, amblab_codigo integer, amblab_descripcion character varying, tipfun_codigo integer, tipfun_descripcion character varying, procur_codigo integer, procurcod_sigla character varying, procur_cantidad_dias numeric, procur_fecha_inicio date, procur_fecha_final date, procur_hora_inicial timestamp without time zone, procur_hora_fin timestamp without time zone, cur_codigo integer, cur_codigo_sigla character varying, cur_nombre character varying, cur_carga_horaria numeric, nivres_codigo integer, nivres_descripcion character varying, tipcur_codigo integer, tipcur_descripcion character varying, tipmod_codigo integer, tipmod_descripcion character varying, dep_codigo_programacion integer, dep_descripcion_programacion character varying, evadocperins_codigo integer, evadocperins_nota_total numeric, calificacion_descripcion character varying, evadocperins_calificaciones xml, estado_opcion integer, descripcion_opcion character varying, numero_certificado character varying, gestion_certificado integer, sigla_certificado character varying, fecha_impresion_certificado timestamp without time zone, ran_codigo integer, ran_sigla character varying, ran_descripcion character varying, ran_inicio numeric, ran_fin numeric, err_existente integer, err_mensaje character varying, err_codigo integer) AS
$BODY$
	DECLARE
		-- Definición de variables locales
		__per_codigo INTEGER;
		__perpre_codigo CHARACTER VARYING(20);
		__perpre_codigo_preinscripcion CHARACTER VARYING (20);
		__criterio_busqueda CHARACTER VARYING (300);
		__procur_codigo INTEGER;
		__asidoc_codigo INTEGER;
		__reporte INTEGER;
		__valor_xml_defecto XML;
		
		_nota_minima NUMERIC(10,2);
		_nota_maxima NUMERIC(10,2);
		_estado_inscripcion INTEGER;
		
		--Definicion de variables de excepcion
		_err_existente INTEGER;
		_err_Mensaje CHARACTER VARYING (1000);
		_err_codigo INTEGER;
		_err_mensaje_detallado varchar(80000);
	BEGIN
		-- Asignación de las variables locales
		__per_codigo := fn_valida_nulos(_per_codigo::CHARACTER VARYING, 1)::INTEGER;
		__perpre_codigo := upper( public.fn_formatea_cadena_sn_espacios(fn_valida_nulos(_perpre_codigo, 3)));
		__perpre_codigo_preinscripcion := upper( public.fn_formatea_cadena_sn_espacios(fn_valida_nulos(_perpre_codigo_preinscripcion, 3))); 
		__criterio_busqueda := fn_valida_nulos(_criterio_busqueda, 3);
		__procur_codigo := _procur_codigo;
		__asidoc_codigo := _asidoc_codigo;
		__reporte := _reporte; -- 1 : Reporte para bandeja de entrada ; 2 : Reporte para impresion de certificados
		
		_estado_inscripcion := 3; -- 3 : Estado de inscrito
		_err_existente := 0;
		_err_Mensaje := '#SE ENCONTRO LA INFORMACION CON LOS PARAMETROS ENVIADOS';
		_err_codigo := 0;
		
		-- Validando que las notas definidas por el docentes esten consolidadas
		
		IF EXISTS (SELECT dce.doccrieva_codigo
		           FROM seguimiento_capacitacion.docente_criterios_evaluacion AS dce
		           WHERE dce.procur_codigo = __procur_codigo AND dce.doccrieva_estado not in (2,0) 
			   LIMIT 1) THEN
			_err_Mensaje := '#PARA VISUALIZAR LA INFORMACION DE LAS PERSONAS QUE PARTICIPARON EN EL EVENTO, ES NECESARIO QUE LAS CALIFICACIONES DEFINIDAS POR EL DOCENTE ESTEN CONSOLIDADAS.';
			raise exception transaction_rollback;
		END IF;
		
		-- Validando que la base de calificación amerita una calificación
		SELECT bc.bascal_minima, bc.bascal_maxima
		INTO _nota_minima, _nota_maxima
		FROM seguimiento_capacitacion.base_calificacion AS bc
		INNER JOIN seguimiento_capacitacion.programacion_curso_base_calificacion AS pcbc
			ON bc.bascal_codigo = pcbc.bascal_codigo
		WHERE pcbc.procur_codigo = __procur_codigo;
		
		IF (_nota_minima = 0 AND _nota_maxima = 0) THEN
			SELECT query_to_xml(
			$$
			SELECT -1::INTEGER AS doccrieva_codigo, 'NULL'::VARCHAR(250) AS doccrieva_descripcion, 0::NUMERIC(10,2) AS doccrieva_ponderacion, 0::NUMERIC(10,2) calificacion
			$$, TRUE, FALSE, '')
			INTO __valor_xml_defecto;
		END IF; 
		
		-- Verificando que las notas definidas por el docente, sean igual a la nota maxima definida para el curso
		IF (SELECT COALESCE (SUM(dce.doccrieva_ponderacion), 0) 
		    FROM seguimiento_capacitacion.docente_criterios_evaluacion AS dce
		    WHERE dce.procur_codigo = __procur_codigo AND dce.doccrieva_estado = 2) > _nota_maxima THEN 
		    	_err_Mensaje := '#LA PONDERACION DEFINIDA POR EL DOCENTE NO COINCIDE CON EL VALOR MAXIMO DE NOTA DEFINIDA PARA EL EVENTO.';
			raise exception transaction_rollback;
		END IF;
		
		IF ((SELECT t.err_existente
		     FROM seguimiento_capacitacion.spr_sel_pre_inscritos(
					CASE WHEN __perpre_codigo <> '' THEN __perpre_codigo ELSE '' END, -- perpre_codigo varchar,
					_estado_inscripcion, -- perpre_estado integer,
					CASE WHEN __perpre_codigo_preinscripcion <> '' THEN __perpre_codigo_preinscripcion ELSE '' END, -- perpre_codigo_preinscripcion varchar
					-1, -- dep_codigo_prog integer,
					CASE WHEN __procur_codigo <> -1 THEN __procur_codigo ELSE -1 END, -- procur_codigo INTEGER
					-1, -- cur_codigo integer,
					'1900-01-01', -- fecha_inicio date,
					'1900-01-01', -- fecha_fin date,
					'', -- cadena_busqueda varchar
					-1  -- tipo_publicacion integer
		     ) AS t
		     LIMIT 1) = 1) THEN
		     	_err_Mensaje := '#NO SE ENCONTRARON PERSONAS QUE PARTICIPARON EN EL EVENTO. POR FAVOR REVISE LA TRANSCRIPCION.';
			raise exception transaction_rollback;
		END IF;
		
		RETURN query
			WITH valores_iniciales_xml AS (
				SELECT query_to_xml(
					'
						SELECT 	dce.doccrieva_codigo, --  dce.asidoc_codigo, dce.procur_codigo,
							dce.doccrieva_descripcion, dce.doccrieva_ponderacion, 0::NUMERIC(10,2) AS calificacion 
						FROM seguimiento_capacitacion.asignacion_docente AS ad
						INNER JOIN seguimiento_capacitacion.docente_criterios_evaluacion AS dce
							ON ad.asidoc_codigo = dce.asidoc_codigo AND ad.procur_codigo = dce.procur_codigo
						WHERE dce.procur_codigo = '|| __procur_codigo ||' AND dce.doccrieva_estado = 2 
						ORDER BY dce.doccrieva_codigo
					', TRUE, FALSE, '') AS notas_iniciales
			), datos_certificados AS (
				SELECT cp.per_codigo, cp.perpre_codigo, cp.cerper_nota_total,
				       cp.cerper_estado, cp.codcer_numero, cp.codcer_gestion,
                       
				      CURRENT_TIMESTAMP::TIMESTAMP as cerper_fecha_registro-- cp.cerper_fecha_registro
                       , cc.codcer_sigla, cp.ran_codigo,r.ran_descripcion, r.ran_sigla, r.ran_inicio, r.ran_fin
                       
				FROM seguimiento_capacitacion.certificacion_persona AS cp
				INNER JOIN seguimiento_capacitacion.codificacion_certificado AS cc
					ON cp.codcer_numero = cc.codcer_numero AND cp.codcer_gestion = cc.codcer_gestion
                    inner join seguimiento_capacitacion.rangos r
                    on r.ran_codigo = cp.ran_codigo
				INNER JOIN  seguimiento_capacitacion.spr_sel_pre_inscritos(
						CASE WHEN __perpre_codigo <> '' THEN __perpre_codigo ELSE '' END, -- perpre_codigo varchar,
						_estado_inscripcion, -- perpre_estado integer,
						CASE WHEN __perpre_codigo_preinscripcion <> '' THEN __perpre_codigo_preinscripcion ELSE '' END, -- perpre_codigo_preinscripcion varchar
						-1, -- dep_codigo_prog integer,
						CASE WHEN __procur_codigo <> -1 THEN __procur_codigo ELSE -1 END, -- procur_codigo INTEGER
						-1, -- cur_codigo integer,
						'1900-01-01', -- fecha_inicio date,
						'1900-01-01', -- fecha_fin date,
						'', -- cadena_busqueda varchar
						-1  -- tipo_publicacion integer
				) AS t
					ON cp.per_codigo = t.per_codigo AND cp.perpre_codigo = t.perpre_codigo
			)

			SELECT 	t.per_codigo,
				t.perpre_codigo,
				t.perpre_codigo_preinscripcion,--  CHARACTER VARYING (40),
				t.perpre_numero_docidentidad, -- CHARACTER VARYING (12),
				t.perpre_apellido_paterno, -- CHARACTER VARYING (50),
				t.perpre_apellido_materno, -- CHARACTER VARYING (50),
				t.perpre_apellido_esposo, -- CHARACTER VARYING (50),
				t.perpre_nombres, -- CHARACTER VARYING (100),
				t.perpre_genero, -- INTEGER,
				t.perpre_genero_descripcion, -- CHARACTER VARYING (20),
				t.perpre_fecha_nacimiento, -- DATE,
				t.perpre_correo_electronico, -- CHARACTER VARYING (100),
				t.perpre_numero_celular, -- CHARACTER VARYING (20),
				t.dep_codigo_expedicion, -- INTEGER,
				t.dep_descripcion_expedicion, -- CHARACTER VARYING (40),
				t.nivest_codigo, -- INTEGER,
				t.nivest_descripcion, -- CHARACTER VARYING (80),
				t.amblab_codigo, -- INTEGER,
				t.amblab_descripcion, -- CHARACTER VARYING (50),
				t.tipfun_codigo, -- INTEGER,
				t.tipfun_descripcion, -- CHARACTER VARYING (50),
				t.procur_codigo,
				t.procurcod_sigla, -- CHARACTER VARYING (100),
				t.procur_cantidad_dias, -- NUMERIC,
				t.procur_fecha_inicio, -- DATE,
				t.procur_fecha_final, -- DATE,
				t.procur_hora_inicial, -- TIMESTAMP,
				t.procur_hora_fin, -- TIMESTAMP,
				t.cur_codigo, -- INTEGER,
				t.cur_codigo_sigla, -- CHARACTER VARYING,
				t.cur_nombre, -- CHARACTER VARYING,
				t.cur_carga_horaria, -- NUMERIC(10,2),
                t.nivres_codigo_evento,
                t.nivres_descripcion_evento,
				t.tipcur_codigo, -- INTEGER,
				t.tipcur_descripcion, -- CHARACTER VARYING,
				t.tipmod_codigo, -- INTEGER,
				t.tipmod_descripcion, -- CHARACTER VARYING,
				t.dep_codigo_programacion, -- INTEGER,
				t.dep_descripcion_programacion, -- CHARACTER VARYING, 
              
				CASE WHEN edpi.evadocperins_codigo IS NULL THEN -1 ELSE edpi.evadocperins_codigo END::INTEGER AS evadocperins_codigo,
				CASE WHEN edpi.evadocperins_nota_total IS NULL THEN 0 ELSE edpi.evadocperins_nota_total END::NUMERIC(10,2) AS evadocperins_nota_total,
				
				CASE WHEN (CASE WHEN edpi.evadocperins_nota_total IS NULL THEN 0 ELSE edpi.evadocperins_nota_total END::NUMERIC(10,2)) >= _nota_minima THEN 'APROBADO'
					ELSE 'REPROBADO'
				END::CHARACTER VARYING(20) AS calificacion_descripcion,
				
				
				CASE WHEN _nota_minima = 0 AND _nota_maxima = 0 THEN __valor_xml_defecto -- PARA EL CASO EN EL QUE NO SE REQUIERA TRANSCRIBIR NOTA ALGUNA
					ELSE
					CASE WHEN edpi.evadocperins_calificaciones IS NULL THEN vix.notas_iniciales ELSE edpi.evadocperins_calificaciones END  
				END AS evadocperins_calificaciones,
				
				COALESCE (edpi.evadocperins_estado, -1)::INTEGER AS estado_opcion,
				
				CASE COALESCE (edpi.evadocperins_estado, -1) 
					WHEN -1 THEN 'GUARDAR'
					WHEN 1 THEN 'EDITAR'
					WHEN 2 THEN 'CONSOLIDADO'
				END::CHARACTER VARYING (20) AS descripcion_opcion,
				-- Adicionado
				COALESCE (dc.codcer_numero, '-1')::CHARACTER VARYING, -- -1, -- numero_certificado INTEGER,
				COALESCE (dc.codcer_gestion, 1900)::INTEGER, -- 1900, -- gestion_certificado INTEGER,
				COALESCE (dc.codcer_sigla, '')::CHARACTER VARYING, -- sigla_certificado CHARACTER VARYING,
				COALESCE (dc.cerper_fecha_registro, '1900-01-01 00:00:00')::TIMESTAMP, -- fecha_impresion_certificado TIMESTAMP,
                
  				COALESCE (dc.ran_codigo, -1)::integer as ran_codigo,
                COALESCE (dc.ran_sigla, '')::varchar as ran_sigla,
                COALESCE (dc.ran_descripcion, '')::varchar as ran_descripcion,
                COALESCE (dc.ran_inicio, 0)::numeric(10,2) as ran_inicio,
                COALESCE (dc.ran_fin, 0)::numeric(10,2) as ran_fin,
               

				_err_existente,
				td.tipdir_descripcion,
				td.tipdir_codigo
			FROM valores_iniciales_xml AS vix,
			seguimiento_capacitacion.spr_sel_pre_inscritos(
				CASE WHEN __perpre_codigo <> '' THEN __perpre_codigo ELSE '' END, -- perpre_codigo varchar,
				_estado_inscripcion, -- perpre_estado integer,
				CASE WHEN __perpre_codigo_preinscripcion <> '' THEN __perpre_codigo_preinscripcion ELSE '' END, -- perpre_codigo_preinscripcion varchar
				-1, -- dep_codigo_prog integer,
				CASE WHEN __procur_codigo <> -1 THEN __procur_codigo ELSE -1 END, -- procur_codigo INTEGER
				-1, -- cur_codigo integer,
				'1900-01-01', -- fecha_inicio date,
				'1900-01-01', -- fecha_fin date,
				'', -- cadena_busqueda varchar
				-1  -- tipo_publicacion integer
			) AS t
            inner join seguimiento_capacitacion.curso c
            on c.cur_codigo = t.cur_codigo
               inner join seguimiento_capacitacion.directrices dir
               on dir.dir_codigo = c.dir_codigo
               inner join seguimiento_capacitacion.tipo_directriz td
               on td.tipdir_codigo = dir.tipdir_codigo
			LEFT JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi
				ON t.per_codigo = edpi.per_codigo AND t.perpre_codigo = edpi.perpre_codigo
			LEFT JOIN datos_certificados AS dc
				ON t.per_codigo = dc.per_codigo AND t.perpre_codigo = dc.perpre_codigo
			WHERE t.per_codigo = CASE WHEN __per_codigo = -1 THEN t.per_codigo ELSE __per_codigo END
				AND CASE WHEN __criterio_busqueda = '' THEN 1 = 1
					ELSE (t.perpre_numero_docidentidad = __criterio_busqueda OR (to_tsvector(t.perpre_nombres||' '||t.perpre_apellido_paterno||' '||t.perpre_apellido_materno) @@plainto_tsquery (
					'spanish', __criterio_busqueda )))
				    END
			ORDER BY t.perpre_apellido_paterno;
			
		IF NOT FOUND THEN
			_err_existente := 1;
			_err_Mensaje := '*NO SE ENCONTRO INFORMACION CON LOS PARAMEROS ENVIADOS.';
			_err_codigo := 1;
			
			RETURN query
			SELECT	-1, -- per_codigo INTEGER,
				''::CHARACTER VARYING, -- perpre_codigo VARCHAR,
				''::CHARACTER VARYING, -- perpre_codigo_preinscripcion VARCHAR,
				''::CHARACTER VARYING, -- perpre_numero_docidentidad VARCHAR,
				''::CHARACTER VARYING, -- perpre_apellido_paterno VARCHAR,
				''::CHARACTER VARYING, -- perpre_apellido_materno VARCHAR,
				''::CHARACTER VARYING, -- perpre_apellido_esposo VARCHAR,
				''::CHARACTER VARYING, -- perpre_nombres VARCHAR,
				-1, -- perpre_genero INTEGER,
				''::CHARACTER VARYING, -- perpre_genero_descripcion VARCHAR,
				'1900-01-01'::DATE, -- perpre_fecha_nacimiento DATE,
				''::CHARACTER VARYING, -- perpre_correo_electronico VARCHAR,
				''::CHARACTER VARYING, -- perpre_numero_celular VARCHAR,
				-1, -- dep_codigo_expedicion INTEGER,
				''::CHARACTER VARYING, -- dep_descripcion_expedicion VARCHAR,
				-1, -- nivest_codigo INTEGER,
				''::CHARACTER VARYING, -- nivest_descripcion VARCHAR,
				-1, -- amblab_codigo INTEGER,
				''::CHARACTER VARYING, -- amblab_descripcion VARCHAR,
				-1, -- tipfun_codigo INTEGER,
				''::CHARACTER VARYING, -- tipfun_descripcion VARCHAR,
				-1, -- procur_codigo INTEGER,
				''::CHARACTER VARYING, -- procurcod_sigla VARCHAR,
				0::NUMERIC(10,2), -- procur_cantidad_dias NUMERIC,
				'1900-01-01'::DATE, -- procur_fecha_inicio DATE,
				'1900-01-01'::DATE, -- procur_fecha_final DATE,
				'1900-01-01 00:00:00'::TIMESTAMP, -- procur_hora_inicial TIMESTAMP WITHOUT TIME ZONE,
				'1900-01-01 00:00:00'::TIMESTAMP, -- procur_hora_fin TIMESTAMP WITHOUT TIME ZONE,
				-1, -- cur_codigo INTEGER,
				''::CHARACTER VARYING, -- cur_codigo_sigla VARCHAR,
				''::CHARACTER VARYING, -- cur_nombre VARCHAR,
				0::NUMERIC(10,2), -- cur_carga_horaria NUMERIC,
                 -1,	-- nivres_codigo integer,
                 ''::varchar,	-- nivres_descripcion varchar,                
				-1, -- tipcur_codigo INTEGER,
				''::CHARACTER VARYING, -- tipcur_descripcion VARCHAR,
				-1, -- tipmod_codigo INTEGER,
				''::CHARACTER VARYING, -- tipmod_descripcion VARCHAR,
				-1, -- dep_codigo_programacion INTEGER,
				''::CHARACTER VARYING, -- dep_descripcion_programacion VARCHAR,
				-1, -- evadocperins_codigo INTEGER,
				0::NUMERIC(10,2), -- evadocperins_nota_total NUMERIC,
				''::CHARACTER VARYING, -- calificacion_descripcion VARCHAR,
				query_to_xml(
				$$
					SELECT -1::INTEGER AS doccrieva_codigo, 'NULL'::VARCHAR(250) AS doccrieva_descripcion, 0::NUMERIC(10,2) AS doccrieva_ponderacion, 0::NUMERIC(10,2) calificacion
				$$, TRUE, FALSE, ''), -- evadocperins_calificaciones XML,
				-1, -- estado_opcion INTEGER,
				''::CHARACTER VARYING, -- descripcion_opcion VARCHAR,
				-- Adicionado
				'-1'::CHARACTER VARYING, -- numero_certificado INTEGER,
				1900, -- gestion_certificado INTEGER,
				''::CHARACTER VARYING, -- sigla_certificado CHARACTER VARYING,
				'1900-01-01 00:00:00'::TIMESTAMP, -- fecha_impresion_certificado TIMESTAMP,
                     -1,-- ran_codigo integer,
                      ''::varchar, --ran_sigla varchar,
                     ''::varchar, -- ran_descripcion varchar,
                     0::numeric,	-- ran_inicio ::numeric(10,2),
                     0::numeric,	-- ran_fin numeric(10,2),                
				_err_existente,
				_err_mensaje,
				_err_codigo;
		END IF;
		
		EXCEPTION
			WHEN transaction_rollback THEN
			BEGIN
				GET STACKED DIAGNOSTICS _err_Codigo := RETURNED_SQLSTATE;
				RAISE NOTICE 'Error de validación : (%) ', _err_Mensaje;
				_err_Existente := 1;
				_err_Mensaje   := _err_Mensaje;
				RETURN QUERY
				SELECT	-1, -- per_codigo INTEGER,
					''::CHARACTER VARYING, -- perpre_codigo VARCHAR,
					''::CHARACTER VARYING, -- perpre_codigo_preinscripcion VARCHAR,
					''::CHARACTER VARYING, -- perpre_numero_docidentidad VARCHAR,
					''::CHARACTER VARYING, -- perpre_apellido_paterno VARCHAR,
					''::CHARACTER VARYING, -- perpre_apellido_materno VARCHAR,
					''::CHARACTER VARYING, -- perpre_apellido_esposo VARCHAR,
					''::CHARACTER VARYING, -- perpre_nombres VARCHAR,
					-1, -- perpre_genero INTEGER,
					''::CHARACTER VARYING, -- perpre_genero_descripcion VARCHAR,
					'1900-01-01'::DATE, -- perpre_fecha_nacimiento DATE,
					''::CHARACTER VARYING, -- perpre_correo_electronico VARCHAR,
					''::CHARACTER VARYING, -- perpre_numero_celular VARCHAR,
					-1, -- dep_codigo_expedicion INTEGER,
					''::CHARACTER VARYING, -- dep_descripcion_expedicion VARCHAR,
					-1, -- nivest_codigo INTEGER,
					''::CHARACTER VARYING, -- nivest_descripcion VARCHAR,
					-1, -- amblab_codigo INTEGER,
					''::CHARACTER VARYING, -- amblab_descripcion VARCHAR,
					-1, -- tipfun_codigo INTEGER,
					''::CHARACTER VARYING, -- tipfun_descripcion VARCHAR,
					-1, -- procur_codigo INTEGER,
					''::CHARACTER VARYING, -- procurcod_sigla VARCHAR,
					0::NUMERIC(10,2), -- procur_cantidad_dias NUMERIC,
					'1900-01-01'::DATE, -- procur_fecha_inicio DATE,
					'1900-01-01'::DATE, -- procur_fecha_final DATE,
					'1900-01-01 00:00:00'::TIMESTAMP, -- procur_hora_inicial TIMESTAMP WITHOUT TIME ZONE,
					'1900-01-01 00:00:00'::TIMESTAMP, -- procur_hora_fin TIMESTAMP WITHOUT TIME ZONE,
					-1, -- cur_codigo INTEGER,
					''::CHARACTER VARYING, -- cur_codigo_sigla VARCHAR,
					''::CHARACTER VARYING, -- cur_nombre VARCHAR,
					0::NUMERIC(10,2), -- cur_carga_horaria NUMERIC,
                 -1,	-- nivres_codigo integer,
                 ''::varchar,	-- nivres_descripcion varchar,                                    
					-1, -- tipcur_codigo INTEGER,
					''::CHARACTER VARYING, -- tipcur_descripcion VARCHAR,
					-1, -- tipmod_codigo INTEGER,
					''::CHARACTER VARYING, -- tipmod_descripcion VARCHAR,
					-1, -- dep_codigo_programacion INTEGER,
					''::CHARACTER VARYING, -- dep_descripcion_programacion VARCHAR,
					-1, -- evadocperins_codigo INTEGER,
					0::NUMERIC(10,2), -- evadocperins_nota_total NUMERIC,
					''::CHARACTER VARYING, -- calificacion_descripcion VARCHAR,
					query_to_xml(
					$$
						SELECT -1::INTEGER AS doccrieva_codigo, 'NULL'::VARCHAR(250) AS doccrieva_descripcion, 0::NUMERIC(10,2) AS doccrieva_ponderacion, 0::NUMERIC(10,2) calificacion
					$$, TRUE, FALSE, ''), -- evadocperins_calificaciones XML,
					-1, -- estado_opcion INTEGER,
					''::CHARACTER VARYING, -- descripcion_opcion VARCHAR,
					-- Adicionado
					'-1'::CHARACTER VARYING, -- numero_certificado INTEGER,
					1900, -- gestion_certificado INTEGER,
					''::CHARACTER VARYING, -- sigla_certificado CHARACTER VARYING,
					'1900-01-01 00:00:00'::TIMESTAMP, -- fecha_impresion_certificado TIMESTAMP,
                     -1,-- ran_codigo integer,
                      ''::varchar, --ran_sigla varchar,
                     ''::varchar, -- ran_descripcion varchar,
                     0::numeric,	-- ran_inicio ::numeric(10,2),
                     0::numeric,	-- ran_fin numeric(10,2),                    
					_err_existente,
					_err_mensaje,
					_err_codigo;
			END;
			WHEN OTHERS THEN
			BEGIN
				GET STACKED DIAGNOSTICS _err_Mensaje := MESSAGE_TEXT,
				_err_mensaje_detallado := PG_EXCEPTION_CONTEXT;
				_err_codigo := 1;
				_err_Existente := 1;
          			-- RAISE NOTICE 'Error de validacion :(%) , ',_err_Mensaje;
				-- RAISE NOTICE 'Error de validacion :(%) , ',_err_mensaje_detallado;                
					
				RETURN QUERY
				SELECT	-1, -- per_codigo INTEGER,
					''::CHARACTER VARYING, -- perpre_codigo VARCHAR,
					''::CHARACTER VARYING, -- perpre_codigo_preinscripcion VARCHAR,
					''::CHARACTER VARYING, -- perpre_numero_docidentidad VARCHAR,
					''::CHARACTER VARYING, -- perpre_apellido_paterno VARCHAR,
					''::CHARACTER VARYING, -- perpre_apellido_materno VARCHAR,
					''::CHARACTER VARYING, -- perpre_apellido_esposo VARCHAR,
					''::CHARACTER VARYING, -- perpre_nombres VARCHAR,
					-1, -- perpre_genero INTEGER,
					''::CHARACTER VARYING, -- perpre_genero_descripcion VARCHAR,
					'1900-01-01'::DATE, -- perpre_fecha_nacimiento DATE,
					''::CHARACTER VARYING, -- perpre_correo_electronico VARCHAR,
					''::CHARACTER VARYING, -- perpre_numero_celular VARCHAR,
					-1, -- dep_codigo_expedicion INTEGER,
					''::CHARACTER VARYING, -- dep_descripcion_expedicion VARCHAR,
					-1, -- nivest_codigo INTEGER,
					''::CHARACTER VARYING, -- nivest_descripcion VARCHAR,
					-1, -- amblab_codigo INTEGER,
					''::CHARACTER VARYING, -- amblab_descripcion VARCHAR,
					-1, -- tipfun_codigo INTEGER,
					''::CHARACTER VARYING, -- tipfun_descripcion VARCHAR,
					-1, -- procur_codigo INTEGER,
					''::CHARACTER VARYING, -- procurcod_sigla VARCHAR,
					0::NUMERIC(10,2), -- procur_cantidad_dias NUMERIC,
					'1900-01-01'::DATE, -- procur_fecha_inicio DATE,
					'1900-01-01'::DATE, -- procur_fecha_final DATE,
					'1900-01-01 00:00:00'::TIMESTAMP, -- procur_hora_inicial TIMESTAMP WITHOUT TIME ZONE,
					'1900-01-01 00:00:00'::TIMESTAMP, -- procur_hora_fin TIMESTAMP WITHOUT TIME ZONE,
					-1, -- cur_codigo INTEGER,
					''::CHARACTER VARYING, -- cur_codigo_sigla VARCHAR,
					''::CHARACTER VARYING, -- cur_nombre VARCHAR,
					0::NUMERIC(10,2), -- cur_carga_horaria NUMERIC,
                 -1,	-- nivres_codigo integer,
                 ''::varchar,	-- nivres_descripcion varchar,                                    
					-1, -- tipcur_codigo INTEGER,
					''::CHARACTER VARYING, -- tipcur_descripcion VARCHAR,
					-1, -- tipmod_codigo INTEGER,
					''::CHARACTER VARYING, -- tipmod_descripcion VARCHAR,
					-1, -- dep_codigo_programacion INTEGER,
					''::CHARACTER VARYING, -- dep_descripcion_programacion VARCHAR,
					-1, -- evadocperins_codigo INTEGER,
					0::NUMERIC(10,2), -- evadocperins_nota_total NUMERIC,
					''::CHARACTER VARYING, -- calificacion_descripcion VARCHAR,
					query_to_xml(
					$$
						SELECT -1::INTEGER AS doccrieva_codigo, 'NULL'::VARCHAR(250) AS doccrieva_descripcion, 0::NUMERIC(10,2) AS doccrieva_ponderacion, 0::NUMERIC(10,2) calificacion
					$$, TRUE, FALSE, ''), -- evadocperins_calificaciones XML,
					-1, -- estado_opcion INTEGER,
					''::CHARACTER VARYING, -- descripcion_opcion VARCHAR,
					-- Adicionado
					'-1'::CHARACTER VARYING, -- numero_certificado INTEGER,
					1900, -- gestion_certificado INTEGER,
					''::CHARACTER VARYING, -- sigla_certificado CHARACTER VARYING,
					'1900-01-01 00:00:00'::TIMESTAMP, -- fecha_impresion_certificado TIMESTAMP,
                     -1,-- ran_codigo integer,
                      ''::varchar, --ran_sigla varchar,
                     ''::varchar, -- ran_descripcion varchar,
                     0::numeric,	-- ran_inicio ::numeric(10,2),
                     0::numeric,	-- ran_fin numeric(10,2),
					_err_existente,
					_err_mensaje,
					_err_codigo;
			END;
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas(integer, character varying, character varying, character varying, integer, integer, integer)
  OWNER TO usr_academico;
COMMENT ON FUNCTION seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas(integer, character varying, character varying, character varying, integer, integer, integer) IS '
---------------------------------------------------------------------------
Autor : Lic. Andres Miguel Altamirano Ibañez
Fecha : 11/05/2017
Descripción : Realiza el proceso de selección de información en base a parametros
de dinamicos de busqueda, con el objetivo de visualizar en aplicación la información
y generar reportes para el usuarios.

Ejemplo de uso:
SELECT * 
FROM seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas (
	-1, -- _per_codigo INTEGER,
	"", -- _perpre_codigo CHARACTER VARYING,
	"", -- _perpre_codigo_preinscripcion CHARACTER VARYING,
	"", -- criterio_busqueda CHARACTER VARYING,
	1, -- _procur_codigo INTEGER,
	-1, -- _asidoc_codigo INTEGER,
	1 -- _reporte INTEGER
) 

Salida : Tipo de dato TABLA
---------------------------------------------------------------------------';
