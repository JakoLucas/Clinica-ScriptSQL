USE CLINICAMEDICA_DB
GO
CREATE VIEW VW_HistorialMedico
AS
SELECT 
hm.IDHistorial,
hm.Diagnostico,
hm.Tratamiento,
tu.FechaTurno,
pa.Apellido AS Apellido_Paciente,
pa.Nombre AS Nombre_Paciente,
pa.Dni AS DNI_Paciente,
med.Apellido AS Apellido_Medico,
med.Nombre AS Nombre_Medico,
es.NombreEspecialidad AS Especialidad_Medica
FROM HistorialMedico hm
INNER JOIN Turnos tu 
ON hm.IDTurno = tu.IDTurno
INNER JOIN Pacientes pa 
ON tu.IDPaciente = pa.IDPaciente  
INNER JOIN Medicos med
ON tu.IDMedico = med.IDMedico
INNER JOIN Especialidades es
ON med.IDEspecialidad = es.IDEspecialidad
GO
