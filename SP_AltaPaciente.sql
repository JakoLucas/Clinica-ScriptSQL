USE CLINICAMEDICA_DB
GO
CREATE PROCEDURE SP_AltaPaciente
(@Apellido VARCHAR(60),
@Nombre VARCHAR(60),
@Dni VARCHAR(20),
@Mail VARCHAR(100),
@Telefono VARCHAR(20),
@FechaNacimiento DATE,
@IDPlan INT)
AS
BEGIN
DECLARE @DniExistente VARCHAR(20)
SELECT @DniExistente = Dni
FROM Pacientes
WHERE Dni = @Dni
IF @DniExistente = @Dni
BEGIN
    RAISERROR ('EL PACIENTE YA SE ENCUENTRA REGISTRADO', 16, 1)
END
ELSE
BEGIN
INSERT INTO Pacientes
    (Apellido, Nombre, Dni, Mail, Telefono, FechaNacimiento, IDPlan)
VALUES
    (@Apellido, @Nombre, @Dni, @Mail, @Telefono, @FechaNacimiento, @IDPlan)
END
END 
GO
