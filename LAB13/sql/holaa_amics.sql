#&&2
#&&2
SELECT a.id_actor, p.name
FROM Actor AS a,
     Person AS p,
     Movie AS m,
     Actor_Movie AS am
WHERE p.id_person = a.id_actor
  AND a.id_actor = am.id_actor
  AND m.id_movie = am.id_movie

GROUP BY p.id_person, m.imdb_score
HAVING AVG(m.imdb_score) >
           ALL (SELECT AVG(m2.imdb_score)
                FROM Movie AS m2,
                     Person AS p2,
                     actor_movie AS am2,
                     actor AS a2
                WHERE p.id_person <> p2.id_person
                  AND m2.id_movie = am2.id_movie
                  AND am2.id_actor = a2.id_actor
                  AND a2.id_actor = p2.id_person
                  AND a.id_actor
                    IN (SELECT a3.id_actor
                        FROM Movie AS m3,
                             Actor AS a3,
                             Actor_Movie AS am3
                        WHERE m3.id_movie = am3.id_movie
                          AND a3.id_actor = am3.id_actor
                        GROUP BY a3.id_actor
                        HAVING COUNT(m3.id_movie) > 5)
                GROUP BY p2.id_person)
ORDER BY m.imdb_score DESC
LIMIT 20;















