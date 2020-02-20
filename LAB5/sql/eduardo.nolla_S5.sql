DROP TABLE IF EXISTS Pais CASCADE;

CREATE TABLE Pais(
    Codi VARCHAR(64),
    nom VARCHAR(64),
    codi_zona VARCHAR(64),
    PRIMARY KEY (Codi)
);



DROP TABLE IF EXISTS Zona CASCADE;

CREATE TABLE Zona(
    Codi VARCHAR(64),
    nom VARCHAR(64),
    latitud DOUBLE PRECISION,
    longitud DOUBLE PRECISION,
    codi_pais VARCHAR(64),
    PRIMARY KEY (Codi),
    FOREIGN KEY (codi_pais) REFERENCES Pais (Codi)
);



DROP TABLE IF EXISTS Persona CASCADE;

CREATE TABLE Persona(
  DNI VARCHAR(15),
  nom VARCHAR(255),
  data_naixement DATE,
  email VARCHAR(255),
  sexe VARCHAR(1),
  PRIMARY KEY (DNI)
);



DROP TABLE IF EXISTS Gestor CASCADE;

CREATE TABLE Gestor(
    DNI_gestor VARCHAR(9),
    permisos VARCHAR(15),
    PRIMARY KEY (DNI_gestor),
    FOREIGN KEY (DNI_gestor) REFERENCES Persona(DNI)
);



DROP TABLE IF EXISTS Escalador CASCADE;

CREATE TABLE Escalador(
    DNI_escalador VARCHAR(9),
    alçada float4,
    pes float4,
    codi_pais VARCHAR(64),
    PRIMARY KEY (DNI_escalador),
    FOREIGN KEY (DNI_escalador) REFERENCES Persona(DNI),
    FOREIGN KEY (codi_pais) REFERENCES Pais(Codi)
);



DROP TABLE IF EXISTS Amic CASCADE;

    CREATE TABLE Amic(
        DNI_escalador1 VARCHAR(9),
        DNI_escalador2 VARCHAR(9),
        FOREIGN KEY (DNI_escalador1)REFERENCES Escalador(DNI_escalador),
        FOREIGN KEY (DNI_escalador2) REFERENCES Escalador(DNI_escalador)
    );



DROP TABLE IF EXISTS Comentari CASCADE;

CREATE TABLE Comentari(
    Codi VARCHAR(64),
    text TEXT,
    data DATE,
    puntuacio INT,
    imatge VARCHAR(256), -- TIPO IMAGEN
    PRIMARY KEY (Codi)
);



DROP TABLE IF EXISTS Activitat CASCADE;

CREATE TABLE Activitat(
    Codi VARCHAR(64),
    nom VARCHAR(256),
    dificultat INT,
    codi_zona VARCHAR(64),
    PRIMARY KEY (Codi),
    FOREIGN KEY (codi_zona) REFERENCES Zona(Codi)
);



DROP TABLE IF EXISTS Bloc CASCADE;

CREATE TABLE Bloc(
    Codi_Activitat VARCHAR(64),
    alçada float4,

    PRIMARY KEY (Codi_Activitat),
    FOREIGN KEY (Codi_Activitat) REFERENCES Activitat(Codi)
);



DROP TABLE IF EXISTS Completa CASCADE;

CREATE TABLE Completa(
    Codi_Activitat VARCHAR(64),
    Codi_Comentari VARCHAR(64),
    DNI_escalador VARCHAR(9),
    PRIMARY KEY (Codi_Activitat, Codi_Comentari, DNI_escalador),
    FOREIGN KEY (Codi_Activitat) REFERENCES Activitat(Codi),
    FOREIGN KEY (Codi_Comentari) REFERENCES Comentari(Codi),
    FOREIGN KEY (DNI_escalador) REFERENCES Escalador(DNI_escalador)
);








