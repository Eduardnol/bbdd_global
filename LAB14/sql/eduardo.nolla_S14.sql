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
  AND (SELECT AVG((SELECT COUNT(lm2.id_movie)
                       FROM movie AS m2,
                            language_movie AS lm2
                       WHERE m2.id_movie = lm2.id_movie
                         AND m2.country = m.country
                         AND m2.id_movie = m.id_movie
                       GROUP BY m2.title
                       ORDER BY COUNT(lm2.id_movie)
                           DESC)) - 1 AS mediana
       FROM movie AS m,
            language_movie AS lm3
       WHERE m.id_movie = lm3.id_movie
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
 <= ALL
      (SELECT COUNT(lm2.id_language)
       FROM movie AS m2,
            producer_movie AS pm2,
            language_movie AS lm2
       WHERE m2.id_movie = pm2.id_movie
         AND pm2.id_producer = p.id_producer #p.id_producer
         AND lm2.id_movie = m2.id_movie
       GROUP BY pm2.id_producer, m2.id_movie)
GROUP BY p.name
ORDER BY p.name
LIMIT  5;

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
#No se resoldre aquesta querie
SELECT p.name
FROM person AS p,
     actor AS a,
     movie AS m,
     actor_movie AS am,
     genre_movie AS gm
WHERE p.id_person = a.id_actor
  AND am.id_actor = a.id_actor
  AND am.id_movie = m.id_movie
  AND gm.id_movie = m.id_movie
  AND 15 <= ALL (SELECT COUNT(gm2.id_movie)
                 FROM genre_movie AS gm2,
                      movie AS m2,
                      actor_movie AS am2
                 WHERE gm2.id_movie = m2.id_movie
                   AND am2.id_movie = m2.id_movie
                   AND am2.id_actor = a.id_actor
                 GROUP BY gm2.id_genre
)
  AND a.id_actor IN
      (SELECT a3.id_actor
       FROM actor AS a3,
            actor_movie AS am3
       WHERE a3.id_actor = am3.id_actor
       GROUP BY am3.id_movie
       HAVING COUNT(am3.id_movie) >= 3)
GROUP BY p.name
ORDER BY p.name;

#&&4
SELECT p.name AS name
FROM person AS p,
     director AS d,
     movie AS m,
     actor_movie AS am
WHERE p.id_person = d.id_director
  AND d.id_director = m.id_director
  AND am.id_movie = m.id_movie
  AND 50000000 < ALL (SELECT m2.gross
                      FROM movie AS m2
                      WHERE m2.id_director = d.id_director
                      GROUP BY m2.id_movie)
  AND 10 <= ALL (SELECT COUNT(am2.id_movie)
                 FROM movie AS m2,
                      actor_movie AS am2
                 WHERE m2.id_movie = am2.id_movie
                   AND m2.id_director = d.id_director
                 GROUP BY am2.id_movie)
GROUP BY d.id_director, p.name
ORDER BY p.name;

#&&5
SELECT p.name AS name, pr.name AS name, COUNT(p.name) AS num
FROM person AS p,
     producer AS pr,
     director AS d,
     movie AS m,
     producer_movie AS pm
WHERE p.id_person = d.id_director
  AND d.id_director = m.id_director
  AND pm.id_movie = m.id_movie
  AND pm.id_producer = pr.id_producer
GROUP BY p.name, pr.name
HAVING COUNT(p.name) >= 20
ORDER BY COUNT(p.name) DESC, p.name;











