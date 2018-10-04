select * from seguimiento_capacitacion.directrices where dir_descripcion = 'SEMINARIOS CONTROL SOCIAL Y RENDICION PUBLICA DE CUENTAS 2018'
SELECT * FROM seguimiento_capacitacion.directrices AS d WHERE d.dir_codigo=24
select * from seguimiento_capacitacion.curso where cur_codigo_sigla like '%D-23%'

-- CONTROL SOCIAL Y CONTROL GUBERNAMENTAL PARA LA PROMOCIÓN DE LA PARTICIPACIÓN CIUDADANA EN TEMAS AMBIENTALES

SELECT * FROM  seguimiento_capacitacion.spr_ins_curso_consolidado(
    'CONTROL SOCIAL Y CONTROL GUBERNAMENTAL PARA LA PROMOCIÓN DE LA PARTICIPACIÓN CIUDADANA EN TEMAS AMBIENTALES',		--  cur_nombre varchar,
    8,	--  cur_carga_horaria numeric,
    0,	--  cur_creditos integer,
   	3,	--  costo_hora integer, 
    1,	--  moneco_codigo integer, 0 Bs.
    4,	--  nivres_codigo integer,   control social
    1,	--  tipcur_codigo integer,   introductorio
    24,	--  dir_codigo integer,
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

SELECT * FROM seguimiento_capacitacion.spr_upd_consolidar_cursos_malla_des(
	24 -- dir_codigo INTEGER
)
