#&&0
USE movies;

#&&1
SELECT p.name, COUNT(DISTINCT am.id_actor) AS Total_Actors
FROM person AS p
         JOIN director d on p.id_person = d.id_director
         JOIN movie m on d.id_director = m.id_director
         JOIN actor_movie am on m.id_movie = am.id_movie
GROUP BY d.id_director
ORDER BY (SELECT SUM(m2.budget)
          FROM movie AS m2
          WHERE m.id_director = m2.id_director
          GROUP BY m2.id_director)
    DESC
LIMIT 5;


#&&2
SELECT m.title AS Title, m.duration AS Duration
FROM movie m
         join genre_movie gm on m.id_movie = gm.id_movie
GROUP BY m.title, m.duration
HAVING COUNT(gm.id_movie) = 1
ORDER BY m.duration DESC
LIMIT 1;


#&&3
SELECT p.name                    AS directorName,
       (SELECT COUNT(m.id_director)
        FROM movie AS m
                 JOIN director d2 on m.id_director = d2.id_director
        WHERE d2.id_director = d.id_director
        GROUP BY d2.id_director) AS countMovie,
       (SELECT AVG(m.imdb_score)
        FROM movie AS m
                 JOIN director d3 on m.id_director = d3.id_director
        WHERE d3.id_director = d.id_director
        GROUP BY d3.id_director) AS avgIMDB
FROM person p
         JOIN director d on p.id_person = d.id_director
         JOIN movie m on d.id_director = m.id_director
         JOIN actor_movie am on m.id_movie = am.id_movie
WHERE d.id_director IN (SELECT d.id_director
                        FROM director d
                                 JOIN movie m2 on d.id_director = m2.id_director
                        GROUP BY d.id_director
                        HAVING COUNT(m2.id_director) >= 15)
  AND (SELECT AVG(m.imdb_score)
       FROM movie m2
                JOIN director d4 on m2.id_director = d4.id_director
       WHERE m.id_director = m2.id_director
       GROUP BY m2.id_director) > 7
GROUP BY d.id_director
ORDER BY countMovie DESC, avgIMDB DESC;


#&&4
SELECT m.year,
       g.description               AS description,
       COUNT(DISTINCT m.id_movie)  as numMovie,
       g2.description,
       COUNT(DISTINCT m2.id_movie) as numMovie
FROM movie m
         JOIN genre_movie gm on m.id_movie = gm.id_movie
         JOIN genre g on gm.id_genre = g.id_genre,
     movie m2
         JOIN genre_movie gm2 on m2.id_movie = gm2.id_movie
         JOIN genre g2 on gm2.id_genre = g2.id_genre
WHERE g.description = 'Drama'
  AND g2.description = 'Comedy'
  AND m2.year = m.year
  AND m.year >= 1986
  AND m.year <= 2013
GROUP BY m.year, g.description, g2.description
HAVING COUNT(DISTINCT m.id_movie) < COUNT(DISTINCT m2.id_movie)
ORDER BY m.year;


#&&5
SELECT p.name                   AS name,

       (SELECT COUNT(am2.id_actor)
        FROM movie m2
                 JOIN actor_movie am2 ON m2.id_movie = am2.id_movie
                 JOIN actor a2 on am2.id_actor = a2.id_actor
        WHERE a2.id_actor = p.id_person
        GROUP BY a2.id_actor)   AS movie_actor,

       (SELECT COUNT(m2.id_director)
        FROM movie m2
                 JOIN director d on m2.id_director = d.id_director
        WHERE m2.id_director = p.id_person
        GROUP BY d.id_director) AS movie_director

FROM person AS p
         JOIN director d on p.id_person = d.id_director
         JOIN movie m on d.id_director = m.id_director
         JOIN actor_movie am on m.id_movie = am.id_movie
         JOIN actor a on am.id_actor = a.id_actor

GROUP BY p.id_person
HAVING movie_actor > movie_director
ORDER BY movie_director DESC, movie_actor DESC
LIMIT 5;


