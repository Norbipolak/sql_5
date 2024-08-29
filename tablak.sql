create database utf8mb4 character set utf8mb4_general_ci;
use a_nagy_konyv

create table szerzo(
    id int,
    nev varchar(33) not null,
    szulEv int not null,
    halEv int not null,
    nemzetiseg varchar(9) not null,
    constraint pk_szerzo primary key(id)
);

create table konyv(
    id int, 
    cim varchar(34) not null,
    szerzoId int not null,
    helyezes int not null,
    constraint pk_konyv primary key(id)
    constraint fk_konyvSzerzo foreign key (szerzoid) references szerzo(id)
);