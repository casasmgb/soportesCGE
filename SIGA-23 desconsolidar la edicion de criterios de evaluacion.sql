-- CE/SC-A07-786/2018

select * from seguimiento_capacitacion.programacion_curso where procur_codigo = 1495
select * from seguimiento_capacitacion.docente_criterios_evaluacion where procur_codigo =1495  


-- EJECUTAR EL UPDATE

		UPDATE
             seguimiento_capacitacion.docente_criterios_evaluacion dce
        SET
             doccrieva_estado = 1
        WHERE dce.procur_codigo = 1495 AND
              dce.asidoc_codigo = 3 AND
              dce.doccrieva_estado = 2;