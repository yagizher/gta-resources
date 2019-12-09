create table disc_mdt_crimes
(
    id bigint unsigned auto_increment PRIMARY KEY,
    name text not null,
    fine int default 0 not null,
    jailtime int default 0 not null,
    type text not null,
    description text not null,
    constraint id
        unique (id)
);

alter table users
    add darkmode BOOLEAN null;

alter table users
    add userimage LONGTEXT null;

alter table owned_vehicles
    add vehicleimage LONGTEXT null;

alter table owned_vehicles
    add bolo BOOLEAN null;


create table disc_mdt_reports
(
    id bigint unsigned auto_increment PRIMARY KEY,
    officerIdentifier text not null,
    playerIdentifier text not null,
    report longtext not null,
    date date null,
    time time null,
    constraint id
        unique (id)
);

