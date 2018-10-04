
-- CE/CB-CS01-592/2018
select * from seguimiento_capacitacion.programacion_curso_codificacion where procurcod_sigla = 'CE/CB-CS01-592/2018' 
-- procur_codigo:  1300

select * from seguimiento_capacitacion.programacion_curso where procur_codigo = 1300

-- ampliar fecha de pre-incripcion
update seguimiento_capacitacion.programacion_curso 
set procur_fecha_inicio = '2018-08-17', procur_fecha_final = '2018-08-17'
where  procur_codigo = 1300



---  CE/SC-CS01-595/2018
-- select * from seguimiento_capacitacion.programacion_curso_codificacion where procurcod_sigla = 'CE/SC-CS01-595/2018' 
-- procur_codigo:  1303

-- select * from seguimiento_capacitacion.programacion_curso where procur_codigo = 1303
