create table if not exists disc_property
(
    id bigint unsigned auto_increment,
    name text not null,
    sold tinyint(1) default 0 null,
    price int default 0 not null,
    locked tinyint(1) default 1 null,
    constraint id
        unique (id)
);

alter table disc_property
    add primary key (id);

create table if not exists disc_property_garage_vehicles
(
    id bigint unsigned auto_increment,
    name text not null,
    plate text not null,
    props longtext not null,
    constraint id
        unique (id)
);

alter table disc_property_garage_vehicles
    add primary key (id);

create table if not exists disc_property_inventory
(
    id bigint unsigned auto_increment,
    inventory_name text null,
    data longtext null,
    constraint id
        unique (id)
);

alter table disc_property_inventory
    add primary key (id);

create table if not exists disc_property_owners
(
    id bigint unsigned auto_increment,
    name text null,
    identifier text null,
    active tinyint(1) default 1 null,
    owner tinyint(1) default 0 null,
    constraint id
        unique (id)
);

alter table disc_property_owners
    add primary key (id);

