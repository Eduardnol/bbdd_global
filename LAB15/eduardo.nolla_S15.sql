#&&0
USE movies;


#&&1
SELECT m.title, p.name, m.imdb_score, g.description
FROM genre_movie AS gm
         JOIN genre AS g ON gm.id_genre = g.id_genre
         JOIN movie AS m2 ON gm.id_movie = m2.id_movie,
     person AS p
         JOIN director AS d ON p.id_person = d.id_director
         JOIN movie AS m ON d.id_director = m.id_director
         JOIN producer_movie AS pm ON m.id_movie = pm.id_movie
         JOIN producer AS pro ON pm.id_producer = pro.id_producer
WHERE g.description = 'Action'
  AND pro.country = 'Thailand'
  AND m.id_director = d.id_director
GROUP BY m.id_movie
HAVING COUNT(DISTINCT pro.id_producer) = (SELECT COUNT(DISTINCT pro2.id_producer)
                                          FROM producer AS pro2
                                          WHERE pro2.country = 'Thailand');

#&&2
SELECT p.name,
       (SELECT COUNT(DISTINCT m.year)
        FROM movie AS m
                 JOIN actor_movie AS am ON m.id_movie = am.id_movie
                 JOIN actor AS a ON am.id_actor = a.id_actor
        WHERE a.id_actor = p.id_person) AS active_years

FROM person AS p
         JOIN actor AS a2 ON p.id_person = a2.id_actor
GROUP BY p.id_person, p.facebook_likes
HAVING (SELECT COUNT(DISTINCT m.year)
        FROM movie AS m
                 JOIN actor_movie AS am ON m.id_movie = am.id_movie
                 JOIN actor AS a ON am.id_actor = a.id_actor
        WHERE a.id_actor = p.id_person) >= (SELECT COUNT(DISTINCT m2.year)
                                            FROM movie AS m2) / 2
ORDER BY active_years DESC, p.facebook_likes DESC;

#&&3
SELECT p.name AS director, p2.name AS actor, COUNT(DISTINCT m.id_movie) AS same
FROM person AS p2
         JOIN actor AS a ON p2.id_person = a.id_actor
         JOIN actor_movie AS am ON a.id_actor = am.id_actor
         JOIN movie m ON am.id_movie = m.id_movie
         JOIN director AS d ON m.id_director = d.id_director
         JOIN person AS p ON d.id_director = p.id_person
GROUP BY d.id_director, a.id_actor, p.name, p2.name
HAVING COUNT(d.id_director) > 7
ORDER BY same DESC, p.name ASC
LIMIT 10;

#&&4
SELECT m.title, a.id_actor, pro.name AS producer, m.country AS country
FROM movie AS m
         LEFT JOIN actor_movie am ON m.id_movie = am.id_movie
         LEFT JOIN actor AS a ON am.id_actor = a.id_actor
         JOIN producer_movie AS pm ON pm.id_movie = m.id_movie
         JOIN producer AS pro ON pm.id_producer = pro.id_producer
WHERE am.id_movie IS NULL
GROUP BY m.id_movie, m.title
ORDER BY m.title DESC
LIMIT 5;

# #&&4
# SELECT m.title, a.id_actor, pro.name, m.country AS country
# FROM movie AS m
#          LEFT JOIN actor_movie am ON m.id_movie = am.id_movie
#          LEFT JOIN actor AS a ON am.id_actor = a.id_actor,
#      producer AS pro
#          JOIN producer_movie pm ON pro.id_producer = pm.id_producer
#          JOIN movie m2 ON pm.id_movie = m2.id_movie
#
# WHERE am.id_movie IS NULL AND m.id_movie = m2.id_movie
# GROUP BY m.id_movie, m.title
# ORDER BY m.title DESC
# LIMIT 5;

#&&5
(SELECT a.id_actor, d.id_director, p.name, p.facebook_likes
 FROM actor AS a
          JOIN person AS p ON a.id_actor = p.id_person
          JOIN actor_movie AS am ON a.id_actor = am.id_actor
          JOIN movie AS m ON am.id_movie = m.id_movie
          JOIN genre_movie AS gm ON m.id_movie = gm.id_movie
          LEFT JOIN director AS d ON p.id_person = d.id_director
 WHERE p.facebook_likes < (SELECT AVG(p.facebook_likes)
                           FROM person AS p
                                    JOIN actor a2 on p.id_person = a2.id_actor)
 GROUP BY a.id_actor, p.facebook_likes
 HAVING COUNT(DISTINCT gm.id_genre) > 17
)
UNION
(SELECT a.id_actor, d.id_director, p.name, p.facebook_likes
 FROM director AS d
          JOIN person AS p ON d.id_director = p.id_person
          JOIN movie AS m ON d.id_director = m.id_director
          JOIN genre_movie AS gm ON m.id_movie = gm.id_movie
          LEFT JOIN actor a on p.id_person = a.id_actor
 WHERE p.facebook_likes < (SELECT AVG(p2.facebook_likes)
                           FROM person AS p2
                                    JOIN director d2 on p2.id_person = d2.id_director)
 GROUP BY d.id_director, p.facebook_likes
 HAVING COUNT(DISTINCT gm.id_genre) > 15
 )
 ORDER BY facebook_likes DESC
