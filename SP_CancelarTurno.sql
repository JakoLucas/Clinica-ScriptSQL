USE [CLINICAMEDICA_DB]
GO
 -- Permite cancelar turnos

CREATE PROCEDURE dbo.Sp_CancelarTurno
    @IDTurno BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EstadoActual VARCHAR(20);

    -- Verifica existencia del turno
    SELECT @EstadoActual = EstadoTurno 
    FROM dbo.Turnos 
    WHERE IDTurno = @IDTurno;

    IF @EstadoActual IS NULL
    BEGIN
        RAISERROR('El turno especificado no existe.', 16, 1);
        RETURN;
    END

    -- Comprueba estado previo
    IF @EstadoActual IN ('Atendido', 'Cancelado')
    BEGIN
        RAISERROR('El turno no puede cancelarse porque se encuentra realizado (Atendido) o previamente Cancelado.', 16, 1);
        RETURN;
    END

    -- Cambia estado a cancelado
    UPDATE dbo.Turnos
    SET EstadoTurno = 'Cancelado'
    WHERE IDTurno = @IDTurno;

    -- Registra en tabla de auditoría
    INSERT INTO dbo.AuditoriaTurnos (IDTurno, EstadoAnterior, EstadoNuevo, FechaCambio)
    VALUES (@IDTurno, @EstadoActual, 'Cancelado', CAST(GETDATE() AS DATE));

    PRINT 'El turno fue cancelado y registrado en la auditoría correctamente.';
END;
GO