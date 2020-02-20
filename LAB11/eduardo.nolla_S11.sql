--#&&
SELECT p.titol, AVG(up.estrelles) AS mitjana
FROM Pelicula AS p, Usuari_Pelicula AS up
WHERE p.any_estrena = 1993 AND
      p.id_pelicula = up.id_pelicula
GROUP BY titol
ORDER BY ABS(AVG(up.estrelles) - (exp(1) + 1)) asc
limit 1;



