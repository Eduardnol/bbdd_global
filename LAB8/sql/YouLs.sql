-- Database: "YouLs"

-- DROP DATABASE "YouLs";

/*
CREATE DATABASE "YouLs"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;
*/


DROP TABLE IF EXISTS Serie CASCADE;
CREATE TABLE Serie( 
	id_serie_superunic_canviam_pls VARCHAR(255),	
	nom_serie			VARCHAR(255),	
	duracio				BIGINT,
	num_temporades		VARCHAR(255),
	descripcio			TEXT,
	categoria_1			VARCHAR(255),
	categoria_2			VARCHAR(255),
	categoria_3			VARCHAR(255),	
	sub_catala			BOOLEAN,
	path_s_catala		VARCHAR(255),
	sub_angles			BOOLEAN,
	path_s_angles		VARCHAR(255),
	sub_frances			BOOLEAN,
	path_s_frances		VARCHAR(255),
	sub_esperanto		BOOLEAN,
	path_s_esperanto	VARCHAR(255),
	PRIMARY KEY (id_serie_superunic_canviam_pls, nom_serie)
);


DROP TABLE IF EXISTS Usuari CASCADE;
CREATE TABLE Usuari( 
	nick_user		VARCHAR(255),
	id_serie		VARCHAR(255),
	nom_serie		VARCHAR(255),
	valoracio		VARCHAR(255),
	comentari_1		VARCHAR(255),	
	data_comentari_1 DATE,	
	PRIMARY KEY (nick_user, id_serie),
	FOREIGN KEY (id_serie, nom_serie) REFERENCES Serie(id_serie_superunic_canviam_pls, nom_serie)
);


DROP TABLE IF EXISTS Follow CASCADE;
CREATE TABLE Follow(
	nick_seguidor		VARCHAR(255),
	nick_seguit		VARCHAR(255),
	PRIMARY KEY (nick_seguidor, nick_seguit)
);
