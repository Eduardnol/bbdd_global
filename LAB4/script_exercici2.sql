DROP TABLE IF EXISTS Docents;
CREATE TABLE Docents(
	id SERIAL,
	nom VARCHAR(255),
	cognom VARCHAR(255),
	rol VARCHAR(255)
);

INSERT INTO Docents (nom, cognom, rol)
VALUES ('Alvaro', 'Sicilia', 'Professor'),
('Oswald', 'Sapang', 'Professor'),
('Albert', 'Ferrando', 'Becari'),
('Jaume', 'Campeny', 'Becari');

SELECT * FROM Docents;