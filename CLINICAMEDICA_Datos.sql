USE CLINICAMEDICA_DB
GO

SET DATEFORMAT YMD
GO
-- Primero cargamos las entidades que no dependen de otras tablas.
-- Esto permite generar los registros para luego utilizar sus IDs como claves foráneas en las tablas relacionadas.

-- PROVINCIAS
INSERT INTO Provincias (NombreProvincia) 
VALUES
('Buenos Aires'),
('CABA'), 
('Córdoba'), 
('Santa Fe'), 
('Mendoza'), 
('Entre Ríos'), 
('Tucumán')

-- ESPECIALIDADES
INSERT INTO Especialidades (NombreEspecialidad)
VALUES
    ('Clínica Médica'),
    ('Cardiología'),
    ('Traumatología'),
    ('Oftalmología'),
    ('Gastroenterología'),
    ('Neumonología'),
    ('Endocrinología');

-- OBRAS SOCIALES
INSERT INTO ObrasSociales (NombreObraSocial)
VALUES
    ('OSPEY'),
    ('OSDE'),
    ('Swiss Medical'),
    ('Medifé'),
    ('Galeno');

-- PLANES
-- [Comentario Gabriela] PENDIENTE: evaluar agregar más de un plan por Obra Social
-- para contar con mayor variedad de datos en las consultas, cargué uno como ejemplo.

INSERT INTO Planes (TipoPlan, IdObraSocial, Precio)
VALUES
    ('Plan Básico', 1, 10000),
    ('Plan Intermedio', 2, 15000),
    ('Plan Premium', 3, 20000),
    ('Plan Especial', 4, 25000),
    ('Plan Gold', 5, 30000);

--ROLES
INSERT INTO Roles (NombreRol)
VALUES
    ('Administrador'),
    ('Médico'),
    ('Enfermero'),
    ('Recepcionista');

--LOCALIDADES
INSERT INTO Localidades (IDProvincia, NombreLocalidad, CodigoPostal)
VALUES
    (1, 'La Plata', '1900'),
    (1, 'Mar del Plata', '7600'),
    (2, 'CABA', '1000'),
    (3, 'Córdoba', '5000'),
    (4, 'Rosario', '2000'),
    (5, 'Mendoza', '5500'),
    (6, 'Paraná', '3100'),
    (7, 'San Miguel de Tucumán', '4000');

--USUARIOS
INSERT INTO Usuarios (IDRol, NombreUsuario, Email, Password, Nombre, Apellido)
VALUES
    (1, 'admin', 'admin@clinicamedica.com', 'admin123', 'Maria', 'Gonzalez'),
    (2, 'medico1', 'medico1@clinicamedica.com', 'medico123', 'Juan', 'Perez'),
    (3, 'enfermero1', 'enfermero1@clinicamedica.com', 'enfermero123', 'Elena', 'Lopez'),
    (4, 'recepcionista1', 'recepcionista1@clinicamedica.com', 'recepcionista123', 'Laura', 'Garcia'),
    (2, 'medico2', 'medico2@clinicamedica.com', 'medico223', 'Pedro', 'Martinez'),
    (3, 'enfermero2', 'enfermero2@clinicamedica.com', 'enfermero223', 'Pablo', 'Fernandez'),
    (4, 'recepcionista2', 'recepcionista2@clinicamedica.com', 'recepcionista223', 'Rosa', 'Sanchez'),
    (2, 'medico3', 'medico3@clinicamedica.com', 'medico323', 'Tomas', 'Gomez'),
    (3, 'enfermero3', 'enfermero3@clinicamedica.com', 'enfermero323', 'Ana', 'Rodriguez'),
    (4, 'recepcionista3', 'recepcionista3@clinicamedica.com', 'recepcionista323', 'Ricardo', 'Diaz'),
    (2, 'medico4', 'medico4@clinicamedica.com', 'medico423', 'Paula', 'Alvarez'),
    (3, 'enfermero4', 'enfermero4@clinicamedica.com', 'enfermero423', 'Carlos', 'Torres'),
    (4, 'recepcionista4', 'recepcionista4@clinicamedica.com', 'recepcionista423', 'Roberto', 'Vega'),
    (2, 'medico5', 'medico5@clinicamedica.com', 'medico523', 'Jorge', 'Ramirez'),
    (3, 'enfermero5', 'enfermero5@clinicamedica.com', 'enfermero523', 'Sofia', 'Castro');
    
--PACIENTES
INSERT INTO Pacientes (Apellido, Nombre, Dni, Mail, Telefono, FechaNacimiento, IDPlan)
VALUES
    ('Gomez', 'Lucia', '12345678', 'lucia.gomez@email.com', '123456789', '1985-06-15', 1),
    ('Fernandez', 'Martin', '23456789', 'martin.fernandez@email.com', '987654321', '1990-03-20', 2),
    ('Rodriguez', 'Sofia', '34567890', 'sofia.rodriguez@email.com', '555555555', '1988-12-10', 3),
    ('Lopez', 'Diego', '45678901', 'diego.lopez@email.com', '111111111', '1992-08-25', 4),
    ('Martinez', 'Valentina', '56789012', 'valentina.martinez@email.com', '222222222', '1995-01-30', 5),
    ('Perez', 'Nicolas', '67890123', 'nicolas.perez@email.com', '333333333', '1998-05-15', 1),
    ('Gonzalez', 'Camila', '78901234', 'camila.gonzalez@email.com', '444444444', '1996-09-10', 2),
    ('Sanchez', 'Matias', '89012345', 'matias.sanchez@email.com', '555555555', '1994-11-20', 3),
    ('Diaz', 'Isabella', '90123456', 'isabella.diaz@email.com', '666666666', '1997-04-15', 4),
    ('Torres', 'Lucas', '01234567', 'lucas.torres@email.com', '777777777', '1993-07-10', 5),
    ('Ramirez', 'Valeria', '11234567', 'valeria.ramirez@email.com', '888888888', '1990-11-25', 1),
    ('Castro', 'Santiago', '21234567', 'santiago.castro@email.com', '999999999', '1992-02-20', 2),
    ('Vega', 'Camilo', '31234567', 'camilo.vega@email.com', '000000000', '1994-05-15', 3),
    ('Alvarez', 'Julieta', '41234567', 'julieta.alvarez@email.com', '111111111', '1990-09-10', 4),
    ('Ramirez', 'Emilia', '51234567', 'emilia.ramirez@email.com', '222222222', '1995-01-30', 5),
    ('Torres', 'Mateo', '61234567', 'mateo.torres@email.com', '333333333', '1992-11-15', 1),
    ('Acosta', 'Valentina', '71234567', 'valentina.acosta@email.com', '444444444', '1990-06-15', 2),
    ('Rojas', 'Santiago', '81234567', 'santiago.rojas@email.com', '555555555', '1994-08-20', 3),
    ('Molina', 'Isabella', '91234567', 'isabella.molina@email.com', '666666666', '1997-04-15', 4),
    ('Herrera', 'Lucas', '01234568', 'lucas.herrera@email.com', '777777777', '1993-07-10', 5),
    ('Gimenez', 'Valeria', '11234568', 'valeria.gimenez@email.com', '888888888', '1990-11-25', 1);

--MEDICOS
INSERT INTO Medicos (IDEspecialidad, Nombre, Apellido, Matricula, Email, Telefono, FechaAlta, Estado)
VALUES
    (1, 'Juan', 'Perez', '12345', 'juan.perez@email.com', '111111111', '2020-01-01', 1),
    (2, 'Maria', 'Gomez', '23456', 'maria.gomez@email.com', '222222222', '2020-01-01', 1),
    (3, 'Carlos', 'Lopez', '34567', 'carlos.lopez@email.com', '333333333', '2020-01-01', 1),
    (4, 'Laura', 'Martinez', '45678', 'laura.martinez@email.com', '444444444', '2020-01-01', 1),
    (5, 'Diego', 'Rodriguez', '56789', 'diego.rodriguez@email.com', '555555555', '2020-01-01', 1),
    (6, 'Ana', 'Fernandez', '67890', 'ana.fernandez@email.com', '666666666', '2020-01-01', 1),
    (2, 'Pedro', 'Sanchez', '78901', 'pedro.sanchez@email.com', '777777777', '2020-01-01', 1),
    (3, 'Lucia', 'Diaz', '89012', 'lucia.diaz@email.com', '888888888', '2020-01-01', 1),
    (6, 'Jorge', 'Torres', '90123', 'jorge.torres@email.com', '999999999', '2020-01-01', 1),
    (5, 'Sofia', 'Ramirez', '01234', 'sofia.ramirez@email.com', '000000000', '2020-01-01', 1),
    (1, 'Tomas', 'Castro', '12346', 'tomas.castro@email.com', '111111111', '2020-01-01', 1),
    (2, 'Andrea', 'Vergara', '23457', 'andrea.vergara@email.com', '222222222', '2020-01-01', 1),
    (3, 'Martin', 'Acosta', '34568', 'martin.acosta@email.com', '333333333', '2020-01-01', 1),
    (6, 'Carla', 'Rojas', '45679', 'carla.rojas@email.com', '444444444', '2020-01-01', 1),
    (5, 'Federico', 'Molina', '56780', 'federico.molina@email.com', '555555555', '2020-01-01', 1),
    (1, 'Julieta', 'Herrera', '67891', 'julieta.herrera@email.com', '666666666', '2020-01-01', 1),
    (7, 'Emiliano', 'Gimenez', '78902', 'emiliano.gimenez@email.com', '777777777', '2020-01-01', 1),
    (3, 'Valentin', 'Orellana', '89013', 'valentin.orellana@email.com', '888888888', '2020-01-01', 1),
    (4, 'Camila', 'Vega', '90124', 'camila.vega@email.com', '999999999', '2020-01-01', 0),
    (5, 'Agustin', 'Alvarez', '01235', 'agustin.alvarez@email.com', '000000000', '2020-01-01', 1),
    (1, 'Luciano', 'Mena', '12347', 'luciano.mena@email.com', '111111111', '2020-01-01', 1),
    (2, 'Mariana', 'Cabrera', '23458', 'mariana.cabrera@email.com', '222222222', '2020-01-01', 1),
    (7, 'Nicolas', 'Ramos', '34569', 'nicolas.ramos@email.com', '333333333', '2020-01-01', 0),
    (4, 'Florencia', 'Sosa', '45670', 'florencia.sosa@email.com', '444444444', '2020-01-01', 0),
    (5, 'Gonzalo', 'Mendez', '56781', 'gonzalo.mendez@email.com', '555555555', '2020-01-01', 1),
    (1, 'Jorge', 'Pidal', '67892', 'jorge.pidal@email.com', '666666666', '2020-01-01', 1),
    (2, 'Ramon', 'Carreras', '78903', 'ramon.carreras@email.com', '777777777', '2020-01-01', 1),
    (3, 'Julian', 'Rolon', '89014', 'julian.rolon@email.com', '888888888', '2020-01-01', 0);

--CLINICAS
INSERT INTO Clinicas (NombreClinica, IDLocalidad, Direccion, Telefono, EmailClinica)
VALUES
    ('Clínica Central', 6, 'Calle Principal 123', '123456789', 'clinica.central@email.com'),
    ('Clínica del Sol', 2, 'Avenida del Sol 456', '987654321', 'clinica.del.sol@email.com'),
    ('Clínica Santa Fe',4, 'Calle Santa Fe 789', '555555555', 'clinica.santa.fe@email.com'),
    ('Clínica Mendoza', 5, 'Avenida Mendoza 101', '111111111', 'clinica.mendoza@email.com'),
    ('Clínica Córdoba', 3, 'Calle Córdoba 202', '222222222', 'clinica.cordoba@email.com'),
    ('Clínica Rosario', 4, 'Avenida Rosario 303', '333333333', 'clinica.rosario@email.com'),
    ('Clínica Tucumán', 7, 'Calle Tucumán 404', '444444444', 'clinica.tucuman@email.com'),
    ('Clínica La Plata', 1, 'Avenida La Plata 505', '555555555', 'clinica.la.plata@email.com');

--HORARIO MEDICO
-- [Comentario Gabriela] REVISAR:
-- La tabla HorarioMedico define DiaTurno como DATE y
-- HorarioInicio/HorarioFin como DATETIME.
-- Confirmar si queremos registrar fechas y horarios concretos
-- o días habituales de atención. Entiendo que son horarios concretos de turno.
-- Revisar también el criterio utilizado en DuracionMin si es siempre el mismo o varia según turno o medico, por ejemplo.

INSERT INTO HorarioMedico (IDMedico, IDClinica, DiaTurno, HorarioInicio, HorarioFin, DuracionMin)
VALUES

    (1, 1, '2026-10-05', '2026-10-05 08:00', '2026-10-05 12:00', 30),
    (2, 2, '2026-10-08', '2026-10-08 14:00', '2026-10-08 18:00', 30),
    (3, 3, '2026-10-14', '2026-10-14 09:00', '2026-10-14 13:00', 30),
    (4, 4, '2026-10-20', '2026-10-20 08:00', '2026-10-20 12:00', 30),
    (5, 5, '2026-10-27', '2026-10-27 15:00', '2026-10-27 19:00', 30),
    (1, 1, '2026-11-02', '2026-11-02 08:00', '2026-11-02 12:00', 30),
    (6, 6, '2026-11-05', '2026-11-05 10:00', '2026-11-05 14:00', 30),
    (7, 7, '2026-11-10', '2026-11-10 14:00', '2026-11-10 18:00', 30),
    (8, 8, '2026-11-16', '2026-11-16 08:30', '2026-11-16 12:30', 30),
    (2, 2, '2026-11-25', '2026-11-25 14:00', '2026-11-25 18:00', 30),
    (3, 3, '2026-12-02', '2026-12-02 09:00', '2026-12-02 13:00', 30),
    (4, 4, '2026-12-07', '2026-12-07 08:00', '2026-12-07 12:00', 30),
    (5, 5, '2026-12-11', '2026-12-11 15:00', '2026-12-11 19:00', 30),
    (6, 6, '2026-12-16', '2026-12-16 10:00', '2026-12-16 14:00', 30),
    (7, 7, '2026-12-21', '2026-12-21 14:00', '2026-12-21 18:00', 30),
    (3, 3, '2026-10-12', '2026-10-12 09:00', '2026-10-12 13:00', 30),
    (1, 1, '2026-09-01', '2026-09-01 08:00', '2026-09-01 12:00', 30),
    (6, 6, '2026-09-03', '2026-09-03 10:00', '2026-09-03 14:00', 30),
    (7, 7, '2026-09-08', '2026-09-08 14:00', '2026-09-08 18:00', 30),
    (8, 8, '2026-09-10', '2026-09-10 08:30', '2026-09-10 12:30', 30),
    (2, 2, '2026-09-15', '2026-09-15 14:00', '2026-09-15 18:00', 30),
    (3, 3, '2026-09-17', '2026-09-17 09:00', '2026-09-17 13:00', 30),
    (4, 4, '2026-09-22', '2026-09-22 08:00', '2026-09-22 12:00', 30),
    (5, 5, '2026-09-24', '2026-09-24 15:00', '2026-09-24 19:00', 30),
    (6, 6, '2026-09-29', '2026-09-29 10:00', '2026-09-29 14:00', 30),
    (7, 7, '2026-10-01', '2026-10-01 14:00', '2026-10-01 18:00', 30);

-- TURNOS
-- [Comentario Gabriela] Criterio utilizado:
-- Para fechas pasadas se asignaron los estados "Atendido" o "Cancelado".
-- Para fechas futuras se asignaron los estados "Confirmado" o "Pendiente".

INSERT INTO Turnos (IDClinica, IDPaciente, IDMedico, IDUsuario, EstadoTurno, Copago, FechaTurno, HoraTurno)
VALUES
    (1, 1, 1, 4, 'Atendido', 500, '2026-10-05', '08:00'),
    (2, 2, 2, 4, 'Atendido', 700, '2026-10-08', '14:00'),
    (3, 3, 3, 4, 'Cancelado', 0, '2026-10-14', '09:00'),
    (4, 4, 4, 4, 'Atendido', 600, '2026-10-20', '08:00'),
    (5, 5, 5, 4, 'Atendido', 800, '2026-10-27', '15:00'),
    (1, 6, 1, 4, 'Pendiente', 500, '2026-11-02', '08:00'),
    (6, 7, 6, 4, 'Confirmado', 900, '2026-11-05', '10:00'),
    (7, 8, 7, 4, 'Pendiente', 1000, '2026-11-10', '14:00'),
    (8, 9, 8, 4, 'Confirmado', 1100, '2026-11-16', '08:30'),
    (2, 10, 2, 4, 'Pendiente', 700, '2026-11-25', '14:00'),
    (3, 11, 3, 4, 'Confirmado', 600, '2026-12-02', '09:00'),
    (4, 12, 4, 4, 'Pendiente', 800, '2026-12-07', '08:00'),
    (5, 13, 5, 4, 'Confirmado', 900, '2026-12-11', '15:00'),
    (6, 14, 6, 4, 'Pendiente', 1000, '2026-12-16', '10:00'),
    (7, 15, 7, 4, 'Confirmado', 1100, '2026-12-21', '14:00'),
    (3, 16, 3, 4, 'Atendido', 700, '2026-10-12', '09:00'),
    (1, 6, 1, 4, 'Atendido', 500, '2026-09-01', '08:30'),
    (6, 7, 6, 4, 'Atendido', 900, '2026-09-03', '10:30'),
    (7, 8, 7, 4, 'Atendido', 1000, '2026-09-08', '14:30'),
    (8, 9, 8, 4, 'Atendido', 1100, '2026-09-10', '09:00'),
    (2, 10, 2, 4, 'Atendido', 700, '2026-09-15', '14:30'),
    (3, 11, 3, 4, 'Atendido', 600, '2026-09-17', '09:30'),
    (4, 12, 4, 4, 'Atendido', 800, '2026-09-22', '08:30'),
    (5, 13, 5, 4, 'Atendido', 900, '2026-09-24', '15:30'),
    (6, 14, 6, 4, 'Atendido', 1000, '2026-09-29', '10:30'),
    (7, 15, 7, 4, 'Atendido', 1100, '2026-10-01', '14:30');

--HISTORIAL MEDICO
INSERT INTO HistorialMedico (IDTurno, Diagnostico, Tratamiento)
VALUES
    (1, 'Gripe', 'Reposo y medicación'),
    (2, 'Hipertensión', 'Control de presión arterial y dieta'),
    (16, 'Fractura de brazo', 'Inmovilización y fisioterapia'),
    (4, 'Control oftalmológico anual','Examen de la vista y lentes correctivos'),
    (5, 'Revisión de medicación gastrointestinal','Ajuste de medicación y seguimiento'),
    (17, 'Alergia estacional','Antihistamínicos y evitar alérgenos'),
    (18, 'Tos crónica','Exámenes respiratorios y tratamiento según resultados'),
    (19, 'Aptitud física','Evaluación cardiológica y recomendaciones de ejercicio'),
    (20, 'Artritis reumatoide','Tratamiento con antiinflamatorios y fisioterapia'),
    (21, 'Hipertensión','Control de presión arterial y dieta'),
    (22, 'Dolor articular','Fisioterapia y medicación'),
    (23, 'Conjuntivitis','Tratamiento con colirios y seguimiento'),
    (24, 'Acidez estomacal','Dieta y medicación'),
    (25, 'Principio de neumonía','Antibióticos y reposo'),
    (26, 'Arritmia cardíaca','Control con medicación y seguimiento');

-- AUDITORIA TURNOS

-- [Comentario Gabriela] PENDIENTE:
-- No se cargan registros manualmente en AuditoriaTurnos.
-- Revisar su funcionamiento una vez implementado el trigger
-- encargado de registrar los cambios de estado de los turnos.
