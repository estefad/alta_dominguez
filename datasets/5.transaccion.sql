USE alta_turnos;

-- transaccion que inserta un nuevo paciente y le asigna un turno, si alguna operacion falla, se deshacen los cambios
START TRANSACTION;

-- Insertar un nuevo paciente
INSERT INTO alta_turnos.pacientes (nombre_completo, email, dni, telefono, id_obraSocial)
VALUES ('Andrea Ruiz', 'andrea.ruiz@mail.com', '49863578', '3466351', 2);

-- Asignar un turno a ese paciente (id_paciente es el último insertado)
INSERT INTO alta_turnos.turnos (estado_turno, observaciones, id_especialista, id_paciente, id_dia)
VALUES ('Pendiente', 'Primera consulta', 1, LAST_INSERT_ID(), 2);

-- Verificar si las operaciones funcionaron y confirmar la transacción
COMMIT;

-- Si alguna operación falla, se deshacen los cambios
ROLLBACK;
