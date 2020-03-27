# STORED PROCEDURE d'EXEMPLE per a Bases de Dades
# A APLICAR en BBDD d'EXEMPLE NUM.3 per a Bases de Dades
# (C) Albert Prior

# OBJECTIU: Realitzar un backup d'una base de dades declarada emprant les eines disponibles d'un Stored Procedure, mostrant per pantalla el progres de la copia

# Inicialment crearem la BBDD que sera el desti de la copia (bd_ejemplo4)
DROP DATABASE IF EXISTS bd_ejemplo4;
CREATE DATABASE bd_ejemplo4;
USE bd_ejemplo4;

# Inicialitzem nou delimitador
DELIMITER $$

# Esborrem procedure si existeix
DROP PROCEDURE IF EXISTS fes_backup  $$

# Creem procedure 'fes_backup' i passem dos parametres: nom de bbdd a copiar i nom de bbdd desti de la copia
CREATE PROCEDURE  fes_backup (IN nom_bbdd VARCHAR(20), IN nou_nom_bbdd VARCHAR(20))
BEGIN

   # Declarem variable per control de LOOP (done) i per emmagatzemar noms de les taules (nom_taula)
   DECLARE done INT DEFAULT 0;
   DECLARE nom_taula VARCHAR(20);

   # Declarem cursor amb consulta que recupera els noms de les taules (no virtuals) de la vista del metadata (information_schema)
   DECLARE cur1 CURSOR FOR SELECT table_name FROM information_schema.tables
   WHERE table_schema=nom_bbdd AND table_type="base table";

   # Declarem el Handler pel control del bucle
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

   # Obrim el cursor per a comencar a emprar-lo
   OPEN cur1;

   bucle: LOOP
   
      # Volquem el nom de la taula sobre la variable i avancem cursor
      FETCH cur1 INTO nom_taula;
	  # Si hem assolit el limit del cursor sortim del bucle
      IF done=1 THEN
         LEAVE bucle;
      END IF;
	  
	  # Concatem missatge per a mostrar-lo per pantalla
      SELECT CONCAT("Copio ",nom_taula," a nova base de dades ",nou_nom_bbdd);

	  # Creem cadena auxiliar amb instruccio de DDL, la preparem, l'executem i desassignem la sentencia - copiem estructura de taula original
      SET @aux = CONCAT("CREATE TABLE ",nom_taula," LIKE ", nom_bbdd, ".", nom_taula);
      PREPARE stmt1 FROM @aux;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;

	  # Creem cadena auxiliar amb instruccio de DML, la preparem, l'executem i desassignem la sentencia - inserim continguts de taula original
      SET @aux = CONCAT("INSERT INTO ",nom_taula," SELECT * FROM ", nom_bbdd, ".", nom_taula);
      PREPARE stmt1 FROM @aux;
      EXECUTE stmt1;
      DEALLOCATE PREPARE stmt1;

   END LOOP bucle;

   # Tanquem el cursor per a finalitzar el seu us
   CLOSE cur1;

END$$

# Recuperem delimitador original
DELIMITER ;

# Executem el procedure original
CALL fes_backup("proves_bd","bd_ejemplo4");

show tables;