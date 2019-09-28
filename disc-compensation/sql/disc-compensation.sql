create table if not exists compensation
(
    id bigint unsigned auto_increment,
    compensator text not null,
    receiver text not null,
    reason longtext not null,
    amount int not null,
    constraint id
        unique (id)
);

alter table compensation
    add primary key (id);