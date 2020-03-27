#&&0
USE lszon;


#&&1
DELIMITER $$

DROP PROCEDURE IF EXISTS getId $$
CREATE PROCEDURE getId(IN id_card_in VARCHAR(5), OUT id_person_out int)
BEGIN

    SET id_person_out = (SELECT id_person
                         FROM persona p
                         WHERE p.id_card = id_card_in);

    IF id_person_out IS NULL THEN

        SET id_person_out = '-1';

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
CREATE PROCEDURE masterControlBadge(IN id_card_in VARCHAR(5), OUT wasFound int)
BEGIN

    DECLARE done INT DEFAULT 0;
    DECLARE time_stamp DATETIME;
    DECLARE time DATETIME;
    DECLARE persona VARCHAR(5);
    DECLARE id_user VARCHAR(5);
    DECLARE cur1 CURSOR FOR SELECT access_in, id_person FROM timer;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET time_stamp = now();

    OPEN cur1;
    buscaHora:
    LOOP
        CALL lsZon.getId('1234A', @cosa);
        FETCH cur1 INTO time, persona;
        IF done = 1 THEN
            INSERT INTO timer (access_in, access_out, id_person) VALUES (time_stamp, null, (SELECT @cosa));
            SET wasFound = 1;
        ELSEIF time IS NULL THEN


            #Sesion Abierta
        IF (HOUR(TIMEDIFF(time, time_stamp)) >= 8) THEN
            UPDATE timer SET access_out = '2000-01-01 00:00:00' WHERE id_user = @cosa;
            SET wasFound = 0;
         end if;
            #Se va a casa
        ELSEIF TIME_TO_SEC(TIMEDIFF(time, time_stamp)) > 20 && id_user = @cosa THEN
            UPDATE timer SET access_out = time_stamp WHERE id_user = @cosa;
            SET wasFound = 3;

            #Se va al almacen
        ELSEIF TIME_TO_SEC(TIMEDIFF(time, time_stamp)) < 20 && id_user = @cosa THEN
            SET wasFound = 2;
             #Se va a la office
        ELSE
            SET wasFound = 1;

        END IF;

    END LOOP buscaHora;

END
$$


DELIMITER ;
#&&5
CALL lsZon.masterControlBadge(1, @result);

#&&6
SELECT @result;



