&&0
USE lsZon;

#&&1
DELIMITER $$
DROP PROCEDURE IF EXISTS getId $$
CREATE PROCEDURE getId(IN id_card_in VARCHAR(5), OUT id_person_out INTEGER)
BEGIN
	SET id_person_out = (SELECT p.id_person
						 FROM Persona AS p
                         WHERE p.id_card = id_card_in);
                         
						 IF(id_person_out = NULL)
                         THEN
							SET id_person_out = '-1';
                         END IF;
END $$
$$


#&&2
CALL lsZon.getId ('1234A', @result);


#&&3
SELECT @result;


#&&4
DELIMITER $$
DROP PROCEDURE IF EXISTS masterControlBadge $$
CREATE PROCEDURE masterControlBadge (IN id_person_in INTEGER, OUT WasFound INTEGER)
BEGIN

DECLARE done INTEGER;
DECLARE id_persona INTEGER;
DECLARE access DATETIME;
DECLARE sortida DATETIME;
DECLARE hora_actual DATETIME;

DECLARE aux CURSOR FOR (SELECT t.id_person, t.access_in, t.access_out
					    FROM Timer AS t);

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

SET hora_actual = now();

OPEN aux;
	busca:LOOP
		FETCH aux INTO id_persona, access, sortida;
        
        IF(TIMESTAMPDIFF(HOUR, access, hora_actual) >= 8 AND sortida IS NULL)
        THEN
			UPDATE Timer SET access_out = '2000-01-01 00:00:00' WHERE id_person = id_person_in AND access_out IS NULL;
            INSERT INTO timer(id_person, access_in, access_out) VALUES (1, now(), NULL);
            
            SET wasFound = 0;
            LEAVE busca;
        END IF;
        
        IF(done = 1)
        THEN
        INSERT INTO timer(id_person, access_in, access_out) VALUES (1, now(), NULL);
			SET wasFound = 1;
            LEAVE busca;
		END IF;
        
        IF(TIMESTAMPDIFF(SECOND, access, hora_actual) <=20 AND sortida IS NULL)
        THEN
			SET wasFound = 2;
            LEAVE busca;
        END IF;
        
        IF(TIMESTAMPDIFF(SECOND, access, hora_actual) > 20 AND sortida IS NULL)
        THEN
			UPDATE Timer SET access_out = hora_actual WHERE sortida IS NULL AND id_person = id_person_in;
			SET wasFound = 3;
            LEAVE busca;
        END IF;
        
        
    END LOOP;
CLOSE aux;
	
END $$
$$


#&&5
CALL lsZon.masterControlBadge(1, @result);


#&&6
SELECT @result;