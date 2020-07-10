
CREATE DATABASE web;
USE web;

CREATE TABLE Usuari(
	ID_usuari INT NOT NULL AUTO_INCREMENT,
	username varchar(20) NOT NULL,
	password varchar(20) NOT NULL,
	CONSTRAINT pk_agenda PRIMARY KEY (ID_usuari) );
	
CREATE TABLE Agenda(
	ID_persona INT NOT NULL AUTO_INCREMENT,
	nom VARCHAR(25) NOT NULL,
	cognom VARCHAR(25) NOT NULL,
	telefon CHAR(9),
	email VARCHAR(25),
	CONSTRAINT pk_agenda PRIMARY KEY (ID_persona) );

INSERT INTO Agenda(nom,cognom,telefon,email) VALUES 
('Carlos','Perez','618123456','cperez@mail.com'),	
('Albert','Martin','629123456','amartin@mail.com'),	
('Juan','Rodriguez','626123456','jrodriguez@mail.com');

INSERT INTO Usuari(username,password) VALUES
('admin','admin');