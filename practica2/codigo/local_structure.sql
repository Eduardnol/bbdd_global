drop database if exists f1;
create database f1;

use f1;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 'ON';

drop table if exists circuits;

create table circuits
(
    circuitId  int auto_increment
        primary key,
    circuitRef varchar(255) default null,
    name       varchar(255) default null,
    location   varchar(255) default null,
    country    varchar(255) default null,
    lat        float        default null,
    lng        float        default null,
    alt        int          default null,
    url        varchar(255) default null,
    constraint url
        unique (url)
);

create table constructorResults
(
    constructorResultsId int auto_increment
        primary key,
    raceId               int          default null,
    constructorId        int          default null,
    points               float        default null,
    status               varchar(255) default null
);

create table constructorStandings
(
    constructorStandingsId int auto_increment
        primary key,
    raceId                 int          default null,
    constructorId          int          default null,
    points                 float        default null,
    position               int          default null,
    positionText           varchar(255) default null,
    wins                   int          default null
);

create table constructors
(
    constructorId  int auto_increment
        primary key,
    constructorRef varchar(255) default null,
    name           varchar(255) default null,
    nationality    varchar(255) default null,
    url            varchar(255) default null,
    constraint name
        unique (name)
);

create table driverStandings
(
    driverStandingsId int auto_increment
        primary key,
    raceId            int          default null,
    driverId          int          default null,
    points            float        default null,
    position          int          default null,
    positionText      varchar(255) default null,
    wins              int          default null
);

create table drivers
(
    driverId    int auto_increment
        primary key,
    driverRef   varchar(255) default null,
    number      int          default null,
    code        varchar(3)   default null,
    forename    varchar(255) default null,
    surname     varchar(255) default null,
    dob         date         default null,
    nationality varchar(255) default null,
    url         varchar(255) default null,
    constraint url
        unique (url)
);

create table lapTimes
(
    raceId       int not null,
    driverId     int not null,
    lap          int not null,
    position     int          default null,
    time         varchar(255) default null,
    milliseconds int          default null,
    primary key (raceId, driverId, lap)
);


create table pitStops
(
    raceId       int not null,
    driverId     int not null,
    stop         int not null,
    lap          int          default null,
    time         time         default null,
    duration     varchar(255) default null,
    milliseconds int          default null,
    primary key (raceId, driverId, stop)
);


create table qualifying
(
    qualifyId     int auto_increment
        primary key,
    raceId        int          default null,
    driverId      int          default null,
    constructorId int          default null,
    number        int          default null,
    position      int          default null,
    q1            varchar(255) default null,
    q2            varchar(255) default null,
    q3            varchar(255) default null
);

create table races
(
    raceId    int auto_increment
        primary key,
    year      int          default null,
    round     int          default null,
    circuitId int          default null,
    name      varchar(255) default null,
    date      date         default null,
    time      time         default null,
    url       varchar(255) default null,
    constraint url
        unique (url)
);


create table results
(
    resultId        int auto_increment
        primary key,
    raceId          int          default null,
    driverId        int          default null,
    constructorId   int          default null,
    number          int          default null,
    grid            int          default null,
    position        int          default null,
    positionText    varchar(255) default null,
    positionOrder   int          default null,
    points          float        default null,
    laps            int          default null,
    time            varchar(255) default null,
    milliseconds    int          default null,
    fastestLap      int          default null,
    `rank`          int          default null,
    fastestLapTime  varchar(255) default null,
    fastestLapSpeed varchar(255) default null,
    statusId        int          default null
);


create table seasons
(
    year int
        primary key,
    url  varchar(255) default null,
    constraint url
        unique (url)
);


create table status
(
    statusId int auto_increment
        primary key,
    status   varchar(255) default null
);

