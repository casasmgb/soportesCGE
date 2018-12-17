/*
 * Usuario: USRACADEMICO
 * Base de datos: siga_soportes
 * */

-- Function: seguimiento_capacitacion.spr_sel_programacion_curso_reprobados(integer, integer)

-- DROP FUNCTION seguimiento_capacitacion.spr_sel_programacion_curso_reprobados(integer, integer);

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.spr_sel_programacion_curso_reprobados(IN persona_codigo integer, IN prodoc_codigo integer)
  RETURNS TABLE(codigo_persona integer, programaciones_evento xml, eventos_notas json, docentes_programacion xml, bandera integer, err_existente integer, err_mensaje character varying, err_codigo integer) AS
$BODY$
	DECLARE
		-- Definición de variables locales
	
        _prodoc_codigo INTEGER;		
        _per_codigo INTEGER;
        _bandera INTEGER:=0;
        _formato_inicial varchar(100);
        _formato_final varchar(100);
        _formato_intermedio_incial varchar(100);
        _formato_intermedio_final varchar(100);
        _programacion_evento_xml_por_defecto xml;
        _notas_xml_por_defecto json;
        _notas_xml json;         
        _docentes_especializacion_xml_por_defecto xml;        
	_programacion_xml XML;
	_procur_codigo INTEGER;
	_procur_codigo_reprobado INTEGER:=-1;	
	--Definicion de variables de excepcion
	_err_existente INTEGER;
	_err_Mensaje CHARACTER VARYING (1000);
	_err_codigo INTEGER;
	_err_mensaje_detallado varchar(80000);
        
        
	BEGIN
		-- Asignación de variables
   		_prodoc_codigo := PUBLIC.fn_valida_nulos(prodoc_codigo::CHARACTER VARYING, 1)::INTEGER;
   		--_procur_codigo := PUBLIC.fn_valida_nulos(procur_codigo::CHARACTER VARYING, 1)::INTEGER;
		_per_codigo := PUBLIC.fn_valida_nulos(persona_codigo::CHARACTER VARYING, 1)::INTEGER;
		
		_err_existente := 0;
		_err_Mensaje := '#SE ENCONTRO LA INFORMACION CON LOS PARAMETROS ENVIADOS';
		_err_codigo := 0;
                
        
        select query_to_xml('
        	select  		 
			 -1  AS procur_codigo,
			 ''NULL''::VARCHAR  AS procurcod_sigla,
			 ''1900-01-01''::TIMESTAMP  AS procur_fecha_inicio,
			 ''1900-01-01''::TIMESTAMP  AS procur_fecha_final,
			 0::numeric(10,2) AS procur_cantidad_dias,
			 0 AS procur_plaza_minima,
			 0 AS procur_plaza_maxima,
			 ''NULL''::VARCHAR AS tipmod_descripcion,
			 ''NULL''::VARCHAR AS cur_nombre ,
			 ''NULL''::VARCHAR AS nivres_descripcion ,
			 ''NULL''::VARCHAR AS tipcur_descripcion ,
			 0::numeric(10,2) AS cur_carga_horaria,
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
        INTO _notas_xml_por_defecto;
               
        select query_to_xml('
        	select -1 as procur_codigo,
            -1 as asidoc_codigo,
                     -1 as doc_codigo,
           ''NULL''::VARCHAR AS doc_nombre_completo,                      
           ''NULL''::VARCHAR AS docadi_apellido_casada,
         ''NULL''::VARCHAR AS pro_descripcion
                                 
        ',true, false,'') into _docentes_especializacion_xml_por_defecto;

		
	IF EXISTS (		
		SELECT cr.procur_codigo_reprobado
		     FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi
		     JOIN seguimiento_capacitacion.cursos_reprobados AS cr ON cr.procur_codigo=edpi.procur_codigo
		   WHERE edpi.per_codigo= _per_codigo AND cr.prodoc_codigo_reprobado=_prodoc_codigo
	)THEN
			
				
			 SELECT cr.procur_codigo_reprobado INTO _procur_codigo_reprobado 
			 FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi
			 JOIN seguimiento_capacitacion.cursos_reprobados AS cr ON cr.procur_codigo=edpi.procur_codigo
			 WHERE edpi.per_codigo= _per_codigo AND cr.prodoc_codigo_reprobado=_prodoc_codigo;
			
			SELECT query_to_xml('
				SELECT 
			   				
				 pc.procur_codigo  AS procur_codigo,
				 pcc.procurcod_sigla  AS procurcod_sigla,
				 pc.procur_fecha_inicio::timestamp  AS procur_fecha_inicio,
				 pc.procur_fecha_final::timestamp  AS procur_fecha_final,
				 pc.procur_cantidad_dias AS procur_cantidad_dias,
				 pc.procur_plaza_minima AS procur_plaza_minima,
				 pc.procur_plaza_maxima AS procur_plaza_maxima,
				 tm.tipmod_descripcion AS tipmod_descripcion,
				 c.cur_nombre AS cur_nombre ,
				 nr.nivres_descripcion AS nivres_descripcion ,
				 tc.tipcur_descripcion AS tipcur_descripcion ,
				 c.cur_carga_horaria AS cur_carga_horaria,
				 meh.monecohor_monto_total AS monto_total_curso
			     FROM seguimiento_capacitacion.programacion_curso_documento AS pcd
			     JOIN seguimiento_capacitacion.programacion_documento AS pd ON pcd.prodoc_codigo = pd.prodoc_codigo
			     JOIN seguimiento_capacitacion.programacion_curso AS pc ON pc.procur_codigo=pcd.procur_codigo
			     JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc ON pcc.procur_codigo=pc.procur_codigo
			     JOIN seguimiento_capacitacion.tipo_modalidad AS tm  on tm.tipmod_codigo=pc.tipmod_codigo
			     JOIN seguimiento_capacitacion.curso AS c ON c.cur_codigo=pc.cur_codigo
			     join seguimiento_capacitacion.nivel_responsabilidad nr ON nr.nivres_codigo=c.nivres_codigo
			     JOIN seguimiento_capacitacion.tipo_curso AS tc ON tc.tipcur_codigo=c.tipcur_codigo
			     JOIN seguimiento_capacitacion.monto_economico_hora meh ON meh.cur_codigo=c.cur_codigo
			     JOIN seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi ON edpi.procur_codigo=pc.procur_codigo  	                  
			     WHERE pd.prodoc_codigo='||_prodoc_codigo||' AND edpi.per_codigo='||_per_codigo||'			     
			     UNION 		     
			    SELECT 
			         pc.procur_codigo  AS procur_codigo,
				 pcc.procurcod_sigla  AS procurcod_sigla,
				 pc.procur_fecha_inicio::timestamp  AS procur_fecha_inicio,
				 pc.procur_fecha_final::timestamp  AS procur_fecha_final,
				 pc.procur_cantidad_dias AS procur_cantidad_dias,
				 pc.procur_plaza_minima AS procur_plaza_minima,
				 pc.procur_plaza_maxima AS procur_plaza_maxima,
				 tm.tipmod_descripcion AS tipmod_descripcion,
				 c.cur_nombre AS cur_nombre ,
				 nr.nivres_descripcion AS nivres_descripcion ,
				 tc.tipcur_descripcion AS tipcur_descripcion ,
				 c.cur_carga_horaria AS cur_carga_horaria,
				 meh.monecohor_monto_total AS monto_total_curso 
			     FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas AS edpi
			     JOIN seguimiento_capacitacion.cursos_reprobados AS cr ON cr.procur_codigo=edpi.procur_codigo			     
			      JOIN seguimiento_capacitacion.programacion_documento AS pd ON cr.prodoc_codigo = pd.prodoc_codigo		  		     
			     JOIN seguimiento_capacitacion.programacion_curso AS pc ON pc.procur_codigo=cr.procur_codigo
			     JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc ON pcc.procur_codigo=pc.procur_codigo
			     JOIN seguimiento_capacitacion.tipo_modalidad AS tm  on tm.tipmod_codigo=pc.tipmod_codigo
			     JOIN seguimiento_capacitacion.curso AS c ON c.cur_codigo=pc.cur_codigo
			     join seguimiento_capacitacion.nivel_responsabilidad nr ON nr.nivres_codigo=c.nivres_codigo
			     JOIN seguimiento_capacitacion.tipo_curso AS tc ON tc.tipcur_codigo=c.tipcur_codigo
			     JOIN seguimiento_capacitacion.monto_economico_hora meh ON meh.cur_codigo=c.cur_codigo			     
			     WHERE edpi.per_codigo='||_per_codigo||' AND cr.currepro_estado=1
			     ',true, false,'')::XML INTO _programacion_evento_xml_por_defecto;
			     
			   
			SELECT json_agg(json_build_object(
					'procur_codigo',procur_codigo,
					'cur_nombre',cur_nombre,
					'evadocperins_estado',evadocperins_estado,
					'evadocperins_nota_total',evadocperins_nota_total,
					'nota_certificado',nota_certificado,
					'perpre_codigo',perpre_codigo,
					'per_codigo',per_codigo,
					'nota_descripcion',nota_descripcion,
					'bandera_evaluacion_docente',bandera_evaluacion_docente
				)
			)									
			FROM(
				SELECT	
					edpi.procur_codigo,
					c.cur_nombre AS cur_nombre,
					edpi.evadocperins_estado,
					edpi.evadocperins_nota_total,
					COALESCE(cp.cerper_nota_total,0) as nota_certificado,                     
					edpi.perpre_codigo,
					edpi.per_codigo,                     
					case when edpi.evadocperins_nota_total >= bc.bascal_minima then 'APROBADO' 
					ELSE 'REPROBADO'   
					END AS nota_descripcion,                   
					case when eed.perpre_codigo is null then 0 else 1 end::integer bandera_evaluacion_docente               
				FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
				JOIN seguimiento_capacitacion.programacion_curso AS pc ON edpi.procur_codigo=pc.procur_codigo
				JOIN seguimiento_capacitacion.curso AS c ON c.cur_codigo=pc.cur_codigo
				JOIN seguimiento_capacitacion.programacion_curso_documento AS pcd ON pc.procur_codigo=pcd.procur_codigo
				JOIN seguimiento_capacitacion.programacion_curso_base_calificacion AS pcbc ON pc.procur_codigo=pcbc.procur_codigo
				JOIN  seguimiento_capacitacion.base_calificacion bc ON pcbc.bascal_codigo=bc.bascal_codigo
				left join seguimiento_capacitacion.certificacion_persona cp on cp.perpre_codigo = edpi.perpre_codigo and cp.per_codigo = edpi.per_codigo 
				left join seguimiento_capacitacion.evaluacion_evento_docente eed on eed.perpre_codigo = edpi.perpre_codigo and eed.per_codigo = edpi.per_codigo                   
				where edpi.evadocperins_estado in (1 ,2 )
				AND edpi.per_codigo=_per_codigo AND pcd.prodoc_codigo=_prodoc_codigo
				UNION 									
				SELECT	
					edpi.procur_codigo,
					c.cur_nombre AS cur_nombre,
					edpi.evadocperins_estado,
					edpi.evadocperins_nota_total,
					COALESCE(cp.cerper_nota_total,0) as nota_certificado,                     
					edpi.perpre_codigo,
					edpi.per_codigo,                     
					case when edpi.evadocperins_nota_total >= bc.bascal_minima then 'APROBADO'
						ELSE 'REPROBADO'   
					END AS nota_descripcion,                   
					case when eed.perpre_codigo is null then 0 else 1 end::integer bandera_evaluacion_docente               
				FROM seguimiento_capacitacion.evaluacion_docente_personas_inscritas edpi
				JOIN seguimiento_capacitacion.programacion_curso AS pc ON edpi.procur_codigo=pc.procur_codigo
				JOIN seguimiento_capacitacion.cursos_reprobados AS cr ON pc.procur_codigo=cr.procur_codigo
				JOIN seguimiento_capacitacion.curso AS c ON c.cur_codigo=pc.cur_codigo
				JOIN seguimiento_capacitacion.programacion_curso_documento AS pcd ON pc.procur_codigo=pcd.procur_codigo
				JOIN seguimiento_capacitacion.programacion_curso_base_calificacion AS pcbc ON pc.procur_codigo=pcbc.procur_codigo
				JOIN  seguimiento_capacitacion.base_calificacion bc ON pcbc.bascal_codigo=bc.bascal_codigo
				left join seguimiento_capacitacion.certificacion_persona cp on cp.perpre_codigo = edpi.perpre_codigo and cp.per_codigo = edpi.per_codigo 
				left join seguimiento_capacitacion.evaluacion_evento_docente eed on eed.perpre_codigo = edpi.perpre_codigo and eed.per_codigo = edpi.per_codigo                   
				where edpi.evadocperins_estado in (1 ,2 )
				AND edpi.per_codigo=_per_codigo AND cr.prodoc_codigo_reprobado=_prodoc_codigo
			    ) AS aux								   
			   INTO _notas_xml;
			     
		ELSE
			_bandera=1;		
		     
	END IF;		     
		
		RETURN QUERY
		 SELECT 
		     _per_codigo,
		     _programacion_evento_xml_por_defecto,
		     COALESCE(_notas_xml,_notas_xml_por_defecto),
		     _docentes_especializacion_xml_por_defecto,
		     _bandera,
		     0,
		     '':: CHARACTER VARYING,
		     0
		     ;

		
		IF NOT FOUND THEN
			_err_existente := 1;
			_err_Mensaje := '*NO SE ENCONTRO INFORMACION CON LOS PARAMEROS ENVIADOS.';
			_err_codigo := 1;
			raise exception transaction_rollback;
			
		END IF;
		
		EXCEPTION
			WHEN transaction_rollback THEN
			BEGIN
				GET STACKED DIAGNOSTICS _err_Codigo := RETURNED_SQLSTATE;
				RAISE NOTICE 'Error de validación : (%) ', _err_Mensaje;
				_err_Existente := 1;
				_err_Mensaje   := _err_Mensaje;
				RETURN QUERY
				   SELECT
				    - 1, --dep_codigo integer,                                   
				    _programacion_evento_xml_por_defecto, --programaciones_evento xml,
				    _notas_xml_por_defecto, --aulas_cursos_especializacion xml,
				    _docentes_especializacion_xml_por_defecto, --docentes_programacion xml,                                           
				    _bandera,
				    _err_existente, -- err_existente integer, 
				    _err_mensaje, -- err_mensaje character varying, 
				    _err_codigo; -- err_codigo integer
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
					SELECT 	
					- 1, --dep_codigo integer,                                   
				    _programacion_evento_xml_por_defecto, --programaciones_evento xml,
				    _notas_xml_por_defecto, --aulas_cursos_especializacion xml,
				    _docentes_especializacion_xml_por_defecto, --docentes_programacion xml,                                            
				    _bandera,
				    _err_existente, -- err_existente integer, 
				    _err_mensaje, -- err_mensaje character varying, 
				    _err_codigo; -- err_codigo integer
			END;
				 
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION seguimiento_capacitacion.spr_sel_programacion_curso_reprobados(integer, integer)
  OWNER TO usr_academico;
COMMENT ON FUNCTION seguimiento_capacitacion.spr_sel_programacion_curso_reprobados(integer, integer) IS '
---------------------------------------------------------------------------
Autor : Lic. Edson Calle , Lic. Basilia Apaza
Fecha : 05/07/2017
Descripción : Muestra las notas de un evento de especialidad

Autor:Lic. Lic. Basilia Apaza
Fecha :30/08/2018

Autor:Lic. Lic. Basilia Apaza
Fecha :05/12/2018

Autor:Lic. Gabriel Casas
Fecha :05/12/2018
Descripcion: Se agrego validacion con prodoc_codigo

Ejemplo de uso:

SELECT * FROM seguimiento_capacitacion.spr_sel_programacion_curso_reprobados(
  	598,-- per_codigo integer, 
  	14 -- prodoc_codigo INTEGER, 	
  );

---------------------------------------------------------------------------';
