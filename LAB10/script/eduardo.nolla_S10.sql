

/**************************************

             QUERY 1

 **************************************/
 --#&&
SELECT id_usuari AS user_id FROM Usuari AS u, ocupacio AS o
WHERE o.id_ocupacio = u.id_ocupacio
AND o.nom_ocupacio = 'programmer'
AND u.codi_postal = '94114'
ORDER BY user_id ASC;

/**************************************

             QUERY 2

 **************************************/
 --#&&
SELECT p.titol AS title, AVG(up.estrelles) AS avg_grade
FROM pelicula AS p, usuari_pelicula AS up, genere AS g, pelicula_genere AS pg
WHERE g.nom_genere = 'Western' AND g.id_genere = pg.id_genere AND p.id_pelicula = pg.id_pelicula AND p.id_pelicula = up.id_pelicula
GROUP BY titol
HAVING AVG(up.estrelles) = 1;

/**************************************

             QUERY 3

 **************************************/
 --#&&
SELECT re.de AS "from", re.a AS "to", COUNT(u.id_usuari) AS total_users
FROM RangEdat AS re, Usuari AS u
WHERE u.id_rangedat = re.id_rangedat
GROUP BY u.id_rangedat, re.de, re.a
ORDER BY total_users DESC;

/**************************************

             QUERY 4

 **************************************/
 --#&&
SELECT u.sexe, ROUND(AVG(up.estrelles), 3)
FROM Usuari AS u, Usuari_Pelicula AS up
WHERE u.id_usuari = up.id_usuari
GROUP BY u.sexe;

/**************************************

             QUERY 5

 **************************************/
 --#&&
SELECT p.titol AS title, AVG(up.estrelles) AS avg_grade
FROM Pelicula AS p, usuari_pelicula AS up
WHERE p.id_pelicula = up.id_pelicula
GROUP BY p.titol
HAVING COUNT(up.estrelles) >= 2000
ORDER BY avg_grade DESC
LIMIT 5;
