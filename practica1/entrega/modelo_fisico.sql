DROP TABLE IF EXISTS Apartment_Import CASCADE;
DROP TABLE IF EXISTS Host_Import CASCADE;
DROP TABLE IF EXISTS Review_Import CASCADE;


CREATE TABLE Apartment_Import
(
    id_apartment     int,
    listing_url      varchar,
    name             varchar,
    description      text,
    picture_url      varchar,
    street           varchar,
    neighbourhood    varchar,
    city             varchar,
    state            varchar,
    zipcode          varchar,
    country_code     varchar,
    country          varchar,
    property_type    varchar,
    accomodate       int,
    bathroom         float,
    bedrooms         int,
    beds             int,
    amenities        TEXT,
    square_feet      float,
    price            varchar,
    weekly_price     varchar,
    monthly_price    varchar,
    security_deposit varchar,
    cleaning_fee     varchar,
    minimum_nights   float,
    maximum_nights   float,
    primary key (listing_url)

);

CREATE TABLE Host_Import
(
    -- id_host SERIAL,
    listing_url            varchar,
    name                   varchar,
    description            text,
    picture_url            varchar,
    host_id                integer,
    host_url               varchar,
    host_name              varchar,
    host_since             DATE,
    host_about             text,
    host_response_time     varchar,
    host_response_rate     varchar,
    host_is_superhost      boolean,
    host_picture_url       varchar,
    host_listings_count    int,
    host_verifications     text,
    host_identity_verified boolean

);

CREATE TABLE Review_Import
(
    id_apartment           integer,
    listing_url            varchar,
    name                   varchar,
    description            text,
    picture_url            varchar,
    street                 varchar,
    neighbourhood_cleansed varchar,
    city                   varchar,
    date_review            DATE,
    id_reviewer            int,
    reviewer_name          varchar,
    comments               text
);


DROP TABLE IF EXISTS Money CASCADE;
DROP TABLE IF EXISTS Info CASCADE;
DROP TABLE IF EXISTS Amenities CASCADE;
DROP TABLE IF EXISTS PropertyType CASCADE;
DROP TABLE IF EXISTS Properties CASCADE;
DROP TABLE IF EXISTS Apartment CASCADE;
DROP TABLE IF EXISTS Country CASCADE;
DROP TABLE IF EXISTS State CASCADE;
DROP TABLE IF EXISTS City CASCADE;
DROP TABLE IF EXISTS Neighbourhood CASCADE;
DROP TABLE IF EXISTS Street CASCADE;
DROP TABLE IF EXISTS Localitzada CASCADE;
DROP TABLE IF EXISTS Reviewer CASCADE;
DROP TABLE IF EXISTS Reviews CASCADE;
DROP TABLE IF EXISTS Host_T CASCADE;
DROP TABLE IF EXISTS Host_Info CASCADE;
DROP TABLE IF EXISTS Host CASCADE;
DROP TABLE IF EXISTS Review CASCADE;
DROP TABLE IF EXISTS Amenities CASCADE;
DROP TABLE IF EXISTS AmenitiesApartment CASCADE;
DROP TABLE IF EXISTS verifications CASCADE;
DROP TABLE IF EXISTS host_verifications CASCADE;





CREATE TABLE Country
(
    id_country varchar,
    nom        varchar,
    PRIMARY KEY (id_country)
);

CREATE TABLE State
(
    id_state   SERIAL,
    nom        varchar,
    id_country varchar,
    PRIMARY KEY (id_state),
    FOREIGN KEY (id_country) REFERENCES Country (id_country)
);

CREATE TABLE City
(
    id_city  SERIAL,
    nom      varchar,
    id_state int,
    PRIMARY KEY (id_city),
    FOREIGN KEY (id_state) REFERENCES State (id_state)
);

CREATE TABLE Neighbourhood
(
    id_neighbourhood SERIAL,
    nom              varchar,
    id_city          integer,
    PRIMARY KEY (id_neighbourhood),
    FOREIGN KEY (id_city) REFERENCES City (id_city)
);
CREATE TABLE Host
(
    host_url   varchar,
    host_name  varchar,
    host_since DATE,
    host_about TEXT,
    PRIMARY KEY (host_url)
);

CREATE TABLE Apartment
(
    listing_url      varchar(255),
    name             varchar(255),
    description      text,
    id_neighbourhood int,
    id_host          varchar(255),
    street           varchar(255),
    PRIMARY KEY (listing_url),
    FOREIGN KEY (id_host) REFERENCES Host (host_url),
    FOREIGN KEY (id_neighbourhood) REFERENCES Neighbourhood (id_neighbourhood)
);

CREATE TABLE Reviewer
(
    id_reviewer   SERIAL,
    reviewer_name varchar,
    PRIMARY KEY (id_reviewer)
);

CREATE TABLE Review
(
    id_review   SERIAL,
    id_reviewer INT,
    date_review DATE,
    comments    text,
    PRIMARY KEY (id_review),
    FOREIGN KEY (id_reviewer) REFERENCES reviewer (id_reviewer)
);

CREATE TABLE Money
(
    id_money      SERIAL,
    price         varchar,
    weekly_price  varchar,
    monthly_price varchar,
    listing_url   varchar,
    PRIMARY KEY (id_money),
    FOREIGN KEY (listing_url) REFERENCES Apartment (listing_url)
);

CREATE TABLE Info
(
    id_info          SERIAL,
    security_deposit varchar,
    cleaning_fee     varchar,
    minimum_nights   int,
    maximum_nights   int,
    listing_url      varchar,
    PRIMARY KEY (id_info),
    FOREIGN KEY (listing_url) REFERENCES Apartment (listing_url)

);

CREATE TABLE PropertyType
(
    id_type SERIAL,
    nom     varchar,
    PRIMARY KEY (id_type)
);

CREATE TABLE Properties
(
    id_properties SERIAL,
    accomodates   int,
    bathrooms     float,
    beds          int,
    square_feet   float,
    id_apartment  varchar,
    id_type       int,
    PRIMARY KEY (id_properties),
    FOREIGN KEY (id_apartment) REFERENCES Apartment (listing_url),
    FOREIGN KEY (id_type) REFERENCES PropertyType (id_type)
);

-- CREATE TABLE Amenities
-- (
--     id_amenities  SERIAL,
--     nombre        varchar,
--     id_properties int,
--     PRIMARY KEY (id_amenities),
--     FOREIGN KEY (id_properties) REFERENCES Properties (id_properties)
--
-- );

CREATE TABLE Reviews
(
    id_reviews   SERIAL,
    id_reviewer  int,
    id_apartment varchar,
    PRIMARY KEY (id_reviews),
    FOREIGN KEY (id_apartment) REFERENCES Apartment (listing_url),
    FOREIGN KEY (id_reviewer) REFERENCES Reviewer (id_reviewer)
);

CREATE TABLE Host_Info
(
    id_host_info           SERIAL,
    id_host                varchar,
    host_picture_url       varchar,
    host_response_rate     varchar(4),
    host_is_superhost      boolean,
    host_listings_count    int,
    host_identity_verified boolean,
    PRIMARY KEY (id_host_info),
    FOREIGN KEY (id_host) REFERENCES Host (host_url)

);
CREATE TABLE Amenities
(
    id   SERIAL,
    name varchar(255),
    PRIMARY KEY (id)
);

CREATE TABLE AmenitiesApartment
(
    id_amenities  int,
    id_apartments varchar(255),
    PRIMARY KEY (id_amenities, id_apartments),
    FOREIGN KEY (id_apartments) REFERENCES apartment(listing_url),
    FOREIGN KEY (id_amenities) REFERENCES amenities(id)
);


CREATE TABLE verifications
(
    id_verification   SERIAL,
    verification_name varchar(255),
    PRIMARY KEY (id_verification)
);


CREATE TABLE host_verifications
(
    id_verification int,
    id_host         varchar(255),
    PRIMARY KEY (id_verification, id_host),
    FOREIGN KEY (id_verification) references verifications (id_verification),
    FOREIGN KEY (id_host) references host (host_url)
);