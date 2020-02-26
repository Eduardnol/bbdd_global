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
                        DESC))
        FROM movie AS m
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
        LIMIT 1);







#&&2

#&&3

#&&4

#&&5