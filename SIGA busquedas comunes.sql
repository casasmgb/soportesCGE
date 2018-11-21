--conocer la directriz de un curso
select d.*, pc.* from seguimiento_capacitacion.programacion_curso pc
inner join seguimiento_capacitacion.programacion_curso_codificacion pcc on pc.procur_codigo = pcc.procur_codigo
inner join seguimiento_capacitacion.curso c on c.cur_codigo = pc.cur_codigo
inner join seguimiento_capacitacion.directrices d on d.dir_codigo = c.dir_codigo
where pcc.procurcod_sigla = 'CE/SC-T13-787/2018'

--conocer usuario de participantes inscritos en un curso
select cueperins_cuenta, per.per_docidentidad, per.per_appaterno, per.per_apmaterno 
from seguimiento_capacitacion.programacion_curso pc
inner join seguimiento_capacitacion.programacion_curso_codificacion pcc on pc.procur_codigo = pcc.procur_codigo
inner join acceso_externo.persona_preinscripcion pp on pp.procur_codigo = pc.procur_codigo
inner join seguimiento_capacitacion.personas_inscripcion peri on peri.perpre_codigo = pp.perpre_codigo
inner join seguimiento_capacitacion.personas per on per.per_codigo = peri.per_codigo
inner join acceso_externo.cuenta_persona_inscripcion cpi on cpi.perpre_codigo = peri.perpre_codigo
where pcc.procurcod_sigla = 'UN/LP-T18-561/2017'

