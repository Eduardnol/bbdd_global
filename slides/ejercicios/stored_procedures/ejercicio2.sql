CREATE DATABASE ejercicio2;

USE ejercicio2;

DROP TABLE IF EXISTS student;
CREATE TABLE student(
   ID INTEGER AUTO_INCREMENT,
   name VARCHAR(20),
   lastname VARCHAR(20),
   grade int,
   PRIMARY KEY (ID));


DROP TABLE IF EXISTS friends;
CREATE TABLE friends(
   ID1 INTEGER,
   ID2 INTEGER,
   happiness int,
PRIMARY KEY (ID1, ID2));

DROP TABLE IF EXISTS partner;
CREATE TABLE partner(
   liking INTEGER,
   liked INTEGER,
PRIMARY KEY (liking, liked));
