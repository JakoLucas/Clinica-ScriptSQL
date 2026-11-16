USE [CLINICAMEDICA_DB]
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_AgregarHorarioMedico]
    @IDMedico       SMALLINT,
    @IDClinica      SMALLINT,
    @DiaSemana      VARCHAR(10),
    @HorarioInicio  TIME(0) = NULL,
    @HorarioFin     TIME(0) = NULL,
    @DuracionMin    SMALLINT = NULL,

    @IDHorario      INT OUTPUT,
    @Mensaje        VARCHAR(4000) OUTPUT
AS
BEGIN
    
    SET @IDHorario = NULL;
    SET @Mensaje = NULL;

    DECLARE @EstadoMedico BIT;
    DECLARE @ExisteMedico BIT = 0;

    BEGIN TRY

        IF @IDMedico IS NULL OR @IDMedico <= 0
        BEGIN
            SET @Mensaje = 'El IDMedico debe ser mayor a cero.';
            RETURN -1;
        END

        IF @IDClinica IS NULL OR @IDClinica <= 0
        BEGIN
            SET @Mensaje = 'El IDClinica debe ser mayor a cero.';
            RETURN -3;
        END
	
	IF @DiaSemana IS NULL
	BEGIN
    		SET @Mensaje = 'El DiaSemana es obligatorio. Valores permitidos: Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo.';
    		RETURN -11;
	END

        IF @DiaSemana NOT IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')
        BEGIN
            SET @Mensaje = 'Día inválido: "' + @DiaSemana + '". Valores permitidos: Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo.';
            RETURN -11;
        END

        IF @HorarioInicio IS NULL OR @HorarioFin IS NULL
        BEGIN
            SET @Mensaje = 'HorarioInicio y HorarioFin son obligatorios.';
            RETURN -12;
        END

        IF @HorarioFin <= @HorarioInicio
        BEGIN
            SET @Mensaje = 'El HorarioFin debe ser mayor que el HorarioInicio.';
            RETURN -6;
        END

        IF @DuracionMin IS NULL OR @DuracionMin <= 0
        BEGIN
            SET @Mensaje = 'La DuracionMin es obligatoria y debe ser mayor a cero.';
            RETURN -7;
        END


        BEGIN TRANSACTION;
       
        SELECT
            @EstadoMedico = [Estado],
            @ExisteMedico = 1
        FROM [dbo].[Medicos] 
        WHERE [IDMedico] = @IDMedico;

        IF @ExisteMedico = 0
        BEGIN
            ROLLBACK TRANSACTION;

            SET @Mensaje = 'El médico con ID ' + CAST(@IDMedico AS VARCHAR(10)) + ' no existe.';

            RETURN -2;
        END

        IF ISNULL(@EstadoMedico, 0) <> 1
        BEGIN
            ROLLBACK TRANSACTION;

            SET @Mensaje = 'El médico con ID ' + CAST(@IDMedico AS VARCHAR(10)) + ' está inactivo; no se le pueden asignar horarios.';

            RETURN -10;
        END


        IF NOT EXISTS
        (
            SELECT 1
            FROM [dbo].[Clinicas] 
            WHERE [IDClinica] = @IDClinica
        )
        BEGIN
            ROLLBACK TRANSACTION;

            SET @Mensaje = 'La clínica con ID ' +
                CAST(@IDClinica AS VARCHAR(10)) + ' no existe.';

            RETURN -4;
        END


        
        IF EXISTS
        (
            SELECT 1
            FROM [dbo].[HorarioMedico] 
            WHERE [IDMedico] = @IDMedico
              AND [IDClinica] = @IDClinica
              AND [DiaSemana] = @DiaSemana
              AND [HorarioInicio] IS NOT NULL
              AND [HorarioFin] IS NOT NULL
              AND @HorarioInicio < [HorarioFin]
              AND @HorarioFin > [HorarioInicio]
        )
        BEGIN
            ROLLBACK TRANSACTION;

            SET @Mensaje =
                'Ya existe un horario que se solapa para ese médico en esa clínica y día.';

            RETURN -8;
        END


        
        INSERT INTO [dbo].[HorarioMedico]
        (
            [IDMedico],
            [IDClinica],
            [DiaSemana],
            [HorarioInicio],
            [HorarioFin],
            [DuracionMin]
        )
        VALUES
        (
            @IDMedico,
            @IDClinica,
            @DiaSemana,
            @HorarioInicio,
            @HorarioFin,
            @DuracionMin
        );

        
        SET @IDHorario = CONVERT(INT, SCOPE_IDENTITY());


      
        COMMIT TRANSACTION;

        SET @Mensaje = 'Horario médico agregado correctamente.';

        RETURN 0;

    END TRY

  BEGIN CATCH

    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END

    SET @IDHorario = NULL;

    SET @Mensaje =
        'Error al agregar horario médico: ' + ERROR_MESSAGE();

    RETURN -99;

END CATCH

END
GO
