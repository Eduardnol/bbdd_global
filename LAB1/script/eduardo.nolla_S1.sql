-- Database: Sesió 1


DROP TABLE IF EXISTS Persona;

CREATE TABLE Persona (
        Nom VARCHAR(255),
        Edat INTEGER,
        Estat VARCHAR(255)
);

INSERT INTO Persona VALUES ('Eduardo Nolla', 20, 'Hello World');

--SELECT * FROM Persona;

SELECT Estat FROM Persona;

--Obtenim el mateix resultat al fer el pas 1 que al fer el pas 4 degut a que el pas 1 es directament la cadena Hello World mentre que el 4 es una variable cadena que conte la frase

