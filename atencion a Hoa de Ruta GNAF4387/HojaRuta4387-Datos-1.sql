/*
 * cambiar ci de 2394260-LP  a  2394260
 * en el curso:  CE/LP-T376-817/2018
 * datos:   Hugo Gonzalo Urquidi Cardenas
 * 
 * Base de datos: siga_soportes
 */

/*
	--Buscar sus datos
select	p.perpre_codigo, pcc.procur_codigo, *		
FROM acceso_externo.persona_preinscripcion p
INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion AS pcc 
ON p.procur_codigo = pcc.procur_codigo 
WHERE pcc.procurcod_sigla = 'CE/LP-T273-504/2018' 
AND p.perpre_numero_docidentidad = '6062848'
*/

DO $$
DECLARE 
my_var INTEGER;
_data_historico json;
_new_pass CHARACTER VARYING(50);
_old_ci  CHARACTER VARYING(10);
_new_ci  CHARACTER VARYING(10);
_perpre_codigo CHARACTER VARYING(20);
_procur_codigo INTEGER;
_comentario CHARACTER VARYING(200);
_funcionario CHARACTER VARYING(50);
_tabla CHARACTER VARYING(150);
_paterno CHARACTER VARYING(50);
_materno CHARACTER VARYING(50);
_per_codigopersona CHARACTER VARYING(20);

begin
	
	_old_ci:= '6062848';
	_new_ci:= '6062848';
	_paterno:='VARGAS';
	_materno:='QUISBERT';
	_per_codigopersona:='VQL6062848';
	_perpre_codigo:='20180822_EQFGHY';
	_procur_codigo:=1211;
	_funcionario:='Gabriel Casas';
	
	--1.-	CE/LP-T273-504/2018
	--		6062848
	SELECT row_to_json (row1) INTO _data_historico
	FROM (
	    SELECT * FROM acceso_externo.persona_preinscripcion pp WHERE pp.perpre_numero_docidentidad = '6062848' and  pp.perpre_codigo = '20180822_EQFGHY'
	) row1;
	
	INSERT INTO acceso_externo.historico_participantes
	(traza, fecha_ejecucion, funcionario_sgsir_responsable, comentario_accion_realizada)
	VALUES(_data_historico, now(), 'Gabriel Casas M.', 'actualizar nombre');
	 
	UPDATE acceso_externo.persona_preinscripcion
   	SET
		perpre_nombres = 'LORENA PACESA' --LORENAPACESA
	WHERE perpre_numero_docidentidad = '6062848' 
	and  perpre_codigo = '20180822_EQFGHY';
	GET DIAGNOSTICS my_var = ROW_COUNT;	
	RAISE NOTICE '1 Ok : % ', my_var;
	IF my_var != 1 THEN  
		RAISE EXCEPTION transaction_rollback;
	END IF; 

END
$$;

-- select * from acceso_externo.historico_participantes
