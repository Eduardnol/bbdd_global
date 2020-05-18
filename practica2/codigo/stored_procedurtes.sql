use f1;


#DRIVERS
DELIMITER $$
drop trigger if exists insert_drivers;
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
drop trigger if exists insert_constructors;
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
drop trigger if exists insert_circuits;
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
drop trigger if exists insert_race;
create trigger insert_race
    after insert
    on f1.races
    for each row
begin

    IF EXISTS(SELECT * FROM f1_olap.circuits c WHERE c.raceId = 0) THEN

        update f1_olap.circuits
        SET raceID    = NEW.raceId,
            year      = NEW.year,
            round     = NEW.round,
            name_race = NEW.name,
            date      = NEW.date,
            time      = NEW.time,
            url_race  = NEW.url

        WHERE f1_olap.circuits.circuitId = NEW.circuitId
          AND f1_olap.circuits.year = NEW.year;


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
drop trigger if exists insert_seasons;
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
drop trigger if exists insert_constructorResults;
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
                                     points_constructor, status_constructor)
        select NEW.raceId,
               NEW.constructorId,
               NEW.points,
               NEW.status;

    END IF;

end;
DELIMITER ;

#CONSTRUCTOR STANDINGS

#DRIVER STANDINGS

#STATUS

#QUALIFYING


#RESULTS


#-------------------------------------------------------------------

#LAPTIME
DELIMITER $$
drop trigger if exists insert_laptime;
create trigger insert_laptime
    after insert
    on f1.laptimes
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.laptimes l WHERE l.TIME != 0) THEN

        update f1_olap.laptimes
        SET raceId       = NEW.raceId,
            driverId     = NEW.driverId,
            lap          = NEW.lap,
            position     = NEW.position,
            time         = NEW.time,
            milliseconds = NEW.milliseconds
        WHERE raceId = NEW.raceId
          AND driverId = NEW.driverId;

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
drop trigger if exists insert_pitstop;
create trigger insert_pitstop
    after insert
    on f1.pitstops
    for each row
begin

    #If the circuit is in the database we are going to update the other fields
    IF EXISTS(SELECT * FROM f1_olap.laptimes l WHERE l.TIME != null) THEN

        update f1_olap.laptimes
        SET raceId = NEW.raceId,
            driverId = NEW.driverId,
            stop = NEW.stop,
            time = NEW.time,
            duration = NEW.duration,
            milliseconds = NEW.milliseconds
        WHERE raceId = NEW.raceId
          AND driverId = NEW.driverId;

        #TODO gestionar las relaciones si uno se ha inserido pero el otro no


    ELSE

        insert into f1_olap.laptimes (raceId, driverId, stop, time_pitstop, duration, milliseconds_pitstop)
        select NEW.raceId,
               NEW.driverId,
               NEW.stop,
               NEW.time,
               NEW.duration,
               NEW.milliseconds;

    END IF;

end;
DELIMITER ;