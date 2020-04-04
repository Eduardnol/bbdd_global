CREATE DATABASE ejemplo1;

USE ejemplo1;

DROP TABLE IF EXISTS persona;

CREATE TABLE persona(
   ID INTEGER AUTO_INCREMENT,
   nom VARCHAR(256),
   cognom1 VARCHAR(256),
   cognom2 VARCHAR(256),
   PRIMARY KEY (ID));

DROP TABLE IF EXISTS log;
CREATE TABLE log(
   ID_log_DP INTEGER AUTO_INCREMENT,
   taula VARCHAR(20),
   camp VARCHAR(20),
   valor_antic VARCHAR(20),
   valor_nou VARCHAR(20),
   usuari VARCHAR(20),
   hora TIMESTAMP,
   PRIMARY KEY (ID_log_DP));

