



String query = "SELECT * FROM " + s; #Donde s es el nombre de la tabla que queremos descargar



LOAD  DATA LOCAL INFILE '" + path + "' INTO TABLE " + tabla + " CHARACTER SET 'utf8'" + " FIELDS TERMINATED BY ',' ESCAPED BY '' " +
                "LINES TERMINATED BY '\\n' IGNORE 1 LINES;