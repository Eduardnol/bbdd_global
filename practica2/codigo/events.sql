USE f1_olap;
SET GLOBAL event_scheduler = ON;

DELIMITER $$
DROP EVENT IF EXISTS insertion_event;
CREATE EVENT insertion_event
    ON SCHEDULE EVERY 1 DAY STARTS '2020-07-05 14:24:00'
    DO
    BEGIN
        CREATE TABLE IF NOT EXISTS log
        (
            id                int AUTO_INCREMENT,
            fecha             DATETIME,
            importation_error BOOL,
            PRIMARY KEY (id)
        );
        INSERT INTO log (fecha, importation_error) VALUES (NOW(), 'Evento 1');

    END $$

DELIMITER ;