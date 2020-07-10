use f1;

#--------------------------------------------------------------Trigger--------------------------------------------------------------
#DRIVERS
DELIMITER $$
DROP TRIGGER IF EXISTS insert_drivers;
create trigger insert_drivers
    after insert
    on f1.drivers
    for each row
begin

    IF EXISTS(SELECT * FROM f1_olap.drivers d WHERE d.driverId = NEW.driverId) THEN


        insert into f1_olap.drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url)
        select NEW.driverId,
               NEW.driverRef,
               NEW.number,
               NEW.code,
               NEW.forename,
               NEW.surname,
               NEW.dob,
               NEW.nationality,
               NEW.url;


    ELSE


        insert into f1_olap.drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url)
        select NEW.driverId,
               NEW.driverRef,
               NEW.number,
               NEW.code,
               NEW.forename,
               NEW.surname,
               NEW.dob,
               NEW.nationality,
               NEW.url;

    END IF;

end;
DELIMITER ;

#CONSTRUCTORS
DELIMITER $$
DROP TRIGGER IF EXISTS insert_constructors;
create trigger insert_constructors
    after insert
    on f1.constructors
    for each row
begin

    IF EXISTS(SELECT * FROM f1_olap.constructors c WHERE c.constructorId = NEW.constructorId) THEN


        insert into f1_olap.constructors (constructorId, constructorRef, name, nationality, url)
        select NEW.constructorId,
               NEW.constructorRef,
               NEW.name,
               NEW.nationality,
               NEW.url;

    ELSE
        insert into f1_olap.constructors (constructorId, constructorRef, name, nationality, url)
        select NEW.constructorId,
               NEW.constructorRef,
               NEW.name,
               NEW.nationality,
               NEW.url;

    END IF;

end;
DELIMITER ;

#--------------------------------------------------------------
#CIRCUITS
DELIMITER $$
DROP TRIGGER IF EXISTS insert_circuits;
create trigger insert_circuits
    after insert
    on f1.circuits
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.circuits c WHERE c.circuitId = NEW.circuitId) THEN

        update f1_olap.circuits
        SET circuitId  = NEW.circuitId,
            circuitRef = NEW.circuitRef,
            name       = NEW.name,
            location   = NEW.location,
            country    = NEW.country,
            lat        = NEW.lat,
            lng        = NEW.lng,
            alt        = NEW.alt,
            url        = NEW.url
        WHERE circuitId = NEW.circuitId;
        #TODO gestionar las relaciones si uno se ha inserido pero el otro no


    ELSE

        insert into f1_olap.circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url)
        select NEW.circuitId,
               NEW.circuitRef,
               NEW.name,
               NEW.location,
               NEW.country,
               NEW.lat,
               NEW.lng,
               NEW.alt,
               NEW.url;

    END IF;

end;
DELIMITER ;

#RACE
DELIMITER $$
DROP TRIGGER IF EXISTS insert_race;
create trigger insert_race
    after insert
    on f1.races
    for each row
begin

    IF EXISTS(SELECT * FROM f1_olap.circuits c WHERE c.circuitId = NEW.circuitId) THEN

        update f1_olap.circuits
        SET raceID    = NEW.raceId,
            year      = NEW.year,
            round     = NEW.round,
            name_race = NEW.name,
            date      = NEW.date,
            time      = NEW.time,
            url_race  = NEW.url

        WHERE f1_olap.circuits.circuitId = NEW.circuitId;


    ELSE


        insert into f1_olap.circuits (circuitId, raceId, year, round, name_race,
                                      date, time, url_race)
        select NEW.circuitId,
               NEW.raceId,
               NEW.year,
               NEW.round,
               NEW.name,
               NEW.date,
               NEW.time,
               NEW.url;
    END IF;

end;
DELIMITER ;


#SEASONS
DELIMITER $$
DROP TRIGGER IF EXISTS insert_seasons;
create trigger insert_seasons
    after insert
    on f1.seasons
    for each row
begin

    IF EXISTS(SELECT * FROM f1_olap.circuits c WHERE c.year = 0) THEN

        update f1_olap.circuits
        SET year       = NEW.year,
            url_season = NEW.url
        WHERE f1_olap.circuits.year = NEW.year;


    ELSE


        insert into f1_olap.circuits (year, url_season)
        select NEW.year,
               NEW.url;
    END IF;

end;
DELIMITER ;


#--------------------------------------------------------------


#CONSTRUCTOR_RESULTS
DELIMITER $$
DROP TRIGGER IF EXISTS insert_constructorResults;
create trigger insert_constructorResults
    after insert
    on f1.constructorresults
    for each row
begin

    IF EXISTS(SELECT * FROM f1_olap.results r WHERE r.constructorId = NEW.constructorId) THEN

        update f1_olap.results
        SET raceID             = NEW.raceId,
            constructorId      = NEW.constructorId,
            points_constructor = NEW.points,
            status_constructor = NEW.status
        WHERE f1_olap.results.raceId = NEW.raceId
          AND f1_olap.results.constructorId = NEW.constructorId;


    ELSE


        insert into f1_olap.results (raceId, constructorId,
                                     points_constructor, status_constructor, raceId, constructorId)
        select NEW.raceId,
               NEW.constructorId,
               NEW.points,
               NEW.status,
               NEW.raceId,
               NEW.constructorId;

    END IF;

end;
DELIMITER ;

#CONSTRUCTOR STANDINGS
DELIMITER $$
DROP TRIGGER IF EXISTS insert_constructorStandings;
create trigger insert_constructorStandings
    after insert
    on f1.constructorstandings
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.results l WHERE l.raceId = NEW.raceId) THEN

        update f1_olap.results
        SET raceId                      = NEW.raceId,
            constructorId               = NEW.constructorId,
            points_constructor_standing = NEW.points,
            position_constructor        = NEW.position,
            positionText_constructor    = NEW.positionText,
            wins                        = NEW.wins
        WHERE raceId = NEW.raceId
          AND constructorId = NEW.constructorId;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no


    ELSE

        insert into f1_olap.results (raceId, constructorId, points_constructor_standing, position_constructor,
                                     positionText_constructor, wins, raceId, constructorId)
        select NEW.raceId,
               NEW.constructorId,
               NEW.points,
               NEW.position,
               NEW.positionText,
               NEW.wins,
               NEW.raceId,
               NEW.constructorId;
    END IF;

end;
DELIMITER ;


#DRIVER STANDINGS

DELIMITER $$
DROP TRIGGER IF EXISTS insert_driverStandings;
create trigger insert_driverStandings
    after insert
    on f1.driverstandings
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.results l WHERE l.raceId = NEW.raceId) THEN

        update f1_olap.results
        SET points_driver       = NEW.points,
            position_driver     = NEW.position,
            positionText_driver = NEW.positionText,
            wins_driver         = NEW.wins
        WHERE raceId = NEW.raceId
          AND driverId = NEW.driverId;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no


    ELSE

        insert into f1_olap.results (points_driver, position_driver, positionText_driver,
                                     wins_driver, raceId, driverId)
        select NEW.points,
               NEW.position,
               NEW.positionText,
               NEW.wins,
               NEW.raceId,
               NEW.driverId;
    END IF;

end;
DELIMITER ;


#STATUS

DELIMITER $$
DROP TRIGGER IF EXISTS insert_status;
create trigger insert_status
    after insert
    on f1.status
    for each row
BEGIN

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.results l WHERE l.status is null) THEN

        update f1_olap.results
        SET status = NEW.status
        WHERE f1.results.statusId = NEW.statusId
          AND f1.results.raceId = f1_olap.results.raceId;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no


#     ELSE
#
#         insert into f1_olap.results (points_driver, position_driver, positionText_driver,
#                                      wins_driver, raceId, driverId)
#         select NEW.points,
#                NEW.position,
#                NEW.positionText,
#                NEW.wins,
#                NEW.raceId,
#                NEW.driverId;
    END IF;

end;
DELIMITER ;

#QUALIFYING
DELIMITER $$
DROP TRIGGER IF EXISTS insert_qualifying;
create trigger insert_qualifying
    after insert
    on f1.qualifying
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.results l WHERE l.raceId = NEW.raceId) THEN

        update f1_olap.results
        SET position_qual = NEW.position,
            q1            = NEW.q1,
            q2            = NEW.q2,
            q3            = NEW.q3
        WHERE raceId = NEW.raceId
          AND driverId = NEW.driverId;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no
    ELSE

        insert into f1_olap.results (position_qual, q1, q2, q3, raceId, driverId)
        select NEW.position,
               NEW.q1,
               NEW.q2,
               NEW.q3,
               NEW.raceId,
               NEW.driverId;
    END IF;

end;
DELIMITER ;

#RESULTS
DELIMITER $$
DROP TRIGGER IF EXISTS insert_results;
create trigger insert_results
    after insert
    on f1.results
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.results l WHERE l.raceId = NEW.raceId) THEN

        update f1_olap.results
        SET grid            = NEW.grid,
            position        = NEW.position,
            positionText    = NEW.positionText,
            positionOrder   = NEW.positionOrder,
            points          = NEW.points,
            laps            = NEW.laps,
            time            = NEW.time,
            milliseconds    = NEW.milliseconds,
            fastestLap      = NEW.fastestLap,
            `rank`          = NEW.`rank`,
            fastestLapTime  = NEW.fastestLapTime,
            fastestLapSpeed = NEW.fastestLapSpeed
        WHERE raceId = NEW.raceId
          AND driverId = NEW.driverId;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no
    ELSE

        insert into f1_olap.results (grid, position, positionText, positionOrder, points, laps, time, milliseconds,
                                     fastestLap, `rank`, fastestLapTime, fastestLapSpeed, raceId, driverId)
        select NEW.grid,
               NEW.position,
               NEW.positionText,
               NEW.positionOrder,
               NEW.points,
               NEW.laps,
               NEW.time,
               NEW.milliseconds,
               NEW.fastestLap,
               NEW.`rank`,
               NEW.fastestLapTime,
               NEW.fastestLapSpeed,
               NEW.raceId,
               NEW.driverId;
    END IF;

end;
DELIMITER ;


#-------------------------------------------------------------------

#LAPTIME
DELIMITER $$
DROP TRIGGER IF EXISTS insert_laptime;
create trigger insert_laptime
    after insert
    on f1.laptimes
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.laptimes l WHERE l.time is null) THEN

        update f1_olap.laptimes
        SET raceId       = NEW.raceId,
            driverId     = NEW.driverId,
            lap          = NEW.lap,
            position     = NEW.position,
            time         = NEW.time,
            milliseconds = NEW.milliseconds
        WHERE raceId = NEW.raceId
          AND driverId = NEW.driverId
          AND lap = NEW.lap;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no


    ELSE

        insert into f1_olap.laptimes (raceId, driverId, lap, position, time, milliseconds)
        select NEW.raceId,
               NEW.driverId,
               NEW.lap,
               NEW.position,
               NEW.time,
               NEW.milliseconds;

    END IF;

end;
DELIMITER ;


#PITSTOP
DELIMITER $$
DROP TRIGGER IF EXISTS insert_pitstop;
create trigger insert_pitstop
    after insert
    on f1.pitstops
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.laptimes l WHERE l.stop is null) THEN

        update f1_olap.laptimes
        SET raceId               = NEW.raceId,
            driverId             = NEW.driverId,
            stop                 = NEW.stop,
            time_pitstop         = NEW.time,
            duration             = NEW.duration,
            milliseconds_pitstop = NEW.milliseconds
        WHERE raceId = NEW.raceId
          AND driverId = NEW.driverId
          AND lap = NEW.lap;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no


    ELSE

        insert into f1_olap.laptimes (raceId, driverId, stop, time_pitstop, duration, milliseconds_pitstop, lap)
        select NEW.raceId,
               NEW.driverId,
               NEW.stop,
               NEW.time,
               NEW.duration,
               NEW.milliseconds,
               NEW.lap;

    END IF;

end;
DELIMITER ;





#--------------------------Events----------------------------------------------------------

USE f1_olap;
SET GLOBAL event_scheduler = ON;
#-------------------------------------------------
DELIMITER $$
DROP EVENT IF EXISTS insertion_event;
CREATE EVENT insertion_event
    ON SCHEDULE EVERY 1 DAY STARTS '2020-07-05 23:59:00'
    DO
    BEGIN
        CREATE TABLE IF NOT EXISTS log
        (
            id                int AUTO_INCREMENT,
            fecha             DATETIME,
            importation_error BOOL,
            PRIMARY KEY (id)
        );

        CALL compare_circuit();
        CALL compare_constructor();
        CALL compare_driver();
        CALL compare_laptimes();
        CALL compare_results();

    END $$

DELIMITER ;