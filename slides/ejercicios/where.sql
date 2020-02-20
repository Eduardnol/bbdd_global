create table Producte(
    serial codi_producte,
    nom varchar (255),
    preu_base float,
    iva float,
    stock int
);


SELECT  nom
from Producte
where stock < 20


select codi_producte from producte where preu_base > 10;


select nom, preu_base from producte where iva = 0.04 and (preu_base < 3.0 or preu_base > 5.0);


select codi_producte, iva from producte where codi_producte * (1+iva) < 2;


select nom, preu_base * ( 1 + iva) as PVP from producte;


--------------------------------------------------------------------------------------------------------------------------------

create table Empleat(
    serial codi_emp,
    dni varchar(30),
    numSS int,
    codi_dept int,
    nom varchar(34),
    cognom1 varchar(45),
    cognom2 varchar (45),
    sou float,

    primary keu (codi_emp),
    foreign key (codi_dept) extends (codi_dept) from Department
);


create table Department(
    codi_dept int,
    nom_dept varchar(45),
    edifici char,
    m2 int,
    codi_emp_cap int,

    primary key (codi_dept),
    foreign key (codi_emp_cap) extends codi_emp from empleat

);


--debemos evitar los productos cartesianos
Select numSS from empleat where codi_dept = 'D5';


Select nom from empleat as e, Department as d where e.codi_dept = d.codi_dept and d.edifici = 'World Trade Centre';



select codi_dept, nom_dept from empleat as e, Department as d where e.codi_dept = d.codi_dept and e.sou > 1000;