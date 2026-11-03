USE [CLINICAMEDICA_DB]
GO
-- Muestra la cantidad de turnos pendientes con copago en cada clínica 
CREATE VIEW dbo.VW_Turnos_copagos AS
SELECT 
    c.IDClinica AS idclinica,
    c.NombreClinica AS nombreClinica,
    e.NombreEspecialidad AS especialidad,
    pl.TipoPlan AS plan_os,
    os.NombreObraSocial AS obrasocial,
    t.Copago AS precioCopago,
    COUNT(t.IDTurno) AS cantidadTurno
FROM dbo.Turnos t
INNER JOIN dbo.Clinicas c ON t.IDClinica = c.IDClinica
INNER JOIN dbo.Medicos m ON t.IDMedico = m.IDMedico
INNER JOIN dbo.Especialidades e ON m.IDEspecialidad = e.IDEspecialidad
INNER JOIN dbo.Pacientes p ON t.IDPaciente = p.IDPaciente
INNER JOIN dbo.Planes pl ON p.IDPlan = pl.IDPlan
INNER JOIN dbo.ObraSociales os ON pl.IDObraSocial = os.IDObraSocial
WHERE t.EstadoTurno = 'Pendiente' AND t.Copago > 0
GROUP BY c.IDClinica, c.NombreClinica, e.NombreEspecialidad, pl.TipoPlan, os.NombreObraSocial, t.Copago;
GO