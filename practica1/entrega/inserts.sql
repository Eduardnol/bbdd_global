--#&&
COPY Apartment_Import
    FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\practica1\fase1\Fitxers P1-20191029\Apartments.csv' DELIMITER ',' QUOTE '"' CSV HEADER;
-- Vamos A Evitar Las repeticiones masa básicas
UPDATE Apartment_Import
SET state = UPPER(state);
UPDATE Apartment_Import
SET state = 'VIC'
WHERE state LIKE '%VI%';
UPDATE Apartment_Import
SET city = INITCAP(city);
UPDATE Apartment_Import
SET city = TRIM(city);
UPDATE Apartment_Import
SET city = '%'
WHERE city LIKE '%,';


--#&&
COPY Host_Import
    FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\practica1\fase1\Fitxers P1-20191029\Hosts.csv' DELIMITER ',' QUOTE '"' CSV HEADER;
--#&&
COPY Review_Import
    FROM 'D:\OneDrive\Estudios\uni\Curso_2\bbdd\practica1\fase1\Fitxers P1-20191029\Review.csv' DELIMITER ',' QUOTE '"' CSV HEADER;


--#&&
INSERT INTO Country (id_country, nom)
SELECT DISTINCT (country_code), country
FROM Apartment_Import;

--#&&º
INSERT INTO State (nom, id_country)
SELECT a.state, c.id_country
FROM Apartment_Import AS a,
     country AS c
WHERE c.nom = a.country
GROUP BY a.state, c.id_country;

--#&&
INSERT INTO City (nom, id_state)
SELECT a.city, s.id_state
FROM Apartment_Import AS a,
     State AS s
WHERE s.nom = a.state
   OR s.nom is null
GROUP BY a.city, id_state;

--#&&
INSERT INTO Neighbourhood(nom, id_city)
SELECT a.neighbourhood, c.id_city
FROM Apartment_Import AS a,
     City AS c
WHERE c.nom = a.city
GROUP BY neighbourhood, id_city;

--#&&
INSERT INTO Reviewer(id_reviewer, reviewer_name)
SELECT DISTINCT(r.id_reviewer), r.reviewer_name
FROM Review_Import AS r,
     Apartment_Import AS a
WHERE r.listing_url = a.listing_url
GROUP BY (r.id_reviewer, r.reviewer_name);

--#&&
INSERT INTO host (host_url, host_name, host_since, host_about)
SELECT hi.host_url, hi.host_name, hi.host_since, hi.host_about
FROM host_import AS hi
GROUP BY hi.host_url, hi.host_name, hi.host_since, hi.host_about;


--#&&
INSERT INTO apartment (listing_url, name, description, id_neighbourhood, id_host, street)
SELECT ai.listing_url, ai.name, ai.description, n.id_neighbourhood, h.host_url, ai.street
FROM apartment_import AS ai,
     host_import AS h,
     neighbourhood AS n,
     city AS c,
     state AS s
WHERE ai.listing_url = h.listing_url
  AND ai.neighbourhood = n.nom
  AND ai.city = c.nom
  AND c.id_city = n.id_city
  AND (ai.state = s.nom OR (s.nom is null AND ai.state is null))
  AND s.id_state = c.id_state;

-- UPDATE apartment
-- SET id_neighbourhood = neighbourhood.id_neighbourhood
-- FROM neighbourhood,
--      city,
--      apartment_import,
--      state AS s
-- WHERE apartment_import.neighbourhood = neighbourhood.nom
--   AND apartment_import.city = city.nom
--   AND city.id_city = neighbourhood.id_city
--   AND (apartment_import.state = s.nom OR (s.nom is null AND apartment_import.state is null))
--   AND s.id_state = city.id_state;

--#&&
INSERT INTO review (id_reviewer, date_review, comments)
SELECT ri.id_reviewer, ri.date_review, ri.comments
FROM review_import AS ri;

--#&&
INSERT INTO Money(price, weekly_price, monthly_price, listing_url)
SELECT price, weekly_price, monthly_price, listing_url
FROM Apartment_Import;

--#&&
INSERT INTO Info(security_deposit, cleaning_fee, minimum_nights, maximum_nights, listing_url)
SELECT security_deposit, cleaning_fee, minimum_nights, maximum_nights, listing_url
FROM Apartment_Import;

--#&&
INSERT INTO PropertyType(nom)
SELECT DISTINCT (Apartment_Import.property_type)
FROM Apartment_Import;

--#&&
INSERT INTO Properties(accomodates, bathrooms, beds, square_feet, id_apartment, id_type)
SELECT accomodate, bathroom, beds, square_feet, listing_url, id_type
FROM Apartment_Import,
     PropertyType
WHERE propertytype.nom = Apartment_Import.property_type;

--#&&
INSERT INTO reviews(id_reviewer, id_apartment)
SELECT ri.id_reviewer, a.listing_url
FROM Reviewer,
     review_import AS ri,
     apartment_import AS a
WHERE ri.listing_url = a.listing_url
  AND reviewer.id_reviewer = ri.id_reviewer;


--#&&
INSERT INTO Host_Info(id_host, host_picture_url, host_response_rate, host_is_superhost, host_listings_count,
                      host_identity_verified)
SELECT h.host_url,
       h.host_picture_url,
       h.host_response_rate,
       h.host_is_superhost,
       h.host_listings_count,
       h.host_identity_verified
FROM host_import as h
GROUP BY (host_url, host_picture_url, host_response_rate, host_is_superhost, host_listings_count, host_verifications,
          host_identity_verified);

UPDATE host_info
set host_response_rate = replace(host_response_rate, RIGHT(host_response_rate, 1), '');
UPDATE host_info
set host_response_rate = replace(host_response_rate, 'N/', '0');


--#&&
UPDATE apartment_import
SET amenities = replace(amenities, '"', '');

UPDATE apartment_import
SET amenities = replace(amenities, '{', '');

UPDATE apartment_import
SET amenities = replace(amenities, '}', '');

UPDATE apartment_import
SET amenities = replace(amenities, ' ', '');


--#&&
INSERT INTO amenities(name)
SELECT DISTINCT regexp_split_to_table(a.amenities, ',')
FROM apartment_import AS a;

--#&&
INSERT INTO amenitiesapartment(id_amenities, id_apartments)
SELECT am.id, a.listing_url
FROM apartment_import AS a,
     amenities AS am
WHERE a.amenities LIKE '%' || am.name || '%';


--#&&
UPDATE host_import
SET host_verifications = replace(host_verifications, '''', '');

UPDATE host_import
SET host_verifications = replace(host_verifications, '[', '');

UPDATE host_import
SET host_verifications = replace(host_verifications, ']', '');

UPDATE host_import
SET host_verifications = replace(host_verifications, ' ', '');


--#&&
INSERT INTO verifications (verification_name)
SELECT DISTINCT regexp_split_to_table(h.host_verifications, ',')
FROM host_import AS h;

--#&&
INSERT INTO host_verifications(id_verification, id_host)
SELECT v.id_verification, h.host_url
FROM verifications AS v,
     host_import AS h
WHERE h.host_verifications LIKE '%' || v.verification_name || '%'
GROUP BY  v.id_verification, h.host_url;


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


-- SELECT *
-- FROM host_info
-- where host_response_rate like 'N/A';


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
