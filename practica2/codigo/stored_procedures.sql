USE f1_olap;

#-------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS log $$
CREATE PROCEDURE log(IN error BOOL, IN nombre char(255))
BEGIN
    IF (error = true) THEN

        INSERT INTO log (fecha, importation_error) VALUES (NOW(), nombre);
    end if;
END $$
DELIMITER ;

#-------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS compare_circuit $$
CREATE PROCEDURE compare_circuit()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE identificador INTEGER;
    DECLARE cur CURSOR FOR (SELECT circuitId,
                                   circuitRef,
                                   name,
                                   location,
                                   country,
                                   lat,
                                   lng,
                                   alt,
                                   url
                            FROM circuits);


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    compare:
    LOOP
        FETCH cur INTO identificador;
        IF done = 1 THEN
            LEAVE compare;
        END IF;

        IF ((SELECT identificador) NOT IN (SELECT circuitId,
                                                  circuitRef,
                                                  name,
                                                  location,
                                                  country,
                                                  lat,
                                                  lng,
                                                  alt,
                                                  url
                                           FROM f1.circuits)) THEN
            CALL log(true, 'circuit');

        END IF;

    END LOOP;
    CLOSE cur;
END
$$
DELIMITER ;

#-------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS compare_constructor$$
CREATE PROCEDURE compare_constructor()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE identificador INTEGER;
    DECLARE cur CURSOR FOR (SELECT constructorId,
                                   constructorRef,
                                   name,
                                   nationality,
                                   url
                            FROM constructors);


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    compare:
    LOOP
        FETCH cur INTO identificador;
        IF done = 1 THEN
            LEAVE compare;
        END IF;

        IF ((SELECT identificador) NOT IN (SELECT constructorId,
                                                  constructorRef,
                                                  name,
                                                  nationality,
                                                  url
                                           FROM f1.constructors)) THEN
            CALL log(true, 'constructor');

        END IF;

    END LOOP;
    CLOSE cur;
END
$$
DELIMITER ;

#-------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS compare_driver $$
CREATE PROCEDURE compare_driver()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE identificador INTEGER;
    DECLARE cur CURSOR FOR (SELECT driverId,
                                   driverRef,
                                   number,
                                   code,
                                   forename,
                                   surname,
                                   dob,
                                   nationality,
                                   url
                            FROM drivers);


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    compare:
    LOOP
        FETCH cur INTO identificador;
        IF done = 1 THEN
            LEAVE compare;
        END IF;

        IF ((SELECT identificador) NOT IN (SELECT driverId,
                                                  driverRef,
                                                  number,
                                                  code,
                                                  forename,
                                                  surname,
                                                  dob,
                                                  nationality,
                                                  url
                                           FROM f1.drivers)) THEN
            CALL log(true, 'driver');

        END IF;

    END LOOP;
    CLOSE cur;
END
$$
DELIMITER ;

#-------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS compare_laptimes $$
CREATE PROCEDURE compare_laptimes()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE identificador INTEGER;
    DECLARE cur CURSOR FOR (SELECT raceId,
                                   driverId,
                                   lap,
                                   position,
                                   time,
                                   milliseconds
                            FROM laptimes);


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    compare:
    LOOP
        FETCH cur INTO identificador;
        IF done = 1 THEN
            LEAVE compare;
        END IF;

        IF ((SELECT identificador) NOT IN (SELECT raceId,
                                                  driverId,
                                                  lap,
                                                  position,
                                                  time,
                                                  milliseconds
                                           FROM f1.laptimes)) THEN
            CALL log(true, 'laptimes');

        END IF;

    END LOOP;
    CLOSE cur;
END
$$
DELIMITER ;

#-------------------------------------------------
DELIMITER $$
DROP PROCEDURE IF EXISTS compare_results $$
CREATE PROCEDURE compare_results()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE identificador INTEGER;
    DECLARE cur CURSOR FOR (SELECT resultId,
                                   raceId,
                                   driverId,
                                   constructorId,
                                   number,
                                   grid,
                                   position,
                                   positionText,
                                   positionOrder,
                                   points,
                                   laps,
                                   time,
                                   milliseconds,
                                   fastestLap,
                                   `rank`,
                                   fastestLapTime,
                                   fastestLapSpeed
                            FROM results);


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    compare:
    LOOP
        FETCH cur INTO identificador;
        IF done = 1 THEN
            LEAVE compare;
        END IF;

        IF ((SELECT identificador) NOT IN (SELECT resultId,
                                                  raceId,
                                                  driverId,
                                                  constructorId,
                                                  number,
                                                  grid,
                                                  position,
                                                  positionText,
                                                  positionOrder,
                                                  points,
                                                  laps,
                                                  time,
                                                  milliseconds,
                                                  fastestLap,
                                                  `rank`,
                                                  fastestLapTime,
                                                  fastestLapSpeed
                                           FROM f1.results)) THEN
            CALL log(true, 'results');

        END IF;

    END LOOP;
    CLOSE cur;
END
$$
DELIMITER ;
#-------------------------------------------------

