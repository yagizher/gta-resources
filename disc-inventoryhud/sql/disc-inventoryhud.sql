create table if not exists disc_ammo
(
    id bigint unsigned auto_increment,
    owner text not null,
    hash text not null,
    count int default 0 not null,
    constraint id
        unique (id)
);

alter table disc_ammo
    add primary key (id);

create table if not exists disc_inventory
(
    id int auto_increment
        primary key,
    owner text not null,
    type text null,
    data longtext not null
);

