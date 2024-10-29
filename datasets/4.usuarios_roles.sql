USE alta_turnos;
/*Generacion de rol para usuario que solo tiene acceso a la tabla de dias y pacientes,
puede insertar cupo disponible, asi como nuevos pacientes de manera manual, 
pero no tiene acceso al resto de las tablas */

CREATE USER IF NOT EXISTS 'estefania_d'@'%'
	IDENTIFIED BY 'estef23';

GRANT SELECT, INSERT ON alta_turnos.dias TO 'estefania_d'@'%';
GRANT SELECT, INSERT ON alta_turnos.pacientes TO 'estefania_d'@'%';