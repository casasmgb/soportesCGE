use SSCRRHH
select * from PERSONAL
select * from PERSONAL_2017  ORDER BY REGISTRO
select * from Profesionales
select * from profesionales_backup

use BDPersonal_dev
SELECT * FROM persona where per_Paterno='CASAS' where CI='3367890'  
-- car_Codigo = 53
-- pro_Codigo = 59
-- uni_Codigo = 326
-- res_Codigo = 10
SELECT	per.per_Item, 
		per.per_Tarjeta, 
		per.per_Paterno, 
		per.per_Materno, 
		per.per_PrimerNombre, 
		per.per_SegundoNombre, 
		per.car_Codigo,
		per.pro_Codigo,
		per.uni_Codigo,
		per.res_Codigo,
		per.esc_Codigo
FROM persona per     
where CI='3367890'

select * from Cargo
select * from Profesion where pro_Codigo = 59
select * from Unidad where uni_Codigo = 326
select * from Residencia where res_Codigo = 10
select * from Escala where esc_Codigo = 26

