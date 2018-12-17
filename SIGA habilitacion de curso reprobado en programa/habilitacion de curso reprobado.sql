--Claudia Verónica Luna Teran con el numero de CI 4803358, quien habiendo reprobado el curso CE/LP-T178-368/2018
--del Programa de Especialización en Auditoria Especial, posteriormente retomando el mismo módulo en el evento N° CE/LP-T265-495/2018


--curso antiguo
SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc  WHERE pcc.procurcod_sigla='CE/LP-T178-368/2018' --procur_codigo 1075
SELECT * FROM seguimiento_capacitacion.programacion_curso_documento AS pcd WHERE pcd.procur_codigo=1075 --prodoc_codigo 3
--curso nuevo
SELECT * FROM seguimiento_capacitacion.programacion_curso_codificacion AS pcc  WHERE pcc.procurcod_sigla='CE/LP-T265-495/2018' --procur_codigo 1203
SELECT * FROM seguimiento_capacitacion.programacion_curso_documento AS pcd WHERE pcd.procur_codigo=1203 --prodoc_codigo 17
-- verificar habilitacion de curso
select * from seguimiento_capacitacion.cursos_reprobados ORDER BY 1 desc
--HABILITAR CURSO
INSERT INTO seguimiento_capacitacion.cursos_reprobados ("currepro_codigo","currepro_estado","currepro_fecha_registro","currepro_usuario_base_datos","procur_codigo_reprobado", 
	"prodoc_codigo_reprobado","procur_codigo","prodoc_codigo")
VALUES (15, 1,current_timestamp,session_user, 1075, 11,1203,13);