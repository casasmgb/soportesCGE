-- cambiar apellidoPaterno y apellidoMaterno
update usuarios set usu_paterno = 'GUERRA', usu_materno='VILLARROEL' where usu_cod=272
select * from usuarios as u where usu_cod=275

-- registrar un usuario apartir de un usuario existente cambiando su cargo
insert into usuarios 
select (select max(usu_cod)+1 from usuarios) , 6, u.usu_id, u.usu_pwd, u.usu_paterno, u.usu_materno, u.usu_nombres, u.usu_adm, u.usu_titulo, u.usu_vigente
from usuarios as u where usu_cod=266

select * from personas 