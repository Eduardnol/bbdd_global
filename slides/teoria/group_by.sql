/*
Ejercicio 1
*/


CREATE TABLE Empleat(
    DNI varchar
    nom varchar
    cognom1 varchar
    cognom2 varchar
    DNI_cap varchar
    dept varchar
    sou varchar
    any_naixement varchar

    PRIMARY KEY(DNI)
    FOREIGN KEY (DNI_Cap) REFERENCES Empleat(DNI)
    FOREIGN KEY (dept) REFERENCES Department(ID_dept)
);

CREATE TABLE Department(
    id_dept varchar,
    nom varchar,
    DNI_Director varchar,
    data_ingres_director varchar,
    PRIMARY KEY(ID_dept)
);
CREATE TABLE Projecte(
    ID_projecte varchar,
    nom_projecte varchar,
    dept varchar,
    PRIMARY KEY (id_projecte),
    FOREIGN KEY (dept) REFERENCES Department(id_dept)
),
CREATE TABLE Projecte_Empleat(
    dni varchar,
    id_projecte varchar,
    hores varchar,
    PRIMARY KEY (dni, id_projecte),
    FOREIGN KEY(dni) REFERENCES Empleat(dni),
    FOREIGN KEY (id_projecte) REFERENCES Projecte(id_projecte)    
);

---------------------------------
--Apartado 2
--Selecciona DNI, nom complert i total d’hores treballades dels empleats que
--treballen en algun projecte i treballin més de 100 hores (en total).
---------------------------------
SELECT e.DNI, e.NOM, e.cognom, SUM(hores) AS total_hores 
FROM Empleat AS e, Projecte_Empleat AS pe 
WHERE e.DNi = pe.DNI
GROUP BY e.DNI, e.nom, e.cognolm1, e.cognom2 
HAVING SUM(hores) > 100;
--Primero vamos a agrupar por grupos y luego vamos a ver si el grupo suma mas de 100 horas


---------------------------------
--Apartado 3
--Selecciona el nom dels departaments i llurs projectes sempre que hi
--col·laborin treballadors d’altres departaments.
---------------------------------

SELECT d.nom, p.nom_projecte 
FROM Department AS d, Projecte AS p, Projecte_Empleat AS pe, Empleat AS e 
WHERE d.ID_dept = p.dept AND p.id_projecte = pe.id_projecte AND pe.dni = e.dni AND p.id_dept <> e.dept --CONDICIONES


---------------------------------
--Apartado 4
--Selecciona el identificador dels tres projectes que més hores hagin invertit
--els treballadors amb un sou superior a 3000 EUR. Mostra també les hores
--sota el nom “total_hores”
---------------------------------

SELECT pe.id_projecte, SUM(hores) AS total_hores
FROM Projecte_Empleat AS pe, Empleat AS e
WHERE pe.DNi = e.DNI AND e.sou > 3000
GROUP BY pe.id_projecte
ORDER BY SUM(hores) DESC
LIMIT 3;



---------------------------------
--Apartado 5
--Selecciona el nom dels departaments i l’edat mitjana dels treballadors que
--hi col·laboren, ordenats de més joves a més grans.
---------------------------------

SELECT d.nom, AVG (2019-any_naixement) AS edat_mitjana
FROM Empleat AS e, Department AS d
WHERE e.dept = d.id_dept
GROUP BY d.nom
ORDER BY edat_mitjana ASC;

