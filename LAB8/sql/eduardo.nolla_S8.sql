
drop table if exists categorizado cascade;

drop table if exists categorias cascade;

drop table if exists subtitulada cascade;

drop table if exists subtitulos cascade;

drop table if exists patheada cascade;

drop table if exists paths cascade;

drop table if exists valoracion cascade;

drop table if exists comenta cascade;

drop table if exists comentario cascade;

DROP TABLE IF EXISTS Serie CASCADE;
CREATE TABLE Serie(
	id_serie_superunic_canviam_pls VARCHAR(255),
	nom_serie			VARCHAR(255),
	duracio				BIGINT,                     --durada episodi
	num_temporades		VARCHAR(255),               --numereo total de temporadas
	descripcio			TEXT,                       --resumen de la serie
	categoria_1			VARCHAR(255),               --clasificacion de la serie policiaca, scifi...
	categoria_2			VARCHAR(255),
	categoria_3			VARCHAR(255),
	sub_catala			BOOLEAN,                    --boolea que indica si te subtitols en aquell idioma
	path_s_catala		VARCHAR(255),               --link donde ver la serie con los subtitulos y el idioma especificat
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
	nick_user		VARCHAR(255),                   --nom d'usuari, es pot repetir
	id_serie		VARCHAR(255),                   --identificafor unico de usuario
	nom_serie		VARCHAR(255),                   --nombre de la serie
	valoracio		VARCHAR(255),                   --float 0<x<10
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

--We drop the foreign key of usuari and after that we drop the primary key on Serie
ALTER TABLE Usuari DROP CONSTRAINT usuari_id_serie_fkey;
ALTER TABLE Serie DROP CONSTRAINT serie_pkey;

--We rename the name of id_serie_superunic_canviam_pls to id_serie
ALTER TABLE Serie RENAME COLUMN id_serie_superunic_canviam_pls TO id_serie;

--We change the type id_serie to serial type
--As we can't directly change it we are going to delete it and create it again
--ALTER TABLE Serie ALTER COLUMN id_serie TYPE SERIAL USING id_serie::serial;

ALTER TABLE Serie DROP COLUMN id_serie;
ALTER TABLE Serie ADD COLUMN id_serie serial;

--We add as primary key the column we have just renamed
ALTER TABLE Serie ADD PRIMARY KEY (id_serie);


--Drop all the columns to normalise the table
ALTER TABLE Serie DROP COLUMN categoria_1;
ALTER TABLE Serie DROP COLUMN categoria_2;
ALTER TABLE Serie DROP COLUMN categoria_3;
ALTER TABLE Serie DROP COLUMN sub_catala;
ALTER TABLE Serie DROP COLUMN path_s_catala;
ALTER TABLE Serie DROP COLUMN sub_angles;
ALTER TABLE Serie DROP COLUMN path_s_angles;
ALTER TABLE Serie DROP COLUMN sub_frances;
ALTER TABLE Serie DROP COLUMN path_s_frances;
ALTER TABLE Serie DROP COLUMN sub_esperanto;
ALTER TABLE Serie DROP COLUMN path_s_esperanto;

--Cambiamos algunos tipos para optimizar
ALTER TABLE Serie ALTER COLUMN duracio TYPE SMALLINT USING duracio::smallint;
ALTER TABLE Serie ALTER COLUMN num_temporades TYPE SMALLINT USING num_temporades::smallint;


--We drop all the primary key of Usuari
ALTER TABLE Usuari DROP CONSTRAINT usuari_pkey;

--We set the id_user as a serial type
ALTER TABLE Usuari ADD COLUMN id_user SERIAL;

--We set that id_user as primary key
ALTER TABLE Usuari ADD PRIMARY KEY (id_user);

--Drop all the columns to nornmalise the table
ALTER TABLE Usuari DROP COLUMN id_serie;
ALTER TABLE Usuari DROP COLUMN nom_serie;
ALTER TABLE Usuari DROP COLUMN valoracio;
ALTER TABLE Usuari DROP COLUMN comentari_1;
ALTER TABLE Usuari DROP COLUMN data_comentari_1;


--Cambiamos de nombre a id_XXXX y el tipo a integer
ALTER TABLE Follow RENAME COLUMN nick_seguidor TO id_seguidor;
ALTER TABLE Follow RENAME COLUMN nick_seguit TO id_seguit;
ALTER TABLE Follow ALTER COLUMN id_seguidor TYPE INTEGER USING id_seguidor::integer;
ALTER TABLE Follow ALTER COLUMN id_seguit TYPE INTEGER USING id_seguit::integer;
ALTER TABLE Follow ADD FOREIGN KEY (id_seguidor) REFERENCES Usuari (id_user);
ALTER TABLE Follow ADD FOREIGN KEY (id_seguit) REFERENCES Usuari(id_user);



CREATE TABLE Categorias(
    id_cateogria serial,
    nom_categoria varchar (255),
    PRIMARY KEY (id_cateogria)
);


CREATE TABLE Subtitulos (
    id_subtitulo serial,
    subtitulo bool,
    PRIMARY KEY (id_subtitulo)
);

CREATE TABLE Paths(
    id_paths varchar (255),
    PRIMARY KEY (id_paths)
);

CREATE TABLE Categorizado(
    id_cateogria int,
    id_serie int,
    PRIMARY KEY (id_cateogria, id_serie),
    FOREIGN KEY (id_cateogria) REFERENCES Categorias(id_cateogria),
    FOREIGN KEY (id_serie) REFERENCES Serie (id_serie)
);

CREATE TABLE Subtitulada(
    id_subtitulo int,
    id_serie int,
    primary key (id_subtitulo, id_serie),
    FOREIGN KEY (id_subtitulo) REFERENCES Subtitulos (id_subtitulo),
    FOREIGN KEY (id_serie) REFERENCES Serie (id_serie)
);

CREATE TABLE Patheada(
    id_paths varchar,
    id_series int,
    PRIMARY KEY (id_paths, id_series),
    FOREIGN KEY (id_paths) REFERENCES  Paths (id_paths),
    FOREIGN KEY (id_series) REFERENCES Serie (id_serie)
);

CREATE TABLE Valoracion(
    id_user int,
    id_serie int,
    valoracio float(2),
    PRIMARY KEY (id_user, id_serie),
    FOREIGN KEY (id_user) REFERENCES Usuari (id_user),
    FOREIGN KEY (id_serie) REFERENCES Serie (id_serie)
);

CREATE TABLE Comentario(
    id_comentario int,
    comentari text,
    data_comentari Date,
    PRIMARY KEY (id_comentario)
);

CREATE TABLE Comenta(
    id_user int,
    id_serie int,
    id_comentario int,
    PRIMARY KEY (id_user, id_serie, id_comentario),
    FOREIGN KEY (id_user) REFERENCES Usuari(id_user),
    FOREIGN KEY (id_serie) REFERENCES Serie(id_serie),
    FOREIGN KEY (id_comentario) REFERENCES Comentario (id_comentario)
);










