use f1;

drop table if exists circuits;

create table circuits
(
    circuitId  int auto_increment
        primary key,
    circuitRef varchar(255) default '' not null,
    name       varchar(255) default '' not null,
    location   varchar(255)            null,
    country    varchar(255)            null,
    lat        float                   null,
    lng        float                   null,
    alt        int                     null,
    url        varchar(255) default '' not null,
    constraint url
        unique (url)
);

create table constructorResults
(
    constructorResultsId int auto_increment
        primary key,
    raceId               int default 0 not null,
    constructorId        int default 0 not null,
    points               float         null,
    status               varchar(255)  null
);

create table constructorStandings
(
    constructorStandingsId int auto_increment
        primary key,
    raceId                 int   default 0 not null,
    constructorId          int   default 0 not null,
    points                 float default 0 not null,
    position               int             null,
    positionText           varchar(255)    null,
    wins                   int   default 0 not null
);

create table constructors
(
    constructorId  int auto_increment
        primary key,
    constructorRef varchar(255) default '' not null,
    name           varchar(255) default '' not null,
    nationality    varchar(255)            null,
    url            varchar(255) default '' not null,
    constraint name
        unique (name)
);

create table driverStandings
(
    driverStandingsId int auto_increment
        primary key,
    raceId            int   default 0 not null,
    driverId          int   default 0 not null,
    points            float default 0 not null,
    position          int             null,
    positionText      varchar(255)    null,
    wins              int   default 0 not null
);

create table drivers
(
    driverId    int auto_increment
        primary key,
    driverRef   varchar(255) default '' not null,
    number      int                     null,
    code        varchar(3)              null,
    forename    varchar(255) default '' not null,
    surname     varchar(255) default '' not null,
    dob         date                    null,
    nationality varchar(255)            null,
    url         varchar(255) default '' not null,
    constraint url
        unique (url)
);

create table lapTimes
(
    raceId       int          not null,
    driverId     int          not null,
    lap          int          not null,
    position     int          null,
    time         varchar(255) null,
    milliseconds int          null,
    primary key (raceId, driverId, lap)
);


create table pitStops
(
    raceId       int          not null,
    driverId     int          not null,
    stop         int          not null,
    lap          int          not null,
    time         time         not null,
    duration     varchar(255) null,
    milliseconds int          null,
    primary key (raceId, driverId, stop)
);


create table qualifying
(
    qualifyId     int auto_increment
        primary key,
    raceId        int default 0 not null,
    driverId      int default 0 not null,
    constructorId int default 0 not null,
    number        int default 0 not null,
    position      int           null,
    q1            varchar(255)  null,
    q2            varchar(255)  null,
    q3            varchar(255)  null
);

create table races
(
    raceId    int auto_increment
        primary key,
    year      int          default 0            not null,
    round     int          default 0            not null,
    circuitId int          default 0            not null,
    name      varchar(255) default ''           not null,
    date      date         default '0000-00-00' not null,
    time      time                              null,
    url       varchar(255)                      null,
    constraint url
        unique (url)
);


create table results
(
    resultId        int auto_increment
        primary key,
    raceId          int          default 0  not null,
    driverId        int          default 0  not null,
    constructorId   int          default 0  not null,
    number          int                     null,
    grid            int          default 0  not null,
    position        int                     null,
    positionText    varchar(255) default '' not null,
    positionOrder   int          default 0  not null,
    points          float        default 0  not null,
    laps            int          default 0  not null,
    time            varchar(255)            null,
    milliseconds    int                     null,
    fastestLap      int                     null,
    `rank`          int          default 0  null,
    fastestLapTime  varchar(255)            null,
    fastestLapSpeed varchar(255)            null,
    statusId        int          default 0  not null
);


create table seasons
(
    year int          default 0  not null
        primary key,
    url  varchar(255) default '' not null,
    constraint url
        unique (url)
);


create table status
(
    statusId int auto_increment
        primary key,
    status   varchar(255) default '' not null
);

