
#%%0
DROP DATABASE IF EXISTS s1;
CREATE DATABASE s1;
USE s1;

#&&1
DROP TABLE IF EXISTS user CASCADE;
CREATE TABLE user (
    id_client int not null ,
    name varchar(255),
    surname varchar(255),
    gender char,
    birthday date   CHECK ( YEAR(CURDATE()) - YEAR(birthday) >= 18),
    city varchar(255),
    PRIMARY KEY (id_client)
);
DROP TABLE IF EXISTS serie CASCADE;
CREATE TABLE serie(
    id_serie int not null AUTO_INCREMENT ,
    name varchar(255),
    seasons int,
    PRIMARY KEY (id_serie)
);

DROP TABLE IF EXISTS favorite CASCADE;
CREATE TABLE favorite(
    id_serie int,
    id_user int,
    since date,

    PRIMARY KEY (id_serie, id_user),
    FOREIGN KEY (id_serie) REFERENCES serie(id_serie),
    FOREIGN KEY (id_user) REFERENCES user(id_client)
);

#%%2
INSERT INTO user (id_client, name, surname, gender, birthday, city)
VALUES (1356, 'albert', 'ferrando', 'm', '1998-05-02', 'vendrell'),
       (2237, 'jaume', 'campeny', 'm', '1998-02-20', 'granollers'),
       (7, 'anna', 'noguer', 'f', '1999-08-07', 'girona'),
       (8769, 'josep', 'roig', 'm', '1999-06-30', 'amposta'),
       (6969, 'kermit', 'frog', 'o', '1969-12-12', 'deltebre');

INSERT INTO serie (name, seasons)
VALUES ('Money Heist', 4),
       ('13 reasons why', 3),
       ('The man in the high castle', 4),
       ('Stranger Things', 3),
       ('Game of thrones', 8);

INSERT INTO favorite (id_serie, id_user, since)
VALUES (1, 1356, str_to_date('4/2/2018','%d/%m/%Y')),
       (2, 2237, str_to_date('3/12/2017','%d/%m/%Y')),
       (3, 7, str_to_date('4/4/2018','%d/%m/%Y')),
       (4, 8769, str_to_date('1/1/19','%d/%m/%Y')),
       (1, 8769, str_to_date('1/1/2019','%d/%m/%Y')),
       (5, 6969, str_to_date('29/6/2018','%d/%m/%Y'));


#%%3
SELECT * FROM user;
SELECT * FROM serie;
SELECT * FROM favorite;