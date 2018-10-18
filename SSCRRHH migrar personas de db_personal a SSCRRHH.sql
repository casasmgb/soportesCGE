use SSCRRHH
select * from PERSONAL
select * from PERSONAL_2017  ORDER BY REGISTRO
select * from Profesionales
select * from profesionales_backup

use BDPersonal_dev
SELECT * FROM persona where per_Paterno='CASAS'  where CI='3367890'  
-- car_Codigo = 53
-- pro_Codigo = 59
-- uni_Codigo = 326
-- res_Codigo = 10

SELECT	per.per_Item, 
		per.per_Tarjeta, 
		per.per_DocIdentidad,
		per.per_Paterno, 
		per.per_Materno, 
		per.per_PrimerNombre + ' ' +per.per_SegundoNombre as per_nombres, 
		car.car_Descripcion,
		prof.pro_Descripcion,
		uni.uni_Descripcion,
		res.res_Descripcion,
		esc.esc_CodigoEscala,
		per.car_Codigo,
		per.pro_Codigo,
		0 as grupo,
		mov_fun.Aplicabilidad_MovilidadFuncional,
		per.per_FechaNacimiento,
		GETDATE() as export,
		per.per_Piso,
		per.per_Interno,
		'00:00' as CH,
		'00:00' as CH2,
		'B3' as G
into personal_2018_octubre
FROM BDPersonal_dev.dbo.Persona per 
INNER JOIN BDPersonal_dev.dbo.Cargo car on car.car_Codigo = per.car_Codigo
INNER JOIN BDPersonal_dev.dbo.Profesion prof on prof.pro_Codigo = per.pro_Codigo
INNER JOIN BDPersonal_dev.dbo.Unidad uni on uni.uni_Codigo = per.uni_Codigo
INNER JOIN BDPersonal_dev.dbo.Residencia res on res.res_Codigo = per.res_Codigo
INNER JOIN BDPersonal_dev.dbo.Escala esc on esc.esc_Codigo = per.esc_Codigo
INNER JOIN BDPersonal_dev.dbo.MovilidadFuncional mov_fun on mov_fun.per_Codigo = per.per_Codigo
where mov_fun.Vigente_MovilidadFuncional = 1 and per.per_Vigente = 1;

select * from dbo.personal_2018_octubre

EXEC sp_rename 'dbo.personal_2018_nuevo', 'personal_2018_octubre' 


select * from Cargo
select * from Profesion where pro_Codigo = 59
select * from Unidad where uni_Codigo = 321
select * from Residencia where res_Codigo = 10
select * from Escala where esc_Codigo = 30
select * from MovilidadFuncional where per_Codigo = 367 -- aplicabilidad_movilidad_funcional
select * from Grupo
select * from Planilla_Entidad