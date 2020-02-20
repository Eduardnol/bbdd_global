

DROP TABLE IF EXISTS Import;

CREATE TABLE Import (
        identificador VARCHAR(255),
        nom VARCHAR(255),
        cognom VARCHAR(255),
        email VARCHAR(255),
        sexe VARCHAR(255),
        edat INTEGER
);



COPY Import FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\LAB2\infoS2.csv' DELIMITER ';';


SELECT * FROM Import;

SELECT * FROM Import WHERE (edat = 18) AND (sexe = 'Male' OR sexe = 'Female');

SELECT * FROM Import WHERE (edat >= 51 AND edat <= 60 ) AND (sexe = 'Male') AND (nom <> 'Nicolas' AND cognom <> 'O''Lahy');

SELECT * FROM Import WHERE ((nom LIKE '%a%') OR (nom LIKE 'A%') OR (nom LIKE '%a'));

SELECT * FROM Import WHERE (sexe <> 'Male') AND (sexe <> 'Female');

SELECT edat FROM Import WHERE (nom = 'Jaume') AND (cognom = 'Campeny') OR (nom = 'Albert') AND (cognom = 'Ferrando');


DROP TABLE IF EXISTS Major;

CREATE TABLE Major (
        identificador VARCHAR(255),
        nom VARCHAR(255),
        cognom VARCHAR(255),
        email VARCHAR(255),
        sexe VARCHAR(255),
        edat INTEGER
);


INSERT INTO Major (identificador, nom, cognom, email, sexe, edat) SELECT identificador, nom, cognom, email, sexe, edat FROM Import WHERE edat >= 18;

DROP TABLE IF EXISTS Email;

CREATE TABLE Email (
        identificador VARCHAR(255),
        email VARCHAR(255)
);

INSERT INTO Email (identificador, email) SELECT identificador, email FROM Import WHERE(email LIKE '%.edu');

SELECT email FROM Email WHERE (email LIKE '%@salleurl.edu') OR (email LIKE '%@students.salle.url.edu');


-- Amb el què saps fins ara, com sabries quantes noies hi ha en total a la taula Major?
-- Podemos hacer un select de sexe de la tabla Major con un condicional que nos seleccione solamente los que correspondaan con 'Female'
-- SELECT noies FROM Import WHERE sexe = 'Female'
-- El mateig pgadmin ens indica el nombre de files que hi ha, encara que es pot programar també amb COUNT
-- SELECT COUNT(column_name) FROM table_name WHERE condition;

-- Amb el què saps fins ara, com sabries quants e-mails comencen amb ‘c’?
-- Para saber los email que empiezan por c debemos hacer un select de emails con la condicion y la función LIKE y especificando 'c%' lo
-- lo que hace % es representar el resto de caracteres del campo, en este caso los caracteres que van detrás de c
-- El mateig pgadmin ens indica el nombre de files que hi ha, encara que es pot programar també amb COUNT