/*******************************************
 * NUMERO DE SOPORTE: 07239/2018
 * FUNCIONARIO: NADIR LAZO VEGA
 * DESCRIPCION:
 *       AGREGAR A VICTOR QUIROGA GUERRERO PARA USUARIO SCCRRHH 
 * 
 * Autor: Lic. Gabriel Casas Mamani
 * Fecha: 12/11/2018
 * Base de datos: SSCRRHH
 * Verion Sql Server: Microsoft SQL Server  2000 - 8.00.2039
 * 
 *******************************************/
USE [SSCRRHH]
GO
		
	INSERT INTO [dbo].[Usr_Personas]
  (
    [CodCorrPer],
    [DocIde],
    [DocIdeExp],
    [Paterno],
    [Materno],
    [Conyuge],
    [Nombres],
    [Telefono],
    [Sexo],
    [FechNac],
    [CodNivIns],
    [CodProf],
    [Cargo],
    [CodSuTrabContrA],
    [AreaTrabajo],
    [Observaciones],
    [CodEntidad],
    [Direccion],
    [CodDepto],
    [Celular],
    [CorreoElectronico],
    [EstadoCivil],
    [CodNac],
    [LugarNacimiento],
    [UM_CodCorrPer],
    [UM_Fecha],
    [EsHistorico]
  )
VALUES
  (
    (select max(CodCorrPer) +1 from [dbo].[Usr_Personas]),
    '3458008',
    'LP',
    'QUIROGA',
    'GUERRERO',
    '',
    'VICTOR',
    '79555040',
    'M',
    '1971-11-17',
    4,
    17,
    'ENCARGADO',
    8,
    'GNRH',
    '',
    174,
    '',
    0,
    '79555040',
    'victor_quiroga@contraloria.gob.bo',
    'C',
    0,
    'LA PAZ',
    654,
    GETDATE(),
    'N'
  )
  GO
  