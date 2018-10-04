-- Solicitud de desvinculación de Factura N° 2813 del evento CE/LP-T186-378/2018 del participante 
-- MACHICADO CABRERA JAQUELINE MARCELA, que por error involuntario se consolido la factura incorrecta, 

SELECT * FROM seguimiento_capacitacion.facturas f WHERE f.fac_numero=2813

/*
Comunicacion interna: CENCAP/CI-420/2017
Fecha: 18/07/2017

Ref. DESASOCIAR FACTURAS


DE: Lic. Jorge Ocampo Claros

*/

-- NOTA REALIZAR CON EL USUARIO DBA_ADMIN

SELECT
     d.procur_codigo,
     d.procur_fecha_inicio,
     d.procur_fecha_final,
     d.procur_cantidad_dias,
     d.procur_plaza_maxima,
     pc.procurcod_sigla,
     d.cur_codigo,
     c.dir_codigo
FROM seguimiento_capacitacion.programacion_curso d
     INNER JOIN seguimiento_capacitacion.programacion_curso_codificacion pc ON pc.procur_codigo = d.procur_codigo
     inner join seguimiento_capacitacion.curso c
     on c.cur_codigo =  d.cur_codigo
WHERE  pc.procurcod_sigla  IN ( 'CE/LP-T186-378/2018' ) 

--procur_codigo = 1085

SELECT
     tab.procur_codigo,
     tab.procurcod_sigla,
     tab.cur_nombre,
     tab.procur_fecha_inicio,
     tab.procur_fecha_final,
     tab.perpre_codigo,
     tab.perpre_numero_docidentidad,
     tab.perpre_nombres || ' ' || tab.perpre_apellido_paterno || ' ' || tab.perpre_apellido_materno AS nombre_completo,
     tab.xml_facturas AS facturas
FROM seguimiento_capacitacion.spr_sel_pre_inscritos ( '', --perpre_codigo varchar,
     3, --  perpre_estado integer,
     '',     --  perpre_codigo_preinscripcion varchar
     - 1, -- dep_codigo_prog integer,
     1085, -- procur_codigo INTEGER
     - 1, --  cur_codigo integer,
     '1900-01-01',     --  fecha_inicio date,
     '1900-01-01',     --  fecha_fin date,
     '',     --  cadena_busqueda varchar
     - 1 --  tipo_publicacion integer
     ) AS tab
WHERE tab.perpre_numero_docidentidad IN ('445921');
SELECT * FROM seguimiento_capacitacion.personas p WHERE p.per_appaterno='MACHICADO' AND p.per_apmaterno='CABRERA'


--perpre_codigo   "20180702_LKCUDY"
-- CODIGO DE PREINSCRIPCION DEL FUNCIONARIO
SELECT
     *
FROM seguimiento_capacitacion.facturas_persona_inscripcion f
WHERE f.perpre_codigo  in ('20180702_LKCUDY')   
/*
*  perpre_codigo = '20180702_LKCUDY'
*  per_codigo = 23357
*  fac_codigo = 406318
*  facperins_codigo = 30845
*  
* */

-- BORRAMOS EN EL ESQUEMA SEGUIMIENTO_CAPACITACION
--1 BORRAMOS DE LA RELACION FACTURA PERSONA INSCRIPCION, ESTA TABLA ES UN SERIAL OJO 
-- SELECT * FROM seguimiento_capacitacion.facturas_persona_inscripcion f WHERE f.perpre_codigo IN ('20180702_LKCUDY' );
DELETE
FROM seguimiento_capacitacion.facturas_persona_inscripcion f
WHERE f.perpre_codigo IN ('20180702_LKCUDY' );

select * from seguimiento_capacitacion.facturas where fac_codigo =406318

-- 2 --actualizamos la factura utilizada, incrementando el fac_saldo_total de 0 a 120
--SELECT * FROM seguimiento_capacitacion.facturas f WHERE f.fac_numero=30587;

update seguimiento_capacitacion.facturas f
set
fac_saldo_total = 100 -- f.fac_total 
where f.fac_codigo in (406318);


 /*ESQUEMA ACCESO_EXTERNO*/
--3 borramos la cuenta del funcionario
-- SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo IN ( '20180702_LKCUDY' );
DELETE
FROM acceso_externo.cuenta_persona_inscripcion cpi
WHERE cpi.perpre_codigo IN ( '20180702_LKCUDY' );


/*ESQUEMA SEGUIMIENTO_CAPACITACION*/
--4 BORRAMOS LA INSCRIPCION DE LA PERSONA
-- SELECT * FROM seguimiento_capacitacion.personas_inscripcion pe WHERE pe.perpre_codigo IN ( '20180702_LKCUDY' );
DELETE
FROM seguimiento_capacitacion.personas_inscripcion pe
WHERE pe.perpre_codigo IN ( '20180702_LKCUDY' );


-- ACCESO EXTERNO
/*select pe.perpre_estado,* from acceso_externo.persona_preinscripcion pe 
WHERE pe.perpre_codigo IN   ('20180702_LKCUDY') and 
       pe.perpre_estado = 3;*/


UPDATE
     acceso_externo.persona_preinscripcion pe
SET
     perpre_estado = 2 --3
WHERE pe.perpre_codigo IN   ('20180702_LKCUDY') and 
      pe.perpre_estado = 3;
      
