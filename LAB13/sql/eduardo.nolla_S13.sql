#&&0
USE movies;


#&&1
SELECT id_person, name, facebook_likes
FROM person AS p,
     actor_movie AS am,
     movie AS m
WHERE am.id_actor = p.id_person
  AND am.id_movie = m.id_movie
  AND m.country = 'Japan'
  AND m.year = '2019'
GROUP BY id_person, name, facebook_likes
HAVING COUNT(m.id_movie) <= ALL (SELECT COUNT(m2.id_movie)
                                FROM actor_movie AS am2,
                                     movie AS m2,
                                     person AS p2
                                WHERE am2.id_actor <> p.id_person
                                  AND am2.id_movie = m2.id_movie
                                  AND am2.id_actor = p2.id_person
                                GROUP BY am2.id_actor)
ORDER BY facebook_likes
    DESC
LIMIT 1;


#&&2
SELECT a.id_actor, p.name
FROM person AS p,
     actor AS a,
     movie AS m,
     actor_movie AS am
WHERE p.id_person = a.id_actor
  AND a.id_actor = am.id_actor
  AND m.id_movie = am.id_movie
  AND a.id_actor NOT IN (SELECT a.id_actor
                         FROM person AS p,
                              actor AS a,
                              actor_movie AS am
                         WHERE a.id_actor = p.id_person
                           AND am.id_actor = a.id_actor
                         GROUP BY a.id_actor, p.name
                         HAVING COUNT(am.id_actor) < 5)

GROUP BY a.id_actor, p.name
HAVING AVG(m.imdb_score) > ALL
       (SELECT AVG(m2.imdb_score)
        FROM actor AS a2,
             movie AS m2,
             actor_movie AS am2,
             person AS p2
        WHERE a2.id_actor <> a.id_actor
          AND p2.id_person = a2.id_actor
          AND a2.id_actor = am2.id_actor
          AND m2.id_movie = am2.id_movie
          AND a2.id_actor NOT IN (SELECT a.id_actor
                                  FROM person AS p,
                                       actor AS a,
                                       actor_movie AS am
                                  WHERE a.id_actor = p.id_person
                                    AND am.id_actor = a.id_actor
                                  GROUP BY a.id_actor, p.name
                                  HAVING COUNT(am.id_actor) < 5)

        GROUP BY a2.id_actor);


#&&3
SELECT p.name, SUM(m.movie_facebook_likes) AS 'sum_likes'
FROM person AS p,
     director AS d,
     movie AS m
WHERE p.id_person = d.id_director
  AND d.id_director = m.id_director
  AND m.year
    #Seleccionamos todas las peliculas que haya hecho el director en concreto y restaremos todas
    #las peliculas nuevas que haya producido, comparando que no quede ninguna más antigua al 2019
    NOT IN (SELECT m.year
            FROM movie AS m2
            WHERE d.id_director = m2.id_director
              AND m2.year < '2019')

#suma de la popularitat de les seves pelicules
GROUP BY p.name
ORDER BY SUM(m.movie_facebook_likes)
    DESC
LIMIT 1;


#&&4
SELECT a.id_actor, p.name, p.facebook_likes
FROM actor AS a,
     person AS p,
     movie AS m,
     actor_movie AS am
WHERE m.country = 'UK'
  AND a.id_actor NOT IN (SELECT a2.id_actor
                         FROM movie AS m2,
                              actor_movie AS am2,
                              actor AS a2
                         WHERE m2.country <> 'USA'
                           AND m2.country <> 'UK'
                           AND am2.id_movie = m2.id_movie
                           AND am2.id_actor = a.id_actor)
  AND m.id_movie = am.id_movie
  AND a.id_actor = am.id_actor
  AND a.id_actor = p.id_person
  AND a.id_actor IN (SELECT a3.id_actor
                     FROM actor AS a3,
                          person AS p3,
                          movie AS m3,
                          actor_movie AS am3
                     WHERE m3.country = 'USA'
                       AND m3.id_movie = am3.id_movie
                       AND a3.id_actor = am3.id_actor
                       AND a3.id_actor = p3.id_person
                     GROUP BY a3.id_actor
                     HAVING COUNT(m3.country = 'USA') > 1)
GROUP BY a.id_actor, p.name, p.facebook_likes
HAVING COUNT(m.country = 'UK') > 1
ORDER BY p.facebook_likes
    DESC
LIMIT 3;


#&&5
SELECT p.name, COUNT(DISTINCT m.country) AS 'sum_participations'
FROM person AS p,
     movie AS m,
     actor AS a,
     actor_movie AS am
WHERE p.id_person = a.id_actor
  AND a.id_actor = am.id_actor
  AND am.id_movie = m.id_movie
  AND p.id_person IN
      (SELECT m2.id_director
       FROM movie AS m2,
            person AS p2
       WHERE p2.id_person = m2.id_director
      )
  AND p.name LIKE '%d%'
GROUP BY p.name
ORDER BY sum_participations
    DESC
LIMIT 6;