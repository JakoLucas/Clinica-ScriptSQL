USE [CLINICAMEDICA_DB]
GO
-- agrega turno ingresando los datos del paciente en la clínica correspondiente
CREATE PROCEDURE dbo.sp_agregarTurno
    @Dni VARCHAR(20),
    @Apellido VARCHAR(60),
    @Nombre VARCHAR(60),
    @Mail VARCHAR(100),
    @Telefono VARCHAR(20),
    @FechaNacimiento DATE,
    @IDPlan INT,
    @IDClinica SMALLINT,
    @IDMedico SMALLINT,
    @IDUsuario BIGINT,
    @FechaTurno DATE,
    @HoraTurno TIME(7)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IDPaciente INT;
    DECLARE @PrecioCopago DECIMAL(8, 2);

    -- 1. Verificar existencia del paciente por DNI
    SELECT @IDPaciente = IDPaciente 
    FROM dbo.Pacientes 
    WHERE Dni = @Dni;

    -- Si no existe, registrar paciente y obtener nuevo ID
    IF @IDPaciente IS NULL
    BEGIN
        INSERT INTO dbo.Pacientes (Apellido, Nombre, Dni, Mail, Telefono, FechaNacimiento, IDPlan)
        VALUES (@Apellido, @Nombre, @Dni, @Mail, @Telefono, @FechaNacimiento, @IDPlan);
        
        SET @IDPaciente = SCOPE_IDENTITY();
    END

    -- 2. Consultar precio del plan para verificar si es con o sin copago
    SELECT @PrecioCopago = ISNULL(Precio, 0)
    FROM dbo.Planes
    WHERE IDPlan = @IDPlan;

    -- 3. Cargar el turno
    INSERT INTO dbo.Turnos (IDClinica, IDPaciente, IDMedico, IDUsuario, EstadoTurno, Copago, FechaTurno, HoraTurno)
    VALUES (@IDClinica, @IDPaciente, @IDMedico, @IDUsuario, 'Pendiente', @PrecioCopago, @FechaTurno, @HoraTurno);

    -- 4. Retornar confirmación e importe
    IF @PrecioCopago > 0
    BEGIN
        PRINT CONCAT('Turno registrado con éxito. El plan es con copago. Importe a pagar: $', @PrecioCopago);
    END
    ELSE
    BEGIN
        PRINT 'Turno registrado y confirmado sin copago.';
    END
END;
GO