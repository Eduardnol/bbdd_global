
--EJERCICIO 1
drop table if exists Aerolinia

create table Aerolinia(
    varchar nom_aeroport(255),
    varchar nom_aerolinia(255),
    integer numvols_aeroport,
    integer numvols_aerolinia,
    CHAR (1) portes_asignades,

    PRIMARY KEY (nom_aeroport, nom_aerolinia)
);


--EJERCICIO 2

ALTER TABLE Aerolinia DROP COLUMN nom_aeroport;
ALTER TABLE Aerolinia DROP COLUMN numvols_aeroport;
ALTER TABLE Aerolinia DROP COLUMN  portes_asignades;
ALTER TABLE Aerolinia ADD PRIMARY KEY (nom_aerolinia);


create table Aeroport(
    nom_aeroport varchar(255),
    numvols_aeroport integer,

    PRIMARY KEY (nom_aeroport)
);

create table Ofereix(
    nom_aeroport varchar(255),
    nom_aerolinia varchar(255),
    portes_asignades CHAR(1),

    PRIMARY KEY(numvols_aeroport, numvols_aerolinia),
    FOREIGN KEY(numvols_aerolinia references Aerolinia (nom_aerolinia)),
    FOREIGN KEY(nom_aerolinia) references Aeroport(nom_aeroport)
);

--EJERCICIO 3

ALTER TABLE Ofereix RENAME COLUMN portes_asignades TO porta;
ALTER TABLE Ofereix ALTER COLUMN porta TYPE INTEGER USING porta :: integer;

--EJERCICIO 4

ALTER TABLE Aeroport RENAME COLUMN nom_aeroport TO aeroport;
ALTER TABLE Aeroport ALTER COLUMN aeroport TYPE INTEGER USING aeroport:: integer;
ALTER TABLE Ofereix DROP CONSTRAINT ofereix_nom_aeroport_fkey;
ALTER TABLE  Aeroport ALTER COLUMN aeroport TYPE INTEGER USING aeroport::integer;
ALTER TABLE Ofereix ALTER COLUMN nom_aeroport TYPE INTEGER USING nom_aeroport::integer;
ALTER TABLE Ofereix ADD FOREIGN KEY (nom_aeroport) REFERENCES Aeroport (aeroport);

