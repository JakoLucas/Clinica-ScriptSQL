USE [CLINICAMEDICA_DB]
GO

--Muestra el detalle de los turnos asignados relacionando clínicas, médicos y pacientes con sus respectivos datos personales y matrícula

CREATE VIEW dbo.VW_Medicos_pacientes AS
SELECT 
    c.NombreClinica,
    m.Matricula AS matriculaMedica,
    e.NombreEspecialidad AS especialidad,
    CONCAT(m.Nombre, ' ', m.Apellido) AS medico,
    CONCAT(p.Nombre, ' ', p.Apellido) AS paciente,
    p.Dni AS DNIpaciente,
    t.FechaTurno AS fechaTurno
FROM dbo.Turnos t
INNER JOIN dbo.Clinicas c ON t.IDClinica = c.IDClinica
INNER JOIN dbo.Medicos m ON t.IDMedico = m.IDMedico
INNER JOIN dbo.Especialidades e ON m.IDEspecialidad = e.IDEspecialidad
INNER JOIN dbo.Pacientes p ON t.IDPaciente = p.IDPaciente;
GO