USE CLINICAMEDICA_DB
GO
CREATE VIEW vw_TurnosPendientes
AS SELECT 
	T.IDTurno,
	P.Nombre + ', ' + P.Apellido As Paciente,
	P.Dni,
	T.FechaTurno AS Fecha,
	T.HoraTurno As Hora,
	T.EstadoTurno,
	M.Nombre + ', ' + M.Apellido As Medico,
	E.NombreEspecialidad As Especialidad
FROM Turnos T
INNER JOIN Pacientes P
	ON T.IDPaciente = P.IDPaciente
INNER JOIN Medicos M
	ON T.IDMedico = M.IDMedico
INNER JOIN Especialidades E 
	ON M.IDEspecialidad = E.IDEspecialidad
WHERE T.EstadoTurno = 'Pendiente'