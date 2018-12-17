/*
 * Usuario: USRACADEMICO
 * Base de datos: siga_soportes
 * */
-- Function: seguimiento_capacitacion.spr_sel_funcionario_certificado_externo_especializacion(integer, character varying, integer)

-- DROP FUNCTION seguimiento_capacitacion.spr_sel_funcionario_certificado_externo_especializacion(integer, character varying, integer);

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.spr_sel_funcionario_certificado_externo_especializacion(prodoc_codigo integer, perpre_codigo character varying, per_codigo integer)
  RETURNS SETOF seguimiento_capacitacion.obj_certificacion_especializacion AS
$BODY$
	DECLARE
		-- Definición de variables locales
        _prodoc_codigo INTEGER;
		_per_codigo INTEGER;
		_perpre_codigo CHARACTER VARYING(20);
		_procur_codigo INTEGER;
		_valor_xml_defecto XML;
		_nota_minima NUMERIC(10,2);
		_nota_maxima NUMERIC(10,2);
		_estado_inscripcion INTEGER;
		_cantidad_reimpresiones integer;
        _eventos_notas_por_defecto json;
        _programacion_evento_xml_por_defecto XML;
        
		--Definicion de variables de excepcion
		_err_existente INTEGER;
		_err_Mensaje CHARACTER VARYING (1000);
		_err_codigo INTEGER;
		_err_mensaje_detallado varchar(80000);
        
        --RETORNO DE LOS DATOS
        _objCertificadoEspecializacionExterno seguimiento_capacitacion.obj_certificacion_especializacion%rowtype;
	BEGIN
		-- Asignación de las variables locales
   		_prodoc_codigo := fn_valida_nulos(prodoc_codigo::CHARACTER VARYING, 1)::INTEGER;
		_perpre_codigo := upper( public.fn_formatea_cadena_sn_espacios(fn_valida_nulos(perpre_codigo, 3)));
		_per_codigo := fn_valida_nulos(per_codigo::CHARACTER VARYING, 1)::INTEGER;
		
		_estado_inscripcion := 3; 
		_err_existente := 0;
		_err_Mensaje := '#SE ENCONTRO LA INFORMACION CON LOS PARAMETROS ENVIADOS';
		_err_codigo := 0;
		
        _cantidad_reimpresiones := 1;
        
         select query_to_xml('
        	select -1 as procur_codigo,
            ''NULL''::VARCHAR AS procurcod_sigla,
            ''1900-01-01''::TIMESTAMP AS procur_fecha_inicio,
            ''1900-01-01''::TIMESTAMP AS procur_fecha_final,   
            0::numeric(10,2) as procur_cantidad_dias,
            0 as procur_plaza_minima,
            0 as procur_plaza_maxima,
           ''NULL''::VARCHAR AS tipmod_descripcion,
           ''NULL''::VARCHAR AS cur_nombre,
           ''NULL''::VARCHAR AS nivres_descripcion,
		   ''NULL''::VARCHAR AS tipcur_descripcion,
   		   0::numeric(10,2) AS  cur_carga_horaria,           
		   0::numeric(10,2) AS monto_total_curso                      
        ',true, false,'') into _programacion_evento_xml_por_defecto;
        
        SELECT
             array_to_json ( array_agg ( row_to_json ( (
                                                         SELECT
                                                              d
                                                         FROM (
                                                                SELECT
                                                                     - 1::INTEGER AS procur_codigo,
                                                                     ''::VARCHAR AS cur_nombre,
                                                                     - 1 AS evadocperins_estado,
                                                                     0::NUMERIC evadocperins_nota_total,
                                                                     0::NUMERIC nota_certificado,
                                                                     ''::VARCHAR AS perpre_codigo,
                                                                     - 1::INTEGER AS per_codigo,
                                                                     ''::varchar as  nota_descripcion,
                                                                    -1 as  bandera_evaluacion_docente
                                                              ) d
             ) ) ) ) AS eventos_notas
        INTO _eventos_notas_por_defecto;
        
        
        SELECT
             -1,             --prodoc_codigo INTEGER,
             '',             --prodoc_descripcion VARCHAR,
             '1900-01-01',             --prodoc_fecha_doc DATE,
             '',             --prodoc_numero_documento VARCHAR,
            -1,--  dir_codigo INTEGER,
            '',	--  dir_descripcion VARCHAR,
             '',             --perpre_codigo VARCHAR,
             '',             --perpre_codigo_preinscripcion VARCHAR,
             '',             --perpre_numero_docidentidad VARCHAR,
             '',             --perpre_apellido_paterno VARCHAR,
             '',             --perpre_apellido_materno VARCHAR,
             '',             --perpre_apellido_esposo VARCHAR,
             '',             --perpre_nombres VARCHAR,
             -1,             --perpre_genero INTEGER,
             '',             --perpre_genero_descripcion VARCHAR,
             '1900-01-01',             --perpre_fecha_nacimiento DATE,
             '',             --perpre_profesion VARCHAR,
             '',             --perpre_correo_electronico VARCHAR,
             '',             --perpre_numero_celular VARCHAR,
             '',             --perpre_datos_emergencia VARCHAR,
             '',             --perpre_numero_celular_emergencia VARCHAR,
             '',             --perpre_entidad_trabajo VARCHAR,
             '',             --perpre_entidad_sigla VARCHAR,
             '',             --perpre_entidad_direccion VARCHAR,
             '',             --perpre_entidad_telefono VARCHAR,
             '',             --perpre_entidad_interno VARCHAR,
             '',             --perpre_cargo VARCHAR,
             '',             --perpre_unidad VARCHAR,
             '',             --perpre_numero_registro_firma_cge VARCHAR,
             '1900-01-01',             --perpre_fecha_numero_registro_firma_cge DATE,
             '',             --perpre_nombre_organizacion VARCHAR,
             '',             --perpre_municipio_descripcion VARCHAR,
             '',             --perpre_tioc VARCHAR,
             -1,             --perpre_estado INTEGER,
             '',             --perpre_estado_descripcion VARCHAR,
             '1900-01-01',             --perpre_fecha_registro TIMESTAMP WITHOUT TIME ZONE,
             -1,             --dep_codigo_expedicion INTEGER,
             '',             --dep_descripcion_expedicion VARCHAR,
             -1,             --nivest_codigo INTEGER,
             '',             --nivest_descripcion VARCHAR,
             -1,             --amblab_codigo INTEGER,
             '',             --amblab_descripcion VARCHAR,
             -1,             --tipfun_codigo INTEGER,
             '',             --tipfun_descripcion VARCHAR,
             -1,             --nivres_codigo INTEGER,
             '',             --nivres_descripcion VARCHAR,
             -1,             --tipact_codigo INTEGER,
             '',             --tipact_descripcion VARCHAR,
             -1,             --dep_codigo_control_social INTEGER,
             '',             --dep_control_social_descripcion VARCHAR,
             -1,             --reg_codigo INTEGER,
             '',             --reg_descripcion VARCHAR,
             -1,             --procur_codigo INTEGER,
             '',             --procurcod_sigla VARCHAR,
             '1900-01-01',             --fecha_inicio_prog_esp DATE,
             '1900-01-01',             --fecha_fin_prog_esp DATE,
             -1,             --tipcur_codigo INTEGER,
             '',             --tipcur_descripcion VARCHAR,
             -1,             --tipmod_codigo INTEGER,
             '',             --tipmod_descripcion VARCHAR,
             0,             --monto_total NUMERIC,
             -1,             --dep_codigo_programacion INTEGER,
             '',             --dep_descripcion_programacion VARCHAR,
             -1,             --dep_codigo_ubicacion INTEGER,
             '',             --dep_descripcion_ubicacion VARCHAR,
             '',             --ubiparcur_ubicacion_especifica VARCHAR,
             -1,             --tippub_codigo INTEGER,
             '',             --tippub_descripcion VARCHAR,
             -1,             --nivres_codigo_evento INTEGER,
             '',             --nivres_descripcion_evento VARCHAR,
             _programacion_evento_xml_por_defecto, --programaciones_evento xml
              0,	-- total_carga_horaria NUMERIC,
             _eventos_notas_por_defecto,             --eventos_notas JSON,
             -1,             --bandera_reimpresion INTEGER,
             -1,             --bandera_evaluacion_evento INTEGER,
             -1,             --bandera_impresion_certificado INTEGER,
             0,             --err_existente INTEGER,
             '',             --err_mensaje VARCHAR,
             0 --err_codigo INTEGER
        INTO _objCertificadoEspecializacionExterno;

		                  
		 for _objCertificadoEspecializacionExterno in (
         --

                with
                total_cursos_programados as (
                --
                SELECT
                     pcd.prodoc_codigo,
                     count ( * ) AS total_cursos
                FROM seguimiento_capacitacion.programacion_curso_documento AS pcd
                WHERE pcd.procurdoc_estado = 2 and pcd.prodoc_codigo = CASE WHEN _prodoc_codigo =  -1 THEN PCD.prodoc_codigo ELSE _prodoc_codigo END
                group by pcd.prodoc_codigo
                ), 
                tipo_nota as (
                              SELECT

                   PCBC.procur_codigo,
                   BC.bascal_minima,
                   BC.bascal_maxima
              FROM  seguimiento_capacitacion.programacion_curso_base_calificacion PCBC 
                   INNER JOIN seguimiento_capacitacion.base_calificacion BC ON BC.bascal_codigo = PCBC.bascal_codigo
                ),
                
                programacion_especialidad as (
                --
                SELECT
                     pcd.procur_codigo,
                     pcd.prodoc_codigo,
                     c.cur_nombre,
                     pc.procur_fecha_inicio,
                    tn.bascal_minima,
                    tn.bascal_maxima
                FROM seguimiento_capacitacion.programacion_curso_documento pcd
                     INNER JOIN seguimiento_capacitacion.programacion_curso pc ON pc.procur_codigo = pcd.procur_codigo
                     INNER JOIN seguimiento_capacitacion.curso c ON c.cur_codigo = pc.cur_codigo
                     inner join tipo_nota as tn
                     on tn.procur_codigo = pcd.procur_codigo

                WHERE pcd.procurdoc_estado = 2 AND
                      c.cur_estado = 2 AND
                      pc.procur_estado = 2
                and pcd.prodoc_codigo = CASE WHEN _prodoc_codigo =  -1 THEN PCD.prodoc_codigo ELSE _prodoc_codigo END
                ), eventos_consolidados as (
                --
                SELECT	
                     edpi.perpre_codigo,
                     edpi.per_codigo,
                     edpi.procur_codigo,
                     edpi.evadocperins_estado,
                    
                     edpi.evadocperins_nota_total,
                     --CASE WHEN rr.evadocperins_nota_total IS NULL THEN edpi.evadocperins_nota_total ELSE rr.evadocperins_nota_total END AS evadocperins_nota_total,
                     COALESCE(cp.cerper_nota_total,0) as nota_certificado,
                   
                     case when eed.perpre_codigo is null then 0 else 1 end::integer bandera_evaluacion_docente

                FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
                     left join seguimiento_capacitacion.certificacion_persona cp                     
                     on cp.perpre_codigo = edpi.perpre_codigo and cp.per_codigo = edpi.per_codigo 
                     left join seguimiento_capacitacion.evaluacion_evento_docente eed
                     on eed.perpre_codigo = edpi.perpre_codigo and eed.per_codigo = edpi.per_codigo
                     /*LEFT JOIN(
                     SELECT edpi.evadocperins_nota_total,edpi.per_codigo,edpi.perpre_codigo,edpi.procur_codigo,cr.procur_codigo_reprobado
			     FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi
			     JOIN seguimiento_capacitacion.cursos_reprobados AS cr ON cr.procur_codigo=edpi.procur_codigo
			     WHERE edpi.per_codigo=154284 AND cr.currepro_estado=1	
                     )AS rr ON rr.per_codigo =edpi.per_codigo
                     */
                where edpi.evadocperins_estado in (1 ,2 )
                ) , especializacion_notas as  (
		
                SELECT
                    tab.prodoc_codigo,
                    tab.per_codigo,
		    count(*)::integer as  total_cursos,
                    --sum( case when tab.evadocperins_estado = 2 and tab.nota_certificado >= tab.bascal_minima then 1 else 0 end )::integer as total_materias_aprobadas,
                    --sum(case when tab.bandera_evaluacion_docente = 1 then 1 else 0 end )::integer as total_evaluacion_docente,
                    --sum(case when tab.evadocperins_estado = 2  then 1 else 0 end )::integer as total_eventos_consolidados,
                   sum( case when tab.evadocperins_estado = 2 and tab.nota_certificado >= tab.bascal_minima then 1 else --0 baa
                    	----------------------------------------
                      ( SELECT CASE WHEN edpi.evadocperins_nota_total>=bc.bascal_minima THEN 1 ELSE 0 END
                    	FROM seguimiento_capacitacion.cursos_reprobados AS cr 
                    	JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi ON cr.procur_codigo=edpi.procur_codigo AND edpi.per_codigo=tab.per_codigo
                    	JOIN seguimiento_capacitacion.programacion_curso_base_calificacion AS pcbc ON cr.procur_codigo=pcbc.procur_codigo
                    	JOIN seguimiento_capacitacion.base_calificacion AS bc ON bc.bascal_codigo=pcbc.bascal_codigo                    	
                    	WHERE cr.procur_codigo_reprobado= tab.procur_codigo )
                    	----------------------------------------
                         end )::integer as total_materias_aprobadas,
                    sum(case when tab.bandera_evaluacion_docente = 1 then 1 else --0 
			----------------------------------------
                      ( SELECT CASE WHEN edpi.evadocperins_nota_total>=bc.bascal_minima and ev.perpre_codigo is not null THEN 1 ELSE 0 END
                    	FROM seguimiento_capacitacion.cursos_reprobados AS cr 
                    	JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi ON cr.procur_codigo=edpi.procur_codigo AND edpi.per_codigo=tab.per_codigo
                    	JOIN seguimiento_capacitacion.programacion_curso_base_calificacion AS pcbc ON cr.procur_codigo=pcbc.procur_codigo
                    	JOIN seguimiento_capacitacion.base_calificacion AS bc ON bc.bascal_codigo=pcbc.bascal_codigo 
                    	LEFT JOIN seguimiento_capacitacion.evaluacion_evento_docente  ev ON ev.perpre_codigo=edpi.perpre_codigo                   	
                    	WHERE cr.procur_codigo_reprobado= tab.procur_codigo )
                    	----------------------------------------
                        
                        end )::integer as total_evaluacion_docente,
                     sum(case when tab.evadocperins_estado = 2  then 1 else --0 
                            -------------------------------
                    	(SELECT CASE WHEN edpi.evadocperins_nota_total>=bc.bascal_minima and edpi.evadocperins_estado=2 THEN 1 ELSE 0 END
                    	FROM seguimiento_capacitacion.cursos_reprobados AS cr 
                    	JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi ON cr.procur_codigo=edpi.procur_codigo AND edpi.per_codigo=tab.per_codigo
                    	JOIN seguimiento_capacitacion.programacion_curso_base_calificacion AS pcbc ON cr.procur_codigo=pcbc.procur_codigo
                    	JOIN seguimiento_capacitacion.base_calificacion AS bc ON bc.bascal_codigo=pcbc.bascal_codigo                    	
                    	WHERE cr.procur_codigo_reprobado= tab.procur_codigo )
                    	-------------------------------
                         end )::integer as total_eventos_consolidados,
 
                     
                     
                     
                     
                     array_to_json ( array_agg ( row_to_json ( (
                                                                 SELECT
                                                                      d
                                                                 FROM (
                                                                        SELECT
                                                                             tab.procur_codigo,
                                                                             tab.cur_nombre,
                                                                             tab.evadocperins_estado,
                                                                             tab.evadocperins_nota_total,
                                                                             tab.nota_certificado,
                                                                             tab.perpre_codigo,
                                                                             tab.per_codigo,
                                                                             cASE WHEN TAB.nota_certificado = 0  THEN 
                                                                             case when tab.evadocperins_nota_total >= tab.bascal_minima then 'APROBADO' 
                                                                             ELSE 'REPROBADO'   END  ELSE 'APROBADO' END::VARCHAR nota_descripcion,
                                                                           tab.bandera_evaluacion_docente
                                                                      ) d
                     ) ) ) ) AS eventos_notas
                FROM (

                       SELECT
                            pe.procur_codigo,
                            pe.prodoc_codigo,
                            pe.cur_nombre,
                            pe.bascal_minima,
                    		pe.bascal_maxima,
                            COALESCE ( ece.perpre_codigo, '' )::VARCHAR AS perpre_codigo,
                            COALESCE ( ece.per_codigo, - 1 )::INTEGER AS per_codigo,
                            -- COALESCE( ece.procur_codigo, -1 )::integer as procur_codigo,
                            COALESCE ( ece.evadocperins_estado, - 1 )::INTEGER AS evadocperins_estado,
                            COALESCE ( ece.evadocperins_nota_total, 0 )::NUMERIC ( 10, 2 ) AS evadocperins_nota_total,
                            COALESCE ( ece.nota_certificado, 0 )::NUMERIC ( 10, 2 ) AS nota_certificado,
                            COALESCE(ece.bandera_evaluacion_docente, 0) as bandera_evaluacion_docente
                            
                       FROM programacion_especialidad AS pe
                            LEFT JOIN eventos_consolidados ece ON ece.procur_codigo = pe.procur_codigo
                            order by pe.prodoc_codigo,pe.procur_fecha_inicio 

                     ) AS tab
                GROUP BY tab.prodoc_codigo , tab.per_codigo
		
                ), especializacion_notas_eventos as (

              SELECT
                   ce.prodoc_codigo,
                   ce.prodoc_descripcion,
                   ce.prodoc_fecha_doc,
                   ce.prodoc_numero_documento,
                   ce.procur_codigo_publicacion,
                   ce.dir_codigo,
                   ce.dir_descripcion,
                   ce.fecha_inicio_prog_esp,
                   ce.fecha_fin_prog_esp, 
                   ce.total_carga_horaria,
                   ce.programaciones_evento,
                   ev.per_codigo,
                   ev.eventos_notas ,
                   ev.total_cursos,
                   ev.total_materias_aprobadas,
                   ev.total_evaluacion_docente,
                   ev.total_eventos_consolidados
                FROM seguimiento_capacitacion.spr_sel_programacion_curso_especializacion_cge ( _prodoc_codigo, --  _codigo_prodoc integer,
                   - 1, --  _codigo_departamento integer,
                   - 1, --  _codigo_programacion integer,
                   2, --  _estado_programacion integer,
                   - 1, --  _codigo_directriz integer,
                   - 1 --  _tipo_publicacion integer
                   ) AS ce
                   LEFT JOIN especializacion_notas ev ON ev.prodoc_codigo = ce.prodoc_codigo-- AND ev.procur_codigo = ce.procur_codigo_publicacion

              )

              SELECT
                   t.prodoc_codigo,
                   t.prodoc_descripcion,
                   t.prodoc_fecha_doc,
                   t.prodoc_numero_documento,
                   t.dir_codigo,
                   t.dir_descripcion,
                   t.perpre_codigo,
                   t.perpre_codigo_preinscripcion,
                   t.perpre_numero_docidentidad,
                   t.perpre_apellido_paterno,
                   t.perpre_apellido_materno,
                   t.perpre_apellido_esposo,
                   t.perpre_nombres,
                   t.perpre_genero,
                   t.perpre_genero_descripcion,
                   t.perpre_fecha_nacimiento,
                   t.perpre_profesion,
                   t.perpre_correo_electronico,
                   t.perpre_numero_celular,
                   t.perpre_datos_emergencia,
                   t.perpre_numero_celular_emergencia,
                   t.perpre_entidad_trabajo,
                   t.perpre_entidad_sigla,
                   t.perpre_entidad_direccion,
                   t.perpre_entidad_telefono,
                   t.perpre_entidad_interno,
                   t.perpre_cargo,
                   t.perpre_unidad,
                   t.perpre_numero_registro_firma_cge,
                   t.perpre_fecha_numero_registro_firma_cge,
                   t.perpre_nombre_organizacion,
                   t.perpre_municipio_descripcion,
                   t.perpre_tioc,
                   t.perpre_estado,
                   t.perpre_estado_descripcion,
                   t.perpre_fecha_registro,
                   t.dep_codigo_expedicion,
                   t.dep_descripcion_expedicion,
                   t.nivest_codigo,
                   t.nivest_descripcion,
                   t.amblab_codigo,
                   t.amblab_descripcion,
                   t.tipfun_codigo,
                   t.tipfun_descripcion,
                   t.nivres_codigo,
                   t.nivres_descripcion,
                   t.tipact_codigo,
                   t.tipact_descripcion,
                   t.dep_codigo_control_social,
                   t.dep_control_social_descripcion,
                   t.reg_codigo,
                   t.reg_descripcion,
                   t.procur_codigo,
                   t.procurcod_sigla,
                   t.fecha_inicio_prog_esp,
                   t.fecha_fin_prog_esp,
                   t.tipcur_codigo,
                   t.tipcur_descripcion,
                   t.tipmod_codigo,
                   t.tipmod_descripcion,
                   t.monto_total,
                   t.dep_codigo_programacion,
                   t.dep_descripcion_programacion,
                   t.dep_codigo_ubicacion,
                   t.dep_descripcion_ubicacion,
                   t.ubiparcur_ubicacion_especifica,
                   t.tippub_codigo,
                   t.tippub_descripcion,
                   t.nivres_codigo_evento,
                   t.nivres_descripcion_evento,
                   --t.programaciones_evento,

                   CASE WHEN rr.bandera= 1 then t.programaciones_evento ELSE rr.programaciones_evento end, --baa
                   
                   COALESCE(en.total_carga_horaria, 0) as total_carga_horaria,
                   -- COALESCE ( en.eventos_notas, _eventos_notas_por_defecto ),
                   CASE WHEN rr.bandera= 1 THEN COALESCE ( en.eventos_notas, _eventos_notas_por_defecto ) ELSE rr.eventos_notas END AS eventos_notas, 
                  
                   CASE
                     WHEN en.total_cursos IS NULL THEN - 1
                     ELSE CASE
                            WHEN tc.total_cursos = en.total_materias_aprobadas THEN 1
                            ELSE 0
                          END
                   END,-- 28/08/2018 valor anterior por defecto: -1 ; se modifica para obtener una bandera que permita la impresion de Certificado de Programa
                   CASE
                     WHEN en.total_evaluacion_docente IS NULL THEN - 1
                     ELSE CASE
                            WHEN  en.total_eventos_consolidados = 0     THEN -1
                           WHEN  en.total_evaluacion_docente = en.total_eventos_consolidados and en.total_eventos_consolidados = tc.total_cursos   THEN 1
                            ELSE 0
                          END
                   END,
                   CASE
                     WHEN en.total_cursos IS NULL THEN - 1
                     ELSE CASE
                            WHEN tc.total_cursos = en.total_materias_aprobadas and COALESCE(en.total_evaluacion_docente,0) = COALESCE(en.total_materias_aprobadas, 0) THEN 1
                            ELSE 0
                          END
                   END,
                   0,
                   '',
                   0
              FROM seguimiento_capacitacion.spr_sel_pre_inscritos_especializacion ( _prodoc_codigo, --prodoc_codigo INTEGER
                   _perpre_codigo, --perpre_codigo varchar,
                   _estado_inscripcion, --  perpre_estado integer,
                   '',                   --  perpre_codigo_preinscripcion varchar
                   - 1, -- dep_codigo_prog integer,
                   - 1, -- procur_codigo INTEGER
                   '',                   --  cadena_busqueda varchar
                   - 1 --  tipo_publicacion integer
                   ) AS t
                   inner join total_cursos_programados as tc
                   on tc.prodoc_codigo = t.prodoc_codigo
                   LEFT JOIN especializacion_notas_eventos en ON t.prodoc_codigo = en.prodoc_codigo AND t.procur_codigo = en.procur_codigo_publicacion AND
                        t.per_codigo = en.per_codigo
                    --ecm baa
		   LEFT JOIN  seguimiento_capacitacion.spr_sel_programacion_curso_reprobados (t.per_codigo ,_prodoc_codigo )AS rr ON t.per_codigo=rr.codigo_persona

		   
         ) loop
         RETURN NEXT _objCertificadoEspecializacionExterno;
         end loop;
		
			
		IF NOT FOUND THEN
			_err_Mensaje := '*NO SE ENCONTRO INFORMACION CON LOS PARAMETROS ENVIADOS.';
            RAISE EXCEPTION transaction_rollback;
		END IF;
		
		EXCEPTION
			WHEN transaction_rollback THEN
			BEGIN
				GET STACKED DIAGNOSTICS _objCertificadoEspecializacionExterno.err_codigo := RETURNED_SQLSTATE;
				--RAISE NOTICE 'Error de validación : (%) ', _err_Mensaje;
				_objCertificadoEspecializacionExterno.err_existente := 1;
                _objCertificadoEspecializacionExterno.err_mensaje := _err_Mensaje;
				
                RETURN NEXT _objCertificadoEspecializacionExterno;
                
				
			END;
			WHEN OTHERS THEN
			BEGIN
				GET STACKED DIAGNOSTICS _objCertificadoEspecializacionExterno.err_mensaje := MESSAGE_TEXT,
				_err_mensaje_detallado := PG_EXCEPTION_CONTEXT;
				_objCertificadoEspecializacionExterno.err_existente := 1;                
                _objCertificadoEspecializacionExterno.err_codigo := 1;
                
                 RETURN NEXT _objCertificadoEspecializacionExterno;
                
			END;
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION seguimiento_capacitacion.spr_sel_funcionario_certificado_externo_especializacion(integer, character varying, integer)
  OWNER TO usr_academico;
COMMENT ON FUNCTION seguimiento_capacitacion.spr_sel_funcionario_certificado_externo_especializacion(integer, character varying, integer) IS '
---------------------------------------------------------------------------
Autor : Lic. Richard Pablo Quispe Huiza
Fecha : 05/07/2017
Descripción : Muestra las notas de un evento de especialidad

Modificacion: 30/08/2018 por Lic. Zenon Hugo Tola Mamani
Descripción: Se incorpora en ''bandera_reimpresion'' bandera para validar la impresion de Certificado de Programa

Modificacion: 05/12/2018 por Lic. Basilia Apaza
Descripción: se adicionó validacion para desplegar certificado cuando todos los eventos esten evaluados


Ejemplo de uso:
SELECT * 
FROM seguimiento_capacitacion.spr_sel_funcionario_certificado_externo_especializacion (
1, -- prodoc_codigo INTEGER
''20170601_EQMOJU'',	--	 perpre_codigo VARCHAR,
-1	--  per_codigo INTEGER
) 

Salida : Tipo de dato seguimiento_capacitacion.obj_certificacion_especializacion 
---------------------------------------------------------------------------';
