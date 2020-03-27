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
    DECLARE cur1 CURSOR FOR SELECT access_out, id_person FROM timer;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET time_stamp = now();
    OPEN cur1;
    buscaHora:
    LOOP
        FETCH cur1 INTO id_card_in;

        IF done = 1 THEN
            INSERT INTO timer (access_in, access_out, id_person) VALUES (time_stamp, null, (SELECT @result));
            SET wasFound = 1;
            LEAVE buscaHora;
        ELSE IF c
        END IF;

    END LOOP buscaHora
    $$


    INSERT INTO timer (access_in, access_out, id_person) VALUES (null, null, (SELECT @result));

END $$


DELIMITER ;
#&&5
CALL lsZon.masterControlBadge(1, @result);

#&&6
SELECT @result;



