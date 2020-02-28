#&&0
USE movies;

#&&1
SELECT p.name
FROM producer AS p,
     language_movie AS lm,
     movie AS m,
     producer_movie AS pm
WHERE pm.id_movie = m.id_movie
  AND p.id_producer = pm.id_producer
  AND lm.id_movie = m.id_movie
GROUP BY p.name
HAVING COUNT(lm.id_movie) >
       (SELECT AVG((SELECT COUNT(lm2.id_movie)
                      FROM movie AS m2,
                           language_movie AS lm2
                      WHERE m2.id_movie = lm2.id_movie
                        AND m2.country = m.country
                        AND m2.id_movie = m.id_movie
                      GROUP BY m2.title
                      ORDER BY COUNT(lm2.id_movie)
                          DESC)) AS mediana
        FROM movie AS m,
             language_movie AS lm3
       WHERE m.id_movie =lm3.id_movie
        GROUP BY m.country
        ORDER BY AVG((SELECT COUNT(lm2.id_movie)
                      FROM movie AS m2,
                           language_movie AS lm2
                      WHERE m2.id_movie = lm2.id_movie
                        AND m2.country = m.country
                        AND m2.id_movie = m.id_movie
                      GROUP BY m2.title
                      ORDER BY COUNT(lm2.id_movie)
                          DESC))
            DESC
        LIMIT 1)
ORDER BY p.name;






#&&2
SELECT m.title, m.imdb_score
FROM movie AS m
WHERE m.gross > '60000000'
  AND m.id_movie NOT IN (SELECT m2.id_movie
                         FROM actor AS a2,
                              person AS p2,
                              movie AS m2,
                              actor_movie AS am2
                         WHERE a2.id_actor = p2.id_person
                           AND m2.id_movie = am2.id_movie
                           AND am2.id_actor = a2.id_actor
                           AND p2.name not like 'A%'
                         GROUP BY a2.id_actor)
GROUP BY m.title, m.imdb_score
ORDER BY m.imdb_score
    DESC;







#&&3

#&&4

#&&5