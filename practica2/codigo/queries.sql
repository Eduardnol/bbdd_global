use f1;

SELECT s.status
FROM status s
         LEFT JOIN results r on s.statusId = r.statusId
WHERE r.statusId IS NULL
GROUP BY s.statusId;


# Jaguar || Australian 22.49
SELECT d.nationality, AVG(p.duration) average
FROM pitstops p
         JOIN drivers d on p.driverId = d.driverId
         JOIN qualifying q on d.driverId = q.driverId
         JOIN constructors c on q.constructorId = c.constructorId
GROUP BY c.constructorId
HAVING average < ALL (SELECT AVG(p2.duration)
                      FROM pitstops p2
                               JOIN drivers d2 on p2.driverId = d2.driverId
                               JOIN qualifying q2 on d2.driverId = q2.driverId
                               JOIN constructors c2 on q2.constructorId = c2.constructorId
                      WHERE c2.constructorId <> c.constructorId
                      GROUP BY c2.constructorId);

#
SELECT d.nationality, AVG(p.duration) average
FROM drivers d
         JOIN laptimes p on d.driverId = p.driverId
         JOIN results r on p.raceId = r.raceId
GROUP BY r.constructorId, d.driverId
HAVING average < ALL (SELECT AVG(p2.duration)
                      FROM drivers d2
                               JOIN laptimes p2 ON d2.driverId = p2.driverId
                               JOIN results r2 ON p2.raceId = r2.raceId
                      WHERE d2.driverId <> d.driverId
                      GROUP BY d2.driverId, r2.constructorId);



SELECT d.forename, d.surname
FROM drivers d
         JOIN results r on d.driverId = r.driverId
WHERE r.q1 > r.q2 > r.q3
  AND r.fastestLapTime < ANY (SELECT r2.q1
                              FROM f1_olap.results r2
                              WHERE r2.driverId <> r.driverId
                                AND r2.raceId = r.raceId)
  AND r.fastestLapTime < ANY (SELECT r2.q2
                              FROM f1_olap.results r2
                              WHERE r2.driverId <> r.driverId
                                AND r2.raceId = r.raceId)
  AND r.fastestLapTime < ANY (SELECT r2.q3
                              FROM f1_olap.results r2
                              WHERE r2.driverId <> r.driverId
                                AND r2.raceId = r.raceId)

  AND (r.position = 1 OR r.position = 2 OR r.position = 3);


SELECT d.forename, d.surname, r.fastestLapSpeed, l.time, c.name
FROM drivers d
         JOIN results r on d.driverId = r.driverId
         JOIN circuits c on r.raceId = c.raceId
         JOIN laptimes l on d.driverId = l.driverId AND l.raceId = r.raceId
WHERE r.fastestLapTime
    AND (r.fastestLapTime < ALL (SELECT r2.fastestLapTime
                                 FROM results r2
                                          JOIN laptimes l2 on r2.driverId = l2.driverId AND l2.raceId = r2.raceId
                                 WHERE r2.raceId = r.raceId
                                   AND r2.driverId <> r.driverId)
        AND r.fastestLapSpeed < ANY (SELECT r2.fastestLapSpeed
                                     FROM results r2
                                              JOIN laptimes l2 on r2.driverId = l2.driverId AND l2.raceId = r2.raceId
                                     WHERE r2.raceId = r.raceId
                                       AND r2.driverId <> r.driverId))
   OR (r.fastestLapTime > ALL (SELECT r2.fastestLapTime
                               FROM results r2
                                        JOIN laptimes l2 on r2.driverId = l2.driverId AND l2.raceId = r2.raceId
                               WHERE r2.raceId = r.raceId
                                 AND r2.driverId <> r.driverId)
    AND r.fastestLapSpeed > ANY (SELECT r2.fastestLapSpeed
                                 FROM results r2
                                          JOIN laptimes l2 on r2.driverId = l2.driverId AND l2.raceId = r2.raceId
                                 WHERE r2.raceId = r.raceId
                                   AND r2.driverId <> r.driverId));

SELECT d.forename, d.surname, c.name, c.year, (r.grid - r.position) overtaking
FROM drivers d
         JOIN results r on d.driverId = r.driverId
         JOIN circuits c on r.raceId = c.raceId
WHERE (r.grid - r.position) > ALL
      (SELECT r2.grid - r2.position
       FROM f1_olap.results AS r2
       WHERE r.driverId <> r2.driverId)


#Simple query involving one row
SELECT d.forename, d.surname
FROM f1.drivers d
WHERE d.nationality = 'Spanish';

SELECT d.forename, d.surname
FROM f1_olap.drivers d
WHERE d.nationality = 'Spanish';

# A complex query which involves at least 5 tables.


# An insert into 1 table.

# An update into 1 field.
# A delete into 1 table


DELIMITER $$
DROP TRIGGER IF EXISTS f1.update_database_users;
CREATE TRIGGER f1.update_database

    AFTER UPDATE
    ON f1.drivers
    FOR EACH ROW
BEGIN
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
END;
&&
DELIMITER ;


DELIMITER $$
DROP TRIGGER IF EXISTS f1.update_database_constructors;
CREATE TRIGGER f1.update_database_constructors

    AFTER UPDATE
    ON f1.constructors
    FOR EACH ROW
BEGIN
    insert into f1_olap.constructors
    SELECT c.constructorId,
           c.constructorRef,
           c.name,
           c.nationality,
           c.url
    FROM f1.constructors AS c;
END;
&&
DELIMITER ;



