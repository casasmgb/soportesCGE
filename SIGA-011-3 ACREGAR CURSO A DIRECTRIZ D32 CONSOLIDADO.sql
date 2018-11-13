/*--------------------------------------------------------------------
 * 
 * AGREGAR CURSO A DIRECTRIZ CONSOLIDADO
 * SISTEMA:SIGA
 * USUARIO DB: USRACADEMICO
 * MOTOR BASE DE DATOS: POSTGRES
 * FECHA CREACION: 08/11/2018
 * POR: LIC. GABRIEL CASAS MAMANI.
 * EJECUCION:
 * SE COMENTA LOS SELECT QUE DEBEN EJECUTARSE  
 * 
 **/

-- Lista de cursos pertenecientes a la directriz D-32
select * from seguimiento_capacitacion.curso c where c.dir_codigo = 33

-- EJECUTAR Agregar el curso a la directriz conslidada
SELECT * FROM  seguimiento_capacitacion.spr_ins_curso_consolidado(
    'SISTEMA DE ADMINISTRACION DE BIENES Y SERVICIOS Y REGLAMENTACION ESPECIFICA',		--  cur_nombre varchar,
    15,	--  cur_carga_horaria numeric,
    1,	--  cur_creditos integer,
   	3,	--  costo_hora integer, 
    1,	--  moneco_codigo integer, 0 Bs.
    2,	--  nivres_codigo integer,   tecnico
    1,	--  tipcur_codigo integer,   introductorio
    33,	--  dir_codigo integer,
    '
    <table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    	<row>
      		<combas_codigo>3</combas_codigo>
    	</row>        
    </table>

    ',	--  xml_competencias xml
    '
    <table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">                
        <row>
            <comgen_codigo>-1</comgen_codigo>                
        </row>                                
	</table>
    ',	--  xml_competencias_genericas xml,
  '
	<table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">                
        <row>
        	<comesp_codigo>-1</comesp_codigo>                
        </row>      
	</table>    
  '	--xml_competencias_especificas xml
);

-- EJECUTAR Consolidar la directriz
SELECT * FROM seguimiento_capacitacion.spr_upd_consolidar_cursos_malla_des(
	33 -- dir_codigo INTEGER
)
