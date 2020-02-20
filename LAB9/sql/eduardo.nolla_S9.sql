

/**************************************

             QUERY 1

 **************************************/
 --#&&
SELECT p.id_pelicula, p.titol, p.any_estrena
FROM Pelicula AS p
WHERE p.titol NOT LIKE '% %'
AND p.titol LIKE '%e%'
AND p.titol LIKE '%i%'
AND p.titol LIKE '%o%'
AND p.titol LIKE '%u%'
AND p.titol LIKE '%a%'
AND p.any_estrena > 1979 AND p.any_estrena < 1996;


/**************************************

             QUERY 2

 **************************************/
 --#&&
SELECT p.any_estrena AS Year, p.titol AS Title
FROM Pelicula AS p, Genere AS g
WHERE p.titol = g.nom_genere
AND p.any_estrena < 2002;


/**************************************

             QUERY 3

 **************************************/
 --#&&
SELECT COUNT (*) AS HomeMaker_in_database
FROM ocupacio AS o, usuari AS u
WHERE o.id_ocupacio = u.id_ocupacio
AND o.nom_ocupacio = 'homemaker';


/**************************************

             QUERY 4

 **************************************/
 --#&&
SELECT u.id_usuari AS id,
       up.estrelles AS Grade,
       p.titol AS Title
FROM Usuari AS u, usuari_pelicula AS up, pelicula AS p
WHERE p.id_pelicula = up.id_pelicula
AND up.id_usuari = u.id_usuari
AND up.estrelles > 3;


/**************************************

             QUERY 5

 **************************************/
 --#&&
SELECT AVG(up.estrelles) AS Average
FROM usuari_pelicula AS up, rangedat AS r
WHERE ((r.de = 25 AND r.a = 34) OR (r.de = 50 AND r.a = 55));


/**************************************

             QUERY 6

 **************************************/
 --#&&
SELECT p.titol
FROM pelicula AS p, usuari_pelicula AS up, genere AS g, pelicula_genere AS pg
WHERE g.nom_genere = 'Western' AND g.id_genere = pg.id_genere AND p.id_pelicula = pg.id_pelicula AND p.id_pelicula = up.id_pelicula
GROUP BY titol
HAVING AVG(up.estrelles) = 1;

/**************************************

             QUERY 7

 **************************************/
--#&&
SELECT u.id_usuari AS ID, p.titol AS Title
FROM pelicula AS P, usuari_pelicula AS up, Usuari AS u
WHERE p.id_pelicula = up.id_pelicula AND
      u.id_usuari = up.id_usuari
ORDER BY timestamp DESC
LIMIT 1;


/**************************************

             QUERY 8

 **************************************/
--#&&
SELECT u.id_usuari AS ID, up.estrelles AS Grade, p.titol AS Title
FROM pelicula AS P, usuari_pelicula AS up, Usuari AS u
WHERE p.id_pelicula = up.id_pelicula AND
      u.id_usuari = up.id_usuari
ORDER BY timestamp ASC
LIMIT 1;


/**************************************

             QUERY 9

 **************************************/
--#&&
SELECT u.id_usuari AS ID, up.estrelles AS Grade, p.titol AS Title
FROM pelicula AS P, usuari_pelicula AS up, Usuari AS u
WHERE p.id_pelicula = up.id_pelicula AND
      u.id_usuari = up.id_usuari AND
      up.estrelles = 1
ORDER BY timestamp DESC
LIMIT 1;


/**************************************

             QUERY 10
TOP 10 Pelicules Mes Noves Millor Valorades
 **************************************/
--#&&
SELECT u.id_usuari AS ID, up.estrelles AS Grade, p.titol AS Title
FROM pelicula AS P, usuari_pelicula AS up, Usuari AS u
WHERE p.id_pelicula = up.id_pelicula AND
      u.id_usuari = up.id_usuari AND
      up.estrelles = 5
ORDER BY any_estrena DESC
LIMIT 10;





