# DELIMITER $$
# DROP PROCEDURE IF EXISTS backup $$
#
# CREATE PROCEDURE backup()
# BEGIN
#
#     #Variable loop control
#     DECLARE done INT DEFAULT 0;
#     DECLARE nom_taula VARCHAR(25);
#
#     #Declare the cursor
#     DECLARE cur CURSOR FOR SELECT table_name
#                            FROM information_schema.tables
#                            WHERE TABLE_SCHEMA = "f1"
#                              AND table_type = "base table";
#
#     #Handler declaration
#     DECLARE CONTINUE handler for NOT FOUND SET done = 1;
#
#     OPEN cur;
#
#     bucle:
#     LOOP
#         FETCH cur INTO nom_taula;
#         IF done = 1 THEN
#             LEAVE bucle;
#         end if;
#
#
#         SET @aux = CONCAT("INSERT INTO DRIVER")
#
#
#     end loop;
#
#
# end $$


insert into f1_olap.constructors
SELECT c.constructorId,
       c.constructorRef,
       c.name,
       c.nationality,
       c.url
FROM f1.constructors AS c;



insert into f1_olap.circuits
select r.raceId,
       c.circuitId,
       c.circuitRef,
       c.name,
       c.location,
       c.country,
       c.lat,
       c.lng,
       c.alt,
       c.url,
       r.year,
       r.round,
       r.name,
       r.date,
       r.time,
       r.url,
       s.url
from f1.circuits c
         JOIN f1.races r ON c.circuitId = r.circuitId
         JOIN f1.seasons s ON r.year = s.year;


insert into f1_olap.drivers
SELECT d.driverId,
       d.driverRef,
       d.number,
       d.code,
       d.forename,
       d.surname,
       d.dob,
       d.nationality,
       d.url
FROM f1.drivers d;



insert into f1_olap.laptimes
select l.raceId,
       l.driverId,
       l.lap,
       l.position,
       l.time,
       l.milliseconds,
       p.stop,
       p.time,
       p.duration,
       p.milliseconds
from f1.laptimes l
         JOIN f1.pitstops p ON l.driverId = p.driverId AND l.raceId = p.raceId AND l.lap = p.lap;



insert into f1_olap.results
select r.resultId,


       r.raceId,
       r.driverId,
       r.constructorId,
       r.number,
       r.grid,
       r.position,
       r.positionText,
       r.positionOrder,
       r.points,
       r.laps,
       r.time,
       r.milliseconds,
       r.fastestLap,
       r.`rank`,
       r.fastestLapTime,
       r.fastestLapSpeed,


       s.status,


       q.position,
       q.q1,
       q.q2,
       q.q3,


       cr.points,
       cr.status,


       ds.points,
       ds.position,
       ds.positionText,
       ds.wins,


       cs.points,
       cs.position,
       cs.positionText,
       cs.wins
from f1.results r
         LEFT JOIN f1.status s
                   ON r.statusId = s.statusId
         LEFT JOIN f1.qualifying q
                   ON q.driverId = r.driverId
                       AND q.raceId = r.raceId
                       AND q.constructorId = r.constructorId
         LEFT JOIN f1.constructorresults cr
                   ON cr.raceId = r.raceId
                       AND cr.constructorId = r.constructorId
         LEFT JOIN f1.constructorstandings cs
                   ON cs.raceId = r.raceId
                       AND cs.constructorId = r.constructorId
         LEFT JOIN f1.driverstandings ds
                   ON ds.raceId = r.raceId
                       AND ds.driverId = r.driverId
GROUP BY resultId, q.raceId, q.driverId, q.constructorId;






