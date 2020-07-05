use f1;

#--------------------- Queries ---------------------
SELECT s.status
FROM status s
         LEFT JOIN results r on s.statusId = r.statusId
WHERE r.statusId IS NULL
GROUP BY s.statusId;



#Belgian 21.962
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


#Lewis Hamilton, Valtteri Bottas
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

#16 rows Romain Grosjean, Sergio Pérez, Daniel Ricciardo, Max Chilton...
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

#Oswald Karch, 34 positions
SELECT d.forename, d.surname, c.name, c.year, (r.grid - r.position) overtaking
FROM drivers d
         JOIN results r on d.driverId = r.driverId
         JOIN circuits c on r.raceId = c.raceId
WHERE (r.grid - r.position) > ALL
      (SELECT r2.grid - r2.position
       FROM f1_olap.results AS r2
       WHERE r.driverId <> r2.driverId);

#--------------------- OLAP Vs OLTP ---------------------
#Simple query involving one row
SELECT d.forename, d.surname
FROM f1.drivers d
WHERE d.nationality = 'Spanish';

SELECT d.forename, d.surname
FROM f1_olap.drivers d
WHERE d.nationality = 'Spanish';

# A complex query which involves at least 5 tables. Show the name of the spanish pilot participated in spanish GP ON 2008
SELECT d.forename forename, r.grid grid, r.position position, ra.url urlRace, c.name
FROM f1.drivers d
         JOIN f1.results r ON r.driverId = d.driverId
         JOIN f1.races ra ON ra.raceId = r.raceId
         JOIN f1.circuits c ON c.circuitId = ra.circuitId
         JOIN f1.seasons s ON ra.year = s.year
WHERE d.nationality = 'Spanish'
  AND c.country = 'Spain'
  AND s.year = 2008;

SELECT d.forename, r.grid, r.position, c.url, c.name
FROM f1_olap.drivers d
         JOIN f1_olap.results r on d.driverId = r.driverId
         JOIN f1_olap.circuits c on r.raceId = c.raceId
WHERE d.nationality = 'Spanish'
  AND c.country = 'Spain'
  AND c.year = 2008;


# An insert into 1 table.
INSERT INTO f1.laptimes(raceId, driverId, lap, position, time, milliseconds)
VALUES (19, 1, 155, 9, '1:52.039', 112039);

INSERT INTO f1_olap.laptimes(raceId, driverId, lap, position, time, milliseconds)
VALUES (19, 1, 155, 9, '1:52.039', 112039);

# An update into 1 field.
UPDATE f1.laptimes
SET milliseconds = 1
WHERE milliseconds = 112039
  AND raceId = 19
  AND driverId = 1
  AND lap = 155;

UPDATE f1_olap.laptimes
SET milliseconds = 1
WHERE milliseconds = 112039
  AND raceId = 19
  AND driverId = 1
  AND lap = 155;


# A delete into 1 table
DELETE
FROM f1.laptimes
WHERE milliseconds = 1
  AND raceId = 19
  AND driverId = 1
  AND lap = 155;

DELETE
FROM f1_olap.laptimes
WHERE milliseconds = 1
  AND raceId = 19
  AND driverId = 1
  AND lap = 155;