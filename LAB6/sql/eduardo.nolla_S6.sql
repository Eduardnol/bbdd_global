DROP TABLE IF EXISTS Actor CASCADE;
DROP TABLE IF EXISTS Movie CASCADE;
DROP TABLE IF EXISTS Plays CASCADE;


create table Actor
(
    ID_actor SERIAL,
    name     VARCHAR(255),
    fb_likes INT,
    PRIMARY KEY (ID_actor)
);


create table Movie
(
    ID_movie SERIAL,
    title VARCHAR(255),
    duration smallINT,
    PRIMARY KEY (ID_movie)
);


create table Plays
(
    ID_actor          INT, --Hay que mirar que el id del actor en las dos tablas sea el mismo
    ID_movie          INT,
    is_main_character BOOL,

    PRIMARY KEY (ID_actor, ID_movie),
    FOREIGN KEY (ID_actor) REFERENCES Actor(ID_actor),
    FOREIGN KEY (ID_movie) REFERENCES Movie(ID_movie)

);

DROP TABLE IF EXISTS Importacio CASCADE;

create table Importacio(
    title VARCHAR(100),
    duration smallINT,
    name VARCHAR (100),
    fb_likes INT,
    is_main_character BOOL
);

COPY Importacio FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\LAB6\movie.csv' DELIMITER ';' csv header;

UPDATE Importacio SET title = initcap(title);

--Vamos a pasar las peliculas al formato first caps con la funcion initcap(string)
INSERT INTO Actor (name, fb_likes) SELECT DISTINCT(name), fb_likes FROM Importacio;
INSERT INTO Movie (title, duration) SELECT DISTINCT((title)), duration FROM Importacio;

--Deberia agrupar las peliculas

--No salen todas las peliculas que ha hecho un actor
INSERT INTO Plays (ID_actor, ID_movie, is_main_character)
SELECT Actor.ID_actor, Movie.ID_movie, Importacio.is_main_character
FROM Actor NATURAL JOIN Movie NATURAL JOIN Importacio;

SELECT Movie.title, Actor.name, Plays.is_main_character FROM Actor NATURAL JOIN Movie NATURAL JOIN Plays WHERE (name = 'Julie Walters' AND title = 'Brave');


























