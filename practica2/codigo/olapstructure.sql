drop database IF EXISTS f1_olap;
create database f1_olap;

use f1_olap;

drop table if exists circuits cascade;
create table circuits
(
    raceId     int          default 0,
    circuitId  int          default -1,
    circuitRef varchar(255) default null,
    name       varchar(255) default null,
    location   varchar(255) default null,
    country    varchar(255) default null,
    lat        float        default null,
    lng        float        default null,
    alt        int          default null,
    url        varchar(255) default null,
    year       int          default 0,
    round      int          default null,
    name_race  varchar(255) default null,
    date       date         default null,
    time       time         default null,
    url_race   varchar(255) default null,
    url_season varchar(255) default null,

    primary key (raceId, circuitId, year)


);

create table constructors
(

    constructorId  int,
    constructorRef varchar(255) default null,
    name           varchar(255) default null,
    nationality    varchar(255) default null,
    url            varchar(255) default null,
    primary key (constructorId)

);



create table drivers
(
    driverId    int,
    driverRef   varchar(255) default null,
    number      int          default null,
    code        varchar(3)   default null,
    forename    varchar(255) default null,
    surname     varchar(255) default null,
    dob         date         default null,
    nationality varchar(255) default null,
    url         varchar(255) default null,
    primary key (driverId)
);


drop table if exists results;
create table results
(
    resultId                    int          default 0,

    raceId                      int          default -1,
    driverId                    int          default -2,
    constructorId               int          default -3,
    number                      int          default null,
    grid                        int          default null,
    position                    int          default null,
    positionText                varchar(255) default null,
    positionOrder               int          default null,
    points                      float        default null,
    laps                        int          default null,
    time                        varchar(255) default null,
    milliseconds                int          default null,
    fastestLap                  int          default null,
    `rank`                      int          default null,
    fastestLapTime              varchar(255) default null,
    fastestLapSpeed             varchar(255) default null,

    status                      varchar(255) default null,
    position_qual               int          default null,
    q1                          varchar(255) default null,
    q2                          varchar(255) default null,
    q3                          varchar(255) default null,
    points_constructor          float        default null,
    status_constructor          varchar(255) default null,


    points_driver               float        default null,
    position_driver             int          default null,
    positionText_driver         varchar(255) default null,
    wins_driver                 int          default null,


    points_constructor_standing float        default null,
    position_constructor        int          default null,
    positionText_constructor    varchar(255) default null,
    wins                        int          default null,

    primary key (resultId, raceId, driverId, constructorId),
    foreign key (raceId) references circuits (raceId),
    foreign key (driverId) references drivers (driverId),
    foreign key (constructorId) references constructors (constructorId)


);


create table lapTimes
(
    raceId               int          default 0,
    driverId             int          default -2,
    lap                  int          default -1,
    position             int          default null,
    time                 varchar(255) default null,
    milliseconds         int          default null,
    stop                 int          default null,
    time_pitstop         int          default null,
    duration             varchar(255) default null,
    milliseconds_pitstop int          default null,

    primary key (raceId, driverId, lap),
    foreign key (raceId) references circuits (raceId),
    foreign key (driverId) references drivers (driverId)
);



