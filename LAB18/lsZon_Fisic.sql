DROP DATABASE IF EXISTS lsZon;
CREATE DATABASE lsZon;

Use lsZon;


DROP TABLE IF EXISTS timer CASCADE;
DROP TABLE IF EXISTS magatzem CASCADE;
DROP TABLE IF EXISTS oficina CASCADE;
DROP TABLE IF EXISTS persona CASCADE;



CREATE TABLE persona(
	name VARCHAR(255),
	id_card VARCHAR(255),
	id_person int AUTO_increment,
	PRIMARY KEY (id_person)
);

CREATE TABLE magatzem(
  id_person int,
  access_in datetime,
	foreign key (id_person) references persona(id_person),
	PRIMARY KEY (id_person)
);

CREATE TABLE oficina(
  id_person int,
  access_in datetime,
	foreign key (id_person) references persona(id_person),
	PRIMARY KEY (id_person)
);

CREATE TABLE timer(
	id_timer int AUTO_increment,
	access_in datetime,
 	access_out datetime,
  	id_person int,
  	foreign key (id_person) references persona(id_person),
	primary key (id_timer)
);

insert into persona(id_card, name) values('1234A', 'Claudia');
insert into timer(id_person, access_in, access_out) values (1, now(), now());
