/*
	SOLICITUD POR CORREO
	DE: LIC. MARIA ESCALANTE
	AGREGAR CURSOS A DIRECTRIZ CONSOLIDADO
	SISTEMA:SIGA
	USUARIO DB: USR_ACADEMICO
	FECHA EJECUCION: 14/11/2018
	POR: LIC. GABRIEL CASAS MAMANI.
*/

-- Lista de cursos pertenecientes a la directriz D-33
SELECT * FROM seguimiento_capacitacion.directrices AS d WHERE d.dir_codigo=34
select * from seguimiento_capacitacion.curso where dir_codigo = 34


-- EJECUTAR Agregar el curso a la directriz conslidada
SELECT * FROM  seguimiento_capacitacion.spr_ins_curso_consolidado(
    'CONTRATACIÓN DE BINES Y SERVICIOS',		--  cur_nombre varchar,
    20,	--  cur_carga_horaria numeric,
    1,	--  cur_creditos integer,
   	1,	--  costo_hora integer,
    3,	--  moneco_codigo integer, 120 Bs.
    2,	--  nivres_codigo integer,   tecnico
    2,	--  tipcur_codigo integer,   general
    34,	--  dir_codigo integer,
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

-- EJECUTAR Agregar el curso a la directriz conslidada
SELECT * FROM  seguimiento_capacitacion.spr_ins_curso_consolidado(
    'MANEJO Y DISPOSICIÓN DE BIENES',		--  cur_nombre varchar,
    20,	--  cur_carga_horaria numeric,
    1,	--  cur_creditos integer,
   	1,	--  costo_hora integer, 
    3,	--  moneco_codigo integer, 120 Bs.
    2,	--  nivres_codigo integer,   tecnico
    2,	--  tipcur_codigo integer,   general
    34,	--  dir_codigo integer,
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
	34 -- dir_codigo INTEGER
);
