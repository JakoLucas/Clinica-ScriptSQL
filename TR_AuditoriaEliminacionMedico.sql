USE [CLINICAMEDICA_DB]
GO

CREATE TRIGGER dbo.TR_AuditoriaEliminacionMedico ON dbo.Medicos
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    RAISERROR('No está permitido borrar medicos físicamente de la base de datos. Realice una baja lógca.', 16, 1);
    ROLLBACK TRANSACTION;
END;
GO
