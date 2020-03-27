




DELIMITER €€

SELECT * FROM table;
SELECT * FROM table;
SELECT * FROM table;
SELECT * FROM table;

€€



DELIMITER $$

DROP PROCEDURE IF EXISTS getId $$

CREATE PROCEDURE getId(IN id_card_in VARCHAR(5), OUT id_person_out INT)
begin

 SET id_person_out = (SELECT id_person
                         FROM persona p
                         WHERE p.id_card = id_card_in));

 IF bla THEN
 
  bla bla bla 
 
 END IF;

end $$





