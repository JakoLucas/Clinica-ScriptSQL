USE CLINICAMEDICA_DB
GO
CREATE TRIGGER TR_AuditoriaTurnos
ON Turnos 
AFTER UPDATE 
AS
BEGIN 
INSERT INTO AuditoriaTurnos (IDTurno,EstadoAnterior,EstadoNuevo,FechaCambio)
SELECT i.IDTurno, d.EstadoTurno, i.EstadoTurno, GETDATE()  FROM inserted i
INNER JOIN deleted d
ON i.IDTurno = d.IDTurno
WHERE d.EstadoTurno <> i.EstadoTurno
END
GO
