DROP TABLE IF EXISTS Import;
DROP TABLE IF EXISTS Taula_Persona;
DROP TABLE IF EXISTS Taula_Conexio;
DROP TABLE IF EXISTS Taula_Transaccio;
DROP TABLE IF EXISTS Taula_Treball;

CREATE TABLE Import (
        Id SMALLINT,
        First_Name VARCHAR(255),
        Last_Name VARCHAR (255),
        Email VARCHAR(255),
        Gender VARCHAR(1),
        IPv4 CIDR,
        Credit_Card BIGINT,--
        Date_transaction DATE,
        IBAN VARCHAR(41),   --eL IBAN son como maximo 34 caracteres alfanumericos + 7 espacios
        IPv6 CIDR,
        Amount_Money VARCHAR(255),
        Time_transaction TIME,--
        Password_transaction VARCHAR(255),
        Currency_code VARCHAR(3),
        Was_ok BOOL,
        Company_name VARCHAR(255),
        Department VARCHAR (255),
        Salary MONEY,--
        MAC MACADDR
);
COPY Import FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\LAB4\Lab4.csv' DELIMITER ',' csv header;

--Ponemos en minuscula el nombre y el apellido en la tabla principal



CREATE TABLE Taula_Persona(
    Id         SMALLINT,
    First_Name VARCHAR(255),
    Last_Name  VARCHAR(255),
    Email      VARCHAR(255),
    Gender     char,
    Salary     MONEY
);


CREATE TABLE Taula_Conexio(
    Id SMALLINT,
    IPv4 CIDR,
    IPv6 CIDR,
    MAC MACADDR
);


CREATE TABLE  Taula_Transaccio(
    Id SMALLINT,
    Date_transaction DATE,
    IBAN VARCHAR(44),
    Amount_Money VARCHAR(255),
    Time_Transaction TIME,
    Password_Transaction VARCHAR(255),
    Was_ok  BOOL,
    Credit_card BIGINT,
    Currency_code VARCHAR(3),
    CheckSum VARCHAR(255)
);



CREATE TABLE Taula_Treball (
    Id SMALLINT,
    Company_Name VARCHAR(255),
    Department VARCHAR(255),
    Num_department INT
);

--Copiamos la informacion en Taula_Transaccio
INSERT INTO Taula_Transaccio(Id, Date_transaction, IBAN, Amount_Money, Time_transaction, Password_transaction, Was_ok, Credit_card, Currency_code, CheckSum)

--Para hacer el MD5 y el swapcase de la contraseña
SELECT Id, Date_transaction, IBAN, Amount_Money, Time_transaction, TRANSLATE (Password_transaction, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'), Was_ok, Credit_card, Currency_code, MD5(CONCAT(IBAN, Currency_code)) from IMPORT;



--Copiamos la informacion en la Taula_Conexio
INSERT INTO Taula_Conexio(Id, IPv4, IPv6, MAC) SELECT Id, IPv4, IPv6, MAC FROM Import;

--Copiamos la informacion en la Taula_Treball
INSERT INTO Taula_Treball(Id, Company_Name, Department, Num_department) SELECT Id, Company_name, Department, length(Department) FROM Import;


--Copiamos la informacion en la Taula_Persona
INSERT INTO Taula_Persona(Id, First_Name, Last_Name, Email, Gender, Salary) SELECT Id, lower(First_Name), lower(Last_Name), Email, Gender, Salary FROM Import;




/**********************************************************************************************************************

Analitzeu i executeu l’script que teniu penjat a l’estudy. Busqueu informació sobre el tipus SERIAL de l’id.

# Quin comportament té aquest tipus de dades?
    -El que fa el tipus de dades SERIAL es assignar un identificador únic (PK) a cada atribut de la nostra taula. És una notació que asigna un nombre (començant per 1) a cada atribut, aquest l'identifica

# Per quin aspecte vist a teoria creieu que pot servir?
    -Pot servir com a PK o identificador únic per el nomstre model conceptual, es a dir una Atribut Identificador de la nostra entitat

# Com és que per l’Exercici 1 no necessitàvem aquest tipus de dades però ara sí?
    -Per que l'exercici 1 ja ve inclòs i  s'anomena Id de manera que no cal tornar-ho a posar


**********************************************************************************************************************/


