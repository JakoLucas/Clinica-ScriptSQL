USE [CLINICAMEDICA_DB]
GO

CREATE OR ALTER VIEW [dbo].[vw_ResumenTurnosDelDia]
AS
SELECT
    t.[FechaTurno],
    t.[HoraTurno],
    c.[NombreClinica],
    m.[Apellido]         AS [ApellidoMedico],
    m.[Nombre]           AS [NombreMedico],
    e.[NombreEspecialidad],
    p.[Apellido]         AS [ApellidoPaciente],
    p.[Nombre]           AS [NombrePaciente],
    p.[Dni]              AS [DniPaciente],
    p.[Telefono]         AS [TelefonoPaciente],
    os.[NombreObraSocial],
    pl.[TipoPlan],
    t.[EstadoTurno],
    t.[Copago],
    u.[NombreUsuario]                       AS [UsuarioRegistro],
    u.[Nombre] + ' ' + u.[Apellido]         AS [NombreCompletoUsuario],
    r.[NombreRol]                           AS [RolUsuario]
FROM
    [dbo].[Turnos]          AS t
    INNER JOIN [dbo].[Clinicas]       AS c  ON c.[IDClinica]      = t.[IDClinica]
    INNER JOIN [dbo].[Medicos]        AS m  ON m.[IDMedico]       = t.[IDMedico]
                                           AND m.[Estado]         = 1          -- solo activos
    INNER JOIN [dbo].[Especialidades] AS e  ON e.[IDEspecialidad] = m.[IDEspecialidad]
    INNER JOIN [dbo].[Pacientes]      AS p  ON p.[IDPaciente]     = t.[IDPaciente]
    INNER JOIN [dbo].[Planes]         AS pl ON pl.[IDPlan]        = p.[IDPlan]
    INNER JOIN [dbo].[ObraSociales]   AS os ON os.[IDObraSocial]  = pl.[IDObraSocial]
    INNER JOIN [dbo].[Usuarios]       AS u  ON u.[IDUsuario]      = t.[IDUsuario]
    INNER JOIN [dbo].[Roles]          AS r  ON r.[IDRol]          = u.[IDRol]
WHERE
    t.[FechaTurno] = CAST(GETDATE() AS DATE);
GO