USE [CLINICAMEDICA_DB]
GO

-- cambiar fecha y horario de un turno existente 
CREATE PROCEDURE dbo.SP_ReprogramarTurno
    @IDTurno BIGINT,
    @NuevaFecha DATE,
    @NuevoHorario TIME(7)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IDMedico SMALLINT;
    DECLARE @IDClinica SMALLINT;
    DECLARE @EstadoActual VARCHAR(20);

    -- Verifica existencia y estado del turno
    SELECT 
        @EstadoActual = EstadoTurno,
        @IDMedico = IDMedico,
        @IDClinica = IDClinica
    FROM dbo.Turnos
    WHERE IDTurno = @IDTurno;

    IF @EstadoActual IS NULL
    BEGIN
        RAISERROR('El turno indicado no existe.', 16, 1);
        RETURN;
    END

    IF @EstadoActual IN ('Atendido', 'Cancelado')
    BEGIN
        RAISERROR('No es posible reprogramar un turno con estado Atendido o Cancelado.', 16, 1);
        RETURN;
    END

    -- Verifica que el médico atienda en esa clínica
    IF NOT EXISTS (
        SELECT 1 
        FROM dbo.HorarioMedico 
        WHERE IDMedico = @IDMedico AND IDClinica = @IDClinica
    )
    BEGIN
        RAISERROR('El médico no registra atención en la clínica del turno.', 16, 1);
        RETURN;
    END

    -- Evita superposición con otros turnos del médico
    IF EXISTS (
        SELECT 1 
        FROM dbo.Turnos 
        WHERE IDMedico = @IDMedico 
          AND FechaTurno = @NuevaFecha 
          AND HoraTurno = @NuevoHorario 
          AND IDTurno <> @IDTurno 
          AND EstadoTurno <> 'Cancelado'
    )
    BEGIN
        RAISERROR('Superposición detectada: el médico ya tiene asignado un turno en esa fecha y horario.', 16, 1);
        RETURN;
    END

    -- Actualiza fecha y horario
    UPDATE dbo.Turnos
    SET FechaTurno = @NuevaFecha,
        HoraTurno = @NuevoHorario
    WHERE IDTurno = @IDTurno;

    -- Registra en auditoría
    INSERT INTO dbo.AuditoriaTurnos (IDTurno, EstadoAnterior, EstadoNuevo, FechaCambio)
    VALUES (@IDTurno, @EstadoActual, 'Reprogramado', CAST(GETDATE() AS DATE));

    PRINT 'Turno reprogramado exitosamente.';
END;
GO