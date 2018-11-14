-- Function: seguimiento_capacitacion.spr_upd_redondeo_notas_evento(integer)

-- DROP FUNCTION seguimiento_capacitacion.spr_upd_redondeo_notas_evento(integer);

CREATE OR REPLACE FUNCTION seguimiento_capacitacion.spr_upd_redondeo_notas_evento(procur_codigo INTEGER)
  RETURNS void AS
$BODY$
	DECLARE 
		-- Definicion de variables locales
		_procur_codigo INTEGER;
		my_var INTEGER  ;
		
		_filas record;
		_nota_total NUMERIC (10, 2);
		_xml_nota XML;
		_raiz_documento VARCHAR (50);
		_etiquetas_documento VARCHAR[];
		_registro record;
		_xml_fila XML;
		_ran_codigo INTEGER;
		
	BEGIN
		--Asignación de variables locales
		_procur_codigo := PUBLIC.fn_valida_nulos(procur_codigo::VARCHAR, 1)::INTEGER;
		--setenado la variable
		my_var:= 0;
		
		_nota_total := 0;
		_raiz_documento := '/table/row/';
		_etiquetas_documento := ARRAY['doccrieva_codigo','doccrieva_descripcion', 'doccrieva_ponderacion', 'calificacion'];
		
		DROP TABLE IF EXISTS notas;
		
		CREATE TEMPORARY TABLE IF NOT EXISTS notas(
			doccrieva_codigo INTEGER,
			doccrieva_descripcion VARCHAR (250),
			doccrieva_ponderacion NUMERIC (10, 2),
			calificacion NUMERIC (10, 2)
		) ON COMMIT DELETE ROWS;
		
		FOR _filas IN (
			--
			SELECT *
			FROM   seguimiento_capacitacion.spr_sel_evaluacion_docente_personas_inscritas (
				-1,	-- _per_codigo INTEGER,
				'',	-- _perpre_codigo CHARACTER VARYING,
				'',	-- _perpre_codigo_preinscripcion CHARACTER VARYING,
				'',	-- criterio_busqueda CHARACTER VARYING,
				_procur_codigo,	-- _procur_codigo INTEGER,
				-1,	-- _asidoc_codigo INTEGER,
				1 -- _reporte INTEGER
			       ) t
			WHERE  t.evadocperins_nota_total <> trunc (t.evadocperins_nota_total)
		)
		LOOP
			_xml_fila := _filas.evadocperins_calificaciones;
			
			--- guardamos en la tabla
			FOR _registro IN (
				WITH x (col) AS (
					SELECT _xml_fila
				)
				SELECT 
				CASE 
					WHEN EXISTS (
						SELECT UNNEST (a.doccrieva_codigo)::VARCHAR
					     ) THEN UNNEST (a.doccrieva_codigo)::VARCHAR
					ELSE '-1'
				END  AS doccrieva_codigo,
				
				CASE 
					WHEN EXISTS (
						SELECT UNNEST (a.doccrieva_descripcion)::VARCHAR
					     ) THEN UNNEST (a.doccrieva_descripcion)::VARCHAR
					ELSE 'NULL'
				END  AS doccrieva_descripcion,
				CASE 
					WHEN EXISTS (
						SELECT UNNEST (a.doccrieva_ponderacion)::VARCHAR
					     ) THEN UNNEST (a.doccrieva_ponderacion)::VARCHAR
					ELSE '0'
				END  AS doccrieva_ponderacion,
				CASE 
					WHEN EXISTS (
						SELECT UNNEST (a.calificacion)::VARCHAR
					     ) THEN UNNEST (a.calificacion)::VARCHAR
					ELSE '0'
				END  AS calificacion 
				
				FROM (
					SELECT xpath(
						_raiz_documento || _etiquetas_documento[1] || '/text()',
						col
					       )  AS doccrieva_codigo,
					       xpath(
						_raiz_documento || _etiquetas_documento[2] || '/text()',
						col
					       )  AS doccrieva_descripcion,
					       xpath(
						_raiz_documento || _etiquetas_documento[3] || '/text()',
						col
					       )  AS doccrieva_ponderacion,
					       xpath(
						_raiz_documento || _etiquetas_documento[4] || '/text()',
						col
					       )  AS calificacion
					FROM   x
				) a
			)
			LOOP
				INSERT INTO notas
				VALUES
				  (
				    _registro.doccrieva_codigo::INTEGER,
				    _registro.doccrieva_descripcion::VARCHAR,
				    _registro.doccrieva_ponderacion::NUMERIC (10, 2),
				    _registro.calificacion::NUMERIC (10, 0)
				  );
			END LOOP;
			
			SELECT query_to_xml(
				'
	      select * from notas
	    
	      ',
				TRUE,
				FALSE,
				''
			       )
			INTO   _xml_nota;
			
			SELECT SUM (calificacion)
			INTO   _nota_total
			FROM   notas;
			
			my_var:= 0;
			UPDATE
				seguimiento_capacitacion.evaluacion_docente_personas_inscritas e
			SET
				evadocperins_nota_total = _nota_total,
				evadocperins_calificaciones = _xml_nota
			WHERE
				e.perpre_codigo = _filas.perpre_codigo;
			
			--obteniendo cuantas filas fueron afectadas
			GET DIAGNOSTICS my_var = ROW_COUNT;
			-- si no es lo esperado , hacer un rollback
			IF my_var != 1 	THEN  
				RAISE EXCEPTION transaction_rollback;
			END IF ; 
					
			SELECT r.ran_codigo
			INTO   _ran_codigo
			FROM   seguimiento_capacitacion.rangos r
			WHERE  r.ran_estado = 1
			       AND _nota_total BETWEEN r.ran_inicio AND
				   r.ran_fin;
			
			
			-----**************-----------------segundo update ------------------
            -- SIEMPRE Y CUANDO EXISTA Y ESTE APROBADO
            IF EXISTS (
            SELECT
                 R.perpre_codigo
            FROM seguimiento_capacitacion.certificacion_persona AS R
            WHERE R.perpre_codigo = _filas.perpre_codigo
            )  THEN

			--setenado la variable
			my_var:= 0;
			-- actualizamos la nota en los certificados
			UPDATE
				seguimiento_capacitacion.certificacion_persona d
			SET
				ran_codigo = _ran_codigo,
				cerper_nota_total = _nota_total
			WHERE
				d.perpre_codigo = _filas.perpre_codigo;
                
              if not found then
              RAISE NOTICE 'NO EXISTE EL REGISTRO O NO ACTUALIZA NADA POR SER IGUAL %',_filas.perpre_codigo;
              end if;  
			
			
			--obteniendo cuantas filas fueron afectadas
			GET DIAGNOSTICS my_var = ROW_COUNT;
			-- si no es lo esperado , hacer un rollback	
			IF my_var != 1 	THEN  
				RAISE EXCEPTION transaction_rollback;
			END IF ;
                        END IF;
            
			DELETE FROM notas;
		END LOOP;
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION seguimiento_capacitacion.spr_upd_redondeo_notas_evento(integer)
  OWNER TO usr_academico;
COMMENT ON FUNCTION seguimiento_capacitacion.spr_upd_redondeo_notas_evento(integer) IS '

---------------------------------------------------------------------------
Fecha creacion: 19/12/2017

Descripcion : Realiza la actualización de calificaciones registradas con decimales a numeros enteros.

* Soporte numero: 03689/2017
* Funcionario: CORDOVA CHAVEZ ALVARO EDGAR
* Descripción: "... Estimados. solicito el redondeo a números enteros de las calificaciones,
* asimismo la habilitación del certificado del sr. AMILCAR ARGOLLO LIMA con CI. 4935142 correspondiente al mismo evento..."  
 
* Evento: CE/LP-T10-393/2017
* Obtenemos procur_codigo con la siguiente consulta:
/*
SELECT *
FROM   seguimiento_capacitacion.programacion_curso_codificacion pcc
WHERE  pcc.procurcod_sigla = "CE/LP-T10-393/2017"
       
       --procur_codigo = 394
*/       
Ejemplo de uso : 
 SELECT *  FROM  seguimiento_capacitacion.spr_upd_redondeo_notas_evento(394)
)

---------------------------------------------------------------------------';