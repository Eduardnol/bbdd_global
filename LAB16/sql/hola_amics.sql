USE movies;

SELECT p.name, COUNT(DISTINCT am.id_actor) AS Total_Actors
FROM person AS p
         JOIN director d on p.id_person = d.id_director
         JOIN movie m on d.id_director = m.id_director
         JOIN actor_movie am on m.id_movie = am.id_movie
GROUP BY d.id_director
ORDER BY (SELECT SUM(m2.budget)
          FROM movie m2
          WHERE m2.id_director = d.id_director
          GROUP BY m2.id_director)
    DESC
LIMIT 5;
