USE movies;

#BORRAR
DROP TABLE IF EXISTS movie_modificado;
CREATE table movie_modificado
(
    id                     INT AUTO_INCREMENT,
    m_id_movie             INT,
    m_title                VARCHAR(511),
    m_id_director          INT,
    m_year                 INT,
    m_duration             INT,
    m_country              VARCHAR(511),
    m_movie_facebook_likes INT,
    m_imdb_score           REAL,
    m_gross                BIGINT,
    m_budget               BIGINT,
    m_modificado           BOOL, #marca si es modificado o insertado para cuando lo guardemos en el fichero de texto
    PRIMARY KEY (id)
);
#BORRAR

################################################  PROCEDURES  ################################################
DELIMITER $$

DROP PROCEDURE IF EXISTS insertUpdates $$
CREATE PROCEDURE insertUpdates(IN id_movie INT, IN title VARCHAR(255), IN id_director INT, IN year INT,
                               IN duration INT, IN country VARCHAR(255), IN movie_facebook_likes INT,
                               IN imdb_score FLOAT, IN gross INT, IN budget INT, IN modificado BOOL)
BEGIN

    INSERT INTO movie_modificado (m_id_movie, m_title, m_id_director, m_year, m_duration, m_country, m_movie_facebook_likes, m_imdb_score, m_gross, m_budget, m_modificado)
    VALUES (id_movie, title, id_director, year, duration, country, movie_facebook_likes, imdb_score, gross, budget,
            modificado);

END
$$
DELIMITER ;



# DELIMITER $$
# DROP PROCEDURE IF EXISTS writeFile $$
# CREATE PROCEDURE writeFile()
# BEGIN
#     SELECT *
#       INTO OUTFILE SELECT CONCAT('/path/to/', ADD DATE , '.txt');
#         FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
#         LINES TERMINATED BY '\n'
#       FROM movie_modificado;
# END $$


################################################  TRIGGER  ################################################
DELIMITER $$
DROP TRIGGER IF EXISTS modificades $$
CREATE TRIGGER modificades
    AFTER UPDATE
    ON movie
    FOR EACH ROW
BEGIN
    #Buscamos los campos que han cambiado
    CALL insertUpdates(OLD.id_movie, OLD.title, OLD.id_director, OLD.year,
                       OLD.duration, OLD.country, OLD.movie_facebook_likes,
                       OLD.imdb_score, OLD.gross, OLD.budget, true);


END;
$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS anadidos $$
CREATE TRIGGER anadidos
    AFTER INSERT
    ON movie
    FOR EACH ROW
BEGIN

    #Buscamos los campos que se han añadido y los añadimos a nuestra tabla provisional
    CALL insertUpdates(NEW.id_movie, NEW.title, NEW.id_director, NEW.year,
                       NEW.duration, NEW.country, NEW.movie_facebook_likes,
                       NEW.imdb_score, NEW.gross, NEW.budget, false);

END;
$$
DELIMITER ;


################################################  EVENTS  ################################################
DELIMITER $$
DROP EVENT IF EXISTS canvis;
CREATE EVENT canvis
    ON SCHEDULE
        EVERY 1 DAY
            STARTS '2020-04-04 11:30:00'
    ON COMPLETION PRESERVE
    COMMENT 'Cada dia a las 11:00 guarda una copia'
    DO BEGIN
    #Creación del fichero


    DROP TABLE IF EXISTS movie_modificado;
    CREATE table movie_modificado
    (
        id                     INT AUTO_INCREMENT,
        m_id_movie             INT,
        m_title                VARCHAR(511),
        m_id_director          INT,
        m_year                 INT,
        m_duration             INT,
        m_country              VARCHAR(511),
        m_movie_facebook_likes INT,
        m_imdb_score           REAL,
        m_gross                BIGINT,
        m_budget               BIGINT,
        m_modificado           BOOL, #marca si es modificado o insertado para cuando lo guardemos en el fichero de texto
        PRIMARY KEY (id)
    );

END $$
DELIMITER ;

