USE alta_turnos;

/*ENTREGA 2 DOMINGUEZ ESTEFANIA*/
-- FUNCIONES
-- 1. Función para obtener el primer con turno de la obra social "Swiss Medical":

DELIMITER //

CREATE FUNCTION paciente_turno_swiss_medical()
RETURNS VARCHAR(70)
DETERMINISTIC
BEGIN
    DECLARE nombre_paciente VARCHAR(70);
    SELECT p.nombre_completo
    INTO nombre_paciente
    FROM alta_turnos.pacientes AS p
    JOIN alta_turnos.turnos AS t ON p.id_paciente = t.id_paciente
    JOIN alta_turnos.obraSocial AS os ON p.id_obraSocial = os.id_obraSocial
    WHERE t.estado_turno = 'Confirmado'
      AND os.nombre_obra_social = 'Swiss Medical'
    LIMIT 1;

    RETURN nombre_paciente;
END //

DELIMITER ;

-- 2. Función para EL PRIMER ESPECIALISTA DISPONIBLE para un día lunes:

DELIMITER //

CREATE FUNCTION especialista_disponible_lunes()
RETURNS VARCHAR(70)
DETERMINISTIC
BEGIN
    DECLARE nombre_especialista VARCHAR(70);
    SELECT e.nombre
    INTO nombre_especialista
    FROM alta_turnos.especialistas AS e
    JOIN alta_turnos.turnos AS t ON e.id_especialista = t.id_especialista
    JOIN alta_turnos.dias AS d ON t.id_dia = d.id_dia
    WHERE DAYNAME(d.fecha) = 'Monday'
      AND d.cupo > 0
    LIMIT 1;

    RETURN nombre_especialista;
END;

DELIMITER;

SELECT especialista_disponible_lunes();
SELECT paciente_turno_swiss_medical();


-- VISTAS
-- Vista para ver la obra social por la cual los pacientes toman más turnos:

CREATE VIEW obra_social_mas_turnos AS
SELECT os.nombre_obra_social AS obra_social, COUNT(t.id_turno) AS total_turnos
FROM alta_turnos.pacientes AS p
JOIN alta_turnos.turnos AS t ON p.id_paciente = t.id_paciente
JOIN alta_turnos.obraSocial AS os ON p.id_obraSocial = os.id_obraSocial
GROUP BY os.nombre_obra_social
ORDER BY total_turnos DESC;


-- Vista para ver el día que los pacientes toman más turnos:

CREATE VIEW dia_mayor_cantidad_turnos AS
SELECT d.fecha AS dia, COUNT(t.id_turno) AS total_turnos
FROM alta_turnos.dias AS d
JOIN alta_turnos.turnos AS t ON d.id_dia = t.id_dia
GROUP BY d.fecha
ORDER BY total_turnos DESC;


-- PROCEDIMIENTOS
-- 1 Insertar nuevo paciente en la tabla pacientes


DELIMITER //
CREATE PROCEDURE insertar_nuevo_paciente(
    IN nombre_completo VARCHAR(70),
    IN email VARCHAR(80),
    IN dni VARCHAR(10),
    IN telefono VARCHAR(15),
    IN id_obraSocial INT
)
BEGIN
    INSERT INTO alta_turnos.pacientes (nombre_completo, email, dni, telefono, id_obraSocial)
    VALUES (nombre_completo, email, dni, telefono, id_obraSocial);
END //
DELIMITER ;


-- 2 devuelve todos los turnos segun estado.

DELIMITER //

CREATE PROCEDURE listar_todos_los_turnos()
BEGIN
    SELECT t.id_turno, 
           p.nombre_completo AS paciente, 
           e.nombre AS especialista, 
           t.estado_turno
    FROM alta_turnos.turnos AS t
    JOIN alta_turnos.pacientes AS p ON t.id_paciente = p.id_paciente
    JOIN alta_turnos.especialistas AS e ON t.id_especialista = e.id_especialista;
END //

DELIMITER ;

-- 3 devuelve todos los turnos que están en estado "Confirmado".

DELIMITER //
CREATE PROCEDURE listar_turnos_confirmados()
BEGIN
    SELECT t.id_turno, p.nombre_completo AS paciente, e.nombre AS especialista, t.estado_turno
    FROM alta_turnos.turnos AS t
    JOIN alta_turnos.pacientes AS p ON t.id_paciente = p.id_paciente
    JOIN alta_turnos.especialistas AS e ON t.id_especialista = e.id_especialista
    WHERE t.estado_turno = 'Confirmado';
END//
DELIMITER ;

-- TRIGGERS
-- trigger de insercion, cada vez que se inserta un nuevo turno, se deja registro en una tabla


DELIMITER //

CREATE TRIGGER after_turno_insert
AFTER INSERT ON alta_turnos.turnos
FOR EACH ROW
BEGIN
    INSERT INTO alta_turnos.turnos_audit (id_turno)
    VALUES (NEW.id_turno);
END//

DELIMITER ;

-- actualizar el cupo de la tabla dias
-- se reserva un turno, y el cupo se resta - 1
DELIMITER //

CREATE TRIGGER after_turno_insert_update_cupo
AFTER INSERT ON alta_turnos.turnos
FOR EACH ROW
BEGIN
    UPDATE alta_turnos.dias
    SET cupo = cupo - 1
    WHERE id_dia = NEW.id_dia;
END//

DELIMITER ;

