/*******************************************
 * NUMERO DE SOPORTE: 06625/2018
 * FUNCIONARIO: PACARI CONTRERAS LUIS
 * DESCRIPCION:
 *       CORRECCION DE LA DESCRIPCION EN EL FORMULARIO F-1201-A OTROS GASTOS, DE 'NO ESPECIFICADO' A 'GASTOS VARIOS'
 * FORMULARIO: F-1201-A
 * NRO. ASIGNACION: 0767/2018
 * 
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 19/09/2018
 * Base de datos: [BDPasajesViaticos_beta]
 * Verion Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 *******************************************/
USE [BDPasajesViaticos_beta]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- VERIFICANDO DATOS
select * from dbo.SPV_F632 where strNombreApellido = 'POMA QUISPE SEVERO' and strNumeroAsignacion = '0757/2018'
select * from dbo.SPV_F632Otros where bntCodAsignacion = 5581

-- PARA EJECUTAR
UPDATE dbo.SPV_F632Otros
SET    txtDescripcion = 'GASTOS VARIOS', -- NO ESPECIFICADO
sntTipo = 3 --0
WHERE  bntOtros = 1865