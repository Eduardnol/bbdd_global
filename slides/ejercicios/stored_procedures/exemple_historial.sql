# (C) Albert Prior

# OBJECTIU: Realitzar una prova basica de stored procedure que explori la taula personal

# Inicialment crearem la BBDD de prova (proves)
DROP DATABASE IF EXISTS proves_bd;
CREATE DATABASE proves_bd;
USE proves_bd;

# Creem la taula PERSONAL
CREATE TABLE personal(
ID INTEGER NOT NULL AUTO_INCREMENT,
nom VARCHAR(20),
cognom VARCHAR(20),
PRIMARY KEY(ID));

# Inserim els valors basics de la taula
INSERT INTO personal(nom,cognom) VALUES
('Juan','Martin'),
('Juan','Perez'),
('Juan','Vives');

# Creem la taula HISTORIAL
CREATE TABLE historial
(
    ID_persona INTEGER NOT NULL
);

# Inicialitzem nou delimitador
DELIMITER $$

# Esborrem procedure si existeix
DROP PROCEDURE IF EXISTS calcul_ex $$

# Creem procedure 'calcul_ex' per a l'objectiu desitjat
CREATE PROCEDURE calcul_ex()
BEGIN

    # Declarem variable per control de LOOP (done) i per emmagatzemar noms de les taules (nom_taula)
    DECLARE done INT DEFAULT 0;
    DECLARE identificador INTEGER;

    # Declarem cursor amb consulta que recupera els noms de les taules (no virtuals) de la vista del metadata (information_schema)
    DECLARE cur1 CURSOR FOR SELECT ID FROM PERSONAL;

    # Declarem el Handler pel control del bucle
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    # Obrim el cursor per a comencar a emprar-lo
    OPEN cur1;

    nom_loop:
    LOOP
        FETCH cur1 INTO identificador;
        IF done = 1 THEN
            LEAVE nom_loop;
        END IF;
        SELECT identificador;
        INSERT INTO historial VALUES (identificador);
    END LOOP nom_loop;

    CLOSE cur1;

END $$
DELIMITER ;

# Cridem el stored procedure declarat
CALL calcul_ex();

# Mostrem resultats de taula HISTORIAL
SELECT *
FROM historial;