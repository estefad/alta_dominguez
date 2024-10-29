USE alta_turnos;

-- INSERCION DE DATOS A LAS TABLAS

INSERT INTO alta_turnos.dias (fecha, hora, cupo) VALUES 
('2024-09-10', '09:00:00', 5),
('2024-09-10', '11:00:00', 5),
('2024-09-11', '10:00:00', 4),
('2024-09-12', '14:00:00', 6),
('2024-09-13', '15:00:00', 3);

INSERT INTO alta_turnos.especialidades (especialidad) VALUES 
('Psicología'),
('Psiquiatría'),
('Terapia Ocupacional'),
('Neurología'),
('Nutrición');

INSERT INTO alta_turnos.especialistas (nombre, matricula, id_especialidad) VALUES 
('Dr. Juan Pérez', 'M123456', 1),
('Dra. Ana López', 'M654321', 2),
('Lic. María Gómez', 'T789012', 3),
('Dr. Pedro Martínez', 'M234567', 4),
('Lic. Laura Fernández', 'T890123', 5);

INSERT INTO alta_turnos.obraSocial (nombre_obra_social) VALUES 
('OSDE'),
('Swiss Medical'),
('Galeno'),
('Medifé'),
('Omint');

INSERT INTO alta_turnos.pacientes (nombre_completo, email, dni, telefono, id_obraSocial) VALUES 
('Carlos Mendoza', 'carlos.mendoza@mail.com', '12345678', '1234567890', 1),
('Lucía Rodríguez', 'lucia.rodriguez@mail.com', '23456789', '2345678901', 2),
('Martín Gómez', 'martin.gomez@mail.com', '34567890', '3456789012', 3),
('Sofía Pérez', 'sofia.perez@mail.com', '45678901', '4567890123', 4),
('Juan Fernández', 'juan.fernandez@mail.com', '56789012', '5678901234', 5);

INSERT INTO alta_turnos.turnos (estado_turno, observaciones, id_especialista, id_paciente, id_dia) VALUES 
('Confirmado', 'Primera consulta', 1, 1, 1),
('Confirmado', 'Control mensual', 2, 2, 2),
('Cancelado', 'Reagendar', 3, 3, 3),
('Confirmado', 'Primera consulta', 4, 4, 4),
('Pendiente', 'Esperando confirmación', 5, 5, 5);
