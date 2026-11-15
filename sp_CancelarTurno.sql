USE CLINICAMEDICA_DB
GO
CREATE PROCEDURE sp_CancelarTurno(
@idTurno int
)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION

		DECLARE @EstadoTurnoViejo varchar(20)
	
		SELECT @EstadoTurnoViejo = T.EstadoTurno FROM TURNOS T WHERE T.IdTurno = @idTurno

	IF @EstadoTurnoViejo IS NULL
	BEGIN
		RAISERROR('TURNO INGRESADO NO EXISTE.', 16, 1)	
	END

	IF @EstadoTurnoViejo = 'Pendiente' OR @EstadoTurnoViejo = 'Confirmado'
	BEGIN
		UPDATE Turnos SET EstadoTurno = 'Cancelado' WHERE IdTurno = @idTurno

		INSERT INTO AuditoriaTurnos(IDTurno, EstadoAnterior, EstadoNuevo, FechaCambio)
		VALUES(@idTurno, @EstadoTurnoViejo, 'Cancelado', GETDATE())
			
		COMMIT TRANSACTION
	END
ELSE
BEGIN
	RAISERROR('EL TURNO NO ESTA PENDIENTE O CONFIRMADO, NO SE PUEDE CANCELAR.', 16, 1)
END
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
END CATCH
END