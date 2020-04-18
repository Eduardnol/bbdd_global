--#&&
COPY Apartment
    FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\practica1\fase1\Fitxers P1-20191029\Apartments.csv' DELIMITER ',' QUOTE '"' CSV HEADER;
--Vamos A Evitar Las repeticiones masa básicas
UPDATE Apartment
SET state = UPPER(state);
UPDATE Apartment
SET state = 'VIC'
WHERE state LIKE '%VI%';
UPDATE Apartment
SET city = INITCAP(city);
UPDATE Apartment
SET city = TRIM(city);
UPDATE Apartment
SET city = '%'
WHERE city LIKE '%,';


--#&&
COPY Host_T
    FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\practica1\fase1\Fitxers P1-20191029\Hosts.csv' DELIMITER ',' QUOTE '"' CSV HEADER;
--#&&
COPY Review
    FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\practica1\fase1\Fitxers P1-20191029\Review.csv' DELIMITER ',' QUOTE '"' CSV HEADER;

--#&&
INSERT INTO Money(price, weekly_price, monthly_price, listing_url)
SELECT price, weekly_price, monthly_price, listing_url
FROM Apartment;

--#&&
INSERT INTO Info(security_deposit, cleaning_fee, minimum_nights, maximum_nights, listing_url)
SELECT security_deposit, cleaning_fee, minimum_nights, maximum_nights, listing_url
FROM Apartment;
--#&&
INSERT INTO PropertyType(nom)
SELECT DISTINCT (Apartment.property_type)
FROM Apartment;
--Escogemos solamente un valor por cada tipo de propiedad y se le va a asignar un id

--#&&
INSERT INTO Properties(accomodates, bathrooms, beds, square_feet, id_apartment, id_type)
SELECT accomodate, bathroom, beds, square_feet, listing_url, id_type
FROM Apartment,
     PropertyType
WHERE propertytype.nom = Apartment.property_type;
--A cada propiedad le pondremos el id_propiedad que le corresponda de acuerdo con el nombre de esta en la tabla


--#&&
--SELECT regexp_split_to_table(apartment.amenities, '}') FROM apartment;

--#&&
INSERT INTO Country (id_country, nom)
SELECT DISTINCT (country_code), country
FROM Apartment;
--Agruparemos la tabla para tener los valores juntos de cada país
--#&&
INSERT INTO State (nom, id_country)
SELECT DISTINCT (Apartment.state), Country.id_country
FROM Apartment
         NATURAL JOIN Country;

--#&&
INSERT INTO City (nom, id_state)
SELECT DISTINCT (a.city), id_state
FROM Apartment AS a,
     State AS s
WHERE s.nom = a.state
GROUP BY a.city, id_state;


--#&&
ALTER TABLE Apartment
    DROP COLUMN id_apartment;
--#&&
ALTER TABLE Apartment
    ADD id_neighbourhood INT;
--#&&
ALTER TABLE Apartment
    ADD FOREIGN KEY (id_neighbourhood) REFERENCES Neighbourhood (id_neighbourhood);
--Creamos una llave foranea para Apartment que tenga neighbourhood


--#&&
INSERT INTO Neighbourhood(nom, id_city)
SELECT neighbourhood, id_city
FROM Apartment,
     City
WHERE city.nom = Apartment.city
GROUP BY neighbourhood, id_city;

ALTER TABLE apartment
    ADD id_host varchar;
--ALTER TABLE apartment ADD FOREIGN KEY (id_host) REFERENCES host_t(host_url);


---------------------------------------------------------------------------------------------------------------------------------------------
--#&&
UPDATE apartment
SET id_neighbourhood = neighbourhood.id_neighbourhood
FROM neighbourhood,
     city
WHERE apartment.neighbourhood = neighbourhood.nom
  AND apartment.city = city.nom
  AND city.id_city = neighbourhood.id_city;



UPDATE apartment
SET id_host = host_t.host_url
FROM host_t
WHERE host_t.listing_url = apartment.listing_url;

--#&&
INSERT INTO Reviewer(id_reviewer, reviewer_name)
SELECT DISTINCT(r.id_reviewer), r.reviewer_name
FROM Review AS r,
     Apartment AS a
WHERE r.listing_url = a.listing_url
GROUP BY (r.id_reviewer, r.reviewer_name);

ALTER TABLE Review
    ADD FOREIGN KEY (id_reviewer) REFERENCES Reviewer (id_reviewer);


--#&&
INSERT INTO reviews(id_reviewer, id_apartment)
SELECT review.id_reviewer, apartment.listing_url
FROM Reviewer,
     review,
     apartment
WHERE review.listing_url = apartment.listing_url
  AND reviewer.id_reviewer = review.id_reviewer;


--DROPS

ALTER TABLE Apartment
    DROP COLUMN picture_url;
--ALTER TABLE Apartment DROP COLUMN street;
ALTER TABLE Apartment
    DROP COLUMN neighbourhood;
ALTER TABLE Apartment
    DROP COLUMN city;
ALTER TABLE Apartment
    DROP COLUMN state;
ALTER TABLE Apartment
    DROP COLUMN zipcode;
ALTER TABLE Apartment
    DROP COLUMN country_code;
ALTER TABLE Apartment
    DROP COLUMN country;
ALTER TABLE Apartment
    DROP COLUMN property_type;
ALTER TABLE Apartment
    DROP COLUMN accomodate;
ALTER TABLE Apartment
    DROP COLUMN bathroom;
ALTER TABLE Apartment
    DROP COLUMN bedrooms;
ALTER TABLE Apartment
    DROP COLUMN beds;
--ALTER TABLE Apartment DROP COLUMN amenities;
ALTER TABLE Apartment
    DROP COLUMN square_feet;
ALTER TABLE Apartment
    DROP COLUMN price;
ALTER TABLE Apartment
    DROP COLUMN weekly_price;
ALTER TABLE Apartment
    DROP COLUMN monthly_price;
ALTER TABLE Apartment
    DROP COLUMN security_deposit;
ALTER TABLE Apartment
    DROP COLUMN cleaning_fee;
ALTER TABLE Apartment
    DROP COLUMN minimum_nights;
ALTER TABLE Apartment
    DROP COLUMN maximum_nights;
UPDATE money
set monthly_price = replace(monthly_price, '$', '');
UPDATE money
set price = replace(price, '$', '');
UPDATE money
set weekly_price = replace(weekly_price, '$', '');
UPDATE money
set monthly_price = replace(monthly_price, ',', '');
UPDATE money
set price = replace(price, ',', '');
UPDATE money
set weekly_price = replace(weekly_price, ',', '');


SELECT *
FROM host_info
where host_response_rate like 'N/A';



UPDATE info
SET security_deposit = replace(security_deposit, '$', '');
UPDATE info
SET cleaning_fee = replace(cleaning_fee, '$', '');
UPDATE info
SET security_deposit = replace(security_deposit, ',', '');
UPDATE info
SET cleaning_fee = replace(cleaning_fee, ',', '');
ALTER TABLE info
    ALTER COLUMN cleaning_fee TYPE float4 USING cleaning_fee::float;
ALTER TABLE info
    ALTER COLUMN security_deposit TYPE float4 USING security_deposit::float;



ALTER TABLE money
    ALTER COLUMN monthly_price TYPE float4 USING monthly_price::float;
ALTER TABLE money
    ALTER COLUMN price TYPE float4 USING price::float;
ALTER TABLE money
    ALTER COLUMN weekly_price TYPE float4 USING weekly_price::float;

INSERT INTO Host(host_url, host_name, host_since, host_about)
SELECT DISTINCT (host_url), host_name, host_since, host_about
FROM Host_T;

--#&&
INSERT INTO Host_Info(id_host, host_picture_url, host_response_rate, host_is_superhost, host_listings_count,
                      host_verifications, host_identity_verified)
SELECT h.host_url,
       h.host_picture_url,
       h.host_response_rate,
       h.host_is_superhost,
       h.host_listings_count,
       h.host_verifications,
       h.host_identity_verified
FROM Host_T as h
GROUP BY (host_url, host_picture_url, host_response_rate, host_is_superhost, host_listings_count, host_verifications,
          host_identity_verified);

UPDATE host_info
set host_response_rate = replace(host_response_rate, RIGHT(host_response_rate, 1), '');
UPDATE host_info
set host_response_rate = replace(host_response_rate, 'N/', '0');

ALTER TABLE Host_T
    DROP COLUMN name;
ALTER TABLE Host_T
    DROP COLUMN listing_url;
ALTER TABLE Host_T
    DROP COLUMN description;
ALTER TABLE Host_T
    DROP COLUMN picture_url;
ALTER TABLE Host_T
    DROP COLUMN host_response_time;
ALTER TABLE Host_T
    DROP COLUMN host_response_rate;
ALTER TABLE Host_T
    DROP COLUMN host_is_superhost;
ALTER TABLE Host_T
    DROP COLUMN host_picture_url;
ALTER TABLE Host_T
    DROP COLUMN host_listings_count;
ALTER TABLE Host_T
    DROP COLUMN host_verifications;
ALTER TABLE Host_T
    DROP COLUMN host_identity_verified;

DROP TABLE Host_T;

ALTER TABLE Review
    DROP COLUMN id_apartment;
ALTER TABLE Review
    DROP COLUMN listing_url;
ALTER TABLE Review
    DROP COLUMN name;
ALTER TABLE Review
    DROP COLUMN description;
ALTER TABLE Review
    DROP COLUMN picture_url;
ALTER TABLE Review
    DROP COLUMN street;
ALTER TABLE Review
    DROP COLUMN neighbourhood_cleansed;
ALTER TABLE Review
    DROP COLUMN city;
ALTER TABLE Review
    DROP COLUMN reviewer_name;

