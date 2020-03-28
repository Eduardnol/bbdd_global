#&&0
USE lszon;


#&&1
DELIMITER $$

DROP PROCEDURE IF EXISTS getId $$
CREATE PROCEDURE getId(IN id_card_in VARCHAR(5), OUT id_person_out INTEGER)
BEGIN

    SET id_person_out = (SELECT id_person
                         FROM persona p
                         WHERE p.id_card = id_card_in);

    IF id_person_out IS NULL THEN

        SET id_person_out = -1;

    END IF;


END $$

DELIMITER ;


#&&2
CALL lsZon.getId('1234A', @result);

#&&3
SELECT @result;


#&&4
DELIMITER $$

DROP PROCEDURE IF EXISTS masterControlBadge $$
CREATE PROCEDURE masterControlBadge(IN id_persona int, OUT wasFound int)
BEGIN

    DECLARE done INT DEFAULT 0;
    DECLARE actual_time DATETIME;
    DECLARE time_in DATETIME;
    DECLARE time_out DATETIME;
    DECLARE persona VARCHAR(5);
    DECLARE id_user INT;
    DECLARE cur1 CURSOR FOR SELECT access_in, access_out, id_person FROM timer;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    SET id_user = id_persona;
    SET actual_time = now();


    OPEN cur1;
    buscaHora:
    LOOP

        FETCH cur1 INTO time_in, time_out, persona;

        #se va a la office
        IF done = 1 THEN
            INSERT INTO timer (access_in, access_out, id_person) VALUES (actual_time, null, id_user);
            SET wasFound = 1;
            LEAVE buscaHora;
        END IF;

        #Sesion Abierta
        IF TIMESTAMPDIFF(HOUR, time_in, actual_time) >= 8 AND time_out IS NULL THEN
            UPDATE timer SET access_out = '2000-01-01 00:00:00' WHERE id_person = id_user AND access_out IS NULL;
            SET wasFound = 0;
            LEAVE buscaHora;

            #Se va a casa
        ELSEIF TIMESTAMPDIFF(SECOND, time_in, actual_time) >= 20 AND time_out IS NULL THEN
            UPDATE timer SET access_out = actual_time WHERE id_person = id_user AND access_out IS NULL;
            SET wasFound = 3;
            LEAVE buscaHora;

            #Se va al almacen
        ELSEIF TIMESTAMPDIFF(SECOND, time_in, actual_time) < 20 AND time_out IS NULL THEN
            SET wasFound = 2;
            LEAVE buscaHora;

        END IF;

    END LOOP buscaHora;

END
$$
DELIMITER ;

#&&5
CALL lsZon.masterControlBadge(1, @result);

#&&6
SELECT @result;



