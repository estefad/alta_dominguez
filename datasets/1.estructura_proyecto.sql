DROP DATABASE IF EXISTS alta_turnos;
CREATE DATABASE alta_turnos;
USE alta_turnos;

CREATE TABLE alta_turnos.obraSocial(
	id_obraSocial INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_obra_social VARCHAR(50)
);
-- tabla de obra sociales


CREATE TABLE alta_turnos.especialidades(
	id_especialidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    especialidad VARCHAR(50)
);
-- especialidades dentro del centro

CREATE TABLE alta_turnos.dias(
	id_dia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    cupo INT
);
-- tabla de dias y cupos disponibles

CREATE TABLE alta_turnos.especialistas(
	id_especialista INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(70),
    matricula VARCHAR(50),
    id_especialidad INT
);
-- tabla de los profesionales

CREATE TABLE alta_turnos.pacientes(
	id_paciente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(70),
    email VARCHAR(80),
    dni VARCHAR(10),
    telefono VARCHAR(15),
    id_obraSocial INT
);

CREATE TABLE alta_turnos.turnos(
	id_turno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    estado_turno VARCHAR(20),
    observaciones TEXT,
    id_especialista INT,
    id_paciente INT,
    id_dia INT
);
-- a traves de la tabla turnos, conectamos a los pacientes con la especialidad y dias disponibles


-- ALTER
-- genero las llaves foraneas de las tablas y sus relaciones

ALTER TABLE turnos
    ADD CONSTRAINT fk_turnos_paciente
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente);

ALTER TABLE turnos
    ADD CONSTRAINT fk_turnos_especialistas
    FOREIGN KEY (id_especialista) REFERENCES especialistas(id_especialista);

ALTER TABLE turnos
    ADD CONSTRAINT fk_turnos_dia
    FOREIGN KEY (id_dia) REFERENCES dias(id_dia);

ALTER TABLE especialistas
    ADD CONSTRAINT fk_especialistas_especialidades
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad);
    
    ALTER TABLE pacientes
    ADD CONSTRAINT fk_pacientes_obrasocial
    FOREIGN KEY (id_obrasocial) REFERENCES obraSocial(id_obrasocial);


/*creacion de tabla de auditoria*/

CREATE TABLE alta_turnos.turnos_audit (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_turno INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
