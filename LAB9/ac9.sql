-- Database: ac9

-- DROP DATABASE ac9;
/*
CREATE DATABASE ac9
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;*/


DROP TABLE IF EXISTS imp_pelis;
CREATE TABLE imp_pelis(
	id_peli INT,
	nom_peli VARCHAR(255),
	data_peli INT,
	genere VARCHAR(255)
);

DROP TABLE IF EXISTS imp_users;
CREATE TABLE imp_users(
	id_user INT,
	sexe VARCHAR(255),
	rang_edat INT,
	id_ocupacio INT,
	codiPostal VARCHAR(255)
);

DROP TABLE IF EXISTS imp_ratings;
CREATE TABLE imp_ratings(
	id_user INT,
	id_peli INT,
	estrelles INT,
	timestamps INT
);

COPY imp_pelis FROM '/tmp/movies.csv' DELIMITER '@';

COPY imp_users FROM '/tmp/users.csv' DELIMITER '@';

COPY imp_ratings FROM '/tmp/ratings.csv' DELIMITER '@';

-- CREEM LES TAULES NORMALITZADES

DROP TABLE IF EXISTS RangEdat CASCADE;
CREATE TABLE RangEdat(
	id_rangEdat INT, -- HO POSEM INT PERQUE JA VE DONAT AL CSV.
	de INT,
	a INT,
	PRIMARY KEY(id_rangEdat)
);

DROP TABLE IF EXISTS Ocupacio CASCADE;
CREATE TABLE Ocupacio(
	id_ocupacio INT, -- HO POSEM INT PERQUE JA VE DONAT AL CSV.
	nom_ocupacio VARCHAR(255),
	PRIMARY KEY(id_ocupacio)
);

DROP TABLE IF EXISTS Genere CASCADE;
CREATE TABLE Genere(
	id_genere SERIAL, -- HO POSEM SERIAL PERQUE NO ES DONA EN CAP LLOC!
	nom_genere VARCHAR(255),
	PRIMARY KEY(id_genere)
);

DROP TABLE IF EXISTS Pelicula CASCADE;
CREATE TABLE Pelicula(
	id_pelicula INT, -- HO POSEM INT PERQUE VE DONAT
	titol VARCHAR(255),
	any_estrena INT,
	PRIMARY KEY(id_pelicula)
);

DROP TABLE IF EXISTS Usuari CASCADE;
CREATE TABLE Usuari(
	id_usuari INT, -- HO POSEM INT PERQUE VE DONAT
	sexe VARCHAR(255),
	codi_postal VARCHAR(255),
	id_ocupacio INT, -- HO POSEM INT PERQUE L'HEM DE POSAR NOSALTRES!
	id_rangEdat INT, -- HO POSEM INT PERQUE L'HEM DE POSAR NOSALTRES!
	PRIMARY KEY(id_usuari),
	FOREIGN KEY(id_ocupacio) REFERENCES Ocupacio(id_ocupacio),
	FOREIGN KEY(id_rangEdat) REFERENCES RangEdat(id_rangEdat)
);

DROP TABLE IF EXISTS Pelicula_Genere;
CREATE TABLE Pelicula_Genere(
	id_pelicula INT, -- HO POSEM INT PERQUE HO HEM DE POSAR NOSALTRES!
	id_genere INT, -- HO POSEM INT PERQUE HO HEM DE POSAR NOSALTRES!
	PRIMARY KEY(id_pelicula, id_genere),
	FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula),
	FOREIGN KEY (id_genere) REFERENCES Genere(id_genere)
);

DROP TABLE IF EXISTS Usuari_Pelicula;
CREATE TABLE Usuari_Pelicula(
	id_pelicula INT, -- HO POSEM INT PERQUE HO HEM DE POSAR NOSALTRES!
	id_usuari INT, -- HO POSEM INT PERQUE HO HEM DE POSAR NOSALTRES!
	estrelles INT,
	timestamp INT,
	PRIMARY KEY(id_pelicula, id_usuari),
	FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula),
	FOREIGN KEY (id_usuari) REFERENCES Usuari(id_usuari)
);

-- INSERTAMOS DATOS EN LAS TABLAS


COPY RangEdat FROM '/tmp/edades.csv' DELIMITER '@';

COPY Ocupacio FROM '/tmp/ocupaciones.csv' DELIMITER '@';

INSERT INTO Genere(nom_genere)
SELECT DISTINCT genere FROM imp_pelis;

INSERT INTO Pelicula(id_pelicula, titol, any_estrena)
SELECT DISTINCT id_peli, nom_peli, data_peli FROM imp_pelis;

INSERT INTO Usuari(id_usuari, sexe, codi_postal, id_ocupacio, id_rangEdat)
SELECT DISTINCT id_user, sexe, codipostal, id_ocupacio, rang_edat FROM imp_users;

INSERT INTO Pelicula_Genere(id_pelicula, id_genere)
SELECT DISTINCT id_peli, id_genere FROM imp_pelis, Genere
WHERE genere = nom_genere;

INSERT INTO Usuari_Pelicula(id_usuari, id_pelicula, estrelles, timestamp)
SELECT id_user, id_peli, estrelles, timestamps FROM imp_ratings;

DROP TABLE imp_pelis;
DROP TABLE imp_users;
DROP TABLE imp_ratings;