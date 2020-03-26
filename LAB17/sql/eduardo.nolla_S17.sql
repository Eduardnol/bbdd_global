#&&0
USE movies;


#&&1
CREATE USER 'admin';
GRANT SELECT (id_movie, imdb_score, gross, budget, title, year, country, id_director, movie_facebook_likes) ON movie TO admin;
GRANT SELECT (name, id_person, facebook_likes) ON person TO admin;
GRANT SELECT (id_director) ON director TO admin;
GRANT SELECT (id_movie) ON producer_movie TO admin;
GRANT SELECT (id_movie, id_actor) ON actor_movie TO admin;
GRANT SELECT (id_actor) ON actor TO admin;

#&&2
CREATE OR REPLACE VIEW director_data AS
SELECT d.id_director,
       p.name,
       SUM(m.imdb_score) AS 'sum(imdb_score)',
       SUM(m.gross)      AS gross,
       SUM(m.budget)     AS budget
FROM movie m
         JOIN director d on m.id_director = d.id_director
         JOIN person p on d.id_director = p.id_person
GROUP BY m.id_director;


#&&3
CREATE OR REPLACE VIEW worst_movies AS
SELECT m.title, m.year, m.country, m.imdb_score, COUNT(pm.id_movie) AS Num_producers
FROM movie m
         JOIN producer_movie pm on m.id_movie = pm.id_movie
WHERE m.imdb_score <= ALL (SELECT m2.imdb_score
                           FROM movie AS m2)
GROUP BY m.id_movie;


#&&4
CREATE OR REPLACE VIEW actor_data AS
SELECT p.id_person,
       p.name            name,
       AVG(m.imdb_score) av_imsb_score,
       AVG(m.gross)      avg_gross,
       AVG(m.budget)     avg_budget
FROM movie m
         JOIN actor_movie am on m.id_movie = am.id_movie
         JOIN actor a on am.id_actor = a.id_actor
         JOIN person p on a.id_actor = p.id_person
WHERE m.movie_facebook_likes < p.facebook_likes
GROUP BY p.id_person, p.name;



#&&5
CREATE USER 'guest';
GRANT SELECT ON TABLE director_data TO guest;
GRANT SELECT ON TABLE worst_movies TO guest;
GRANT SELECT ON TABLE actor_data TO guest;




