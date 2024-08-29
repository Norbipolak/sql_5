create database if not exists 'vitorlasberles'
default character set utf8mb4 collate utf8mb4_general_ci;
use 'vitorlasberles'

drop table if exists 'hajo';
drop table if exists 'tura';
/*
    Ami itt fontos
    create database if not exists ..neve
    Csak akkor csináljuk meg a database-t ha ilyen még nem létezik 

    drop table if exists 'hajo'
    csak, akkor csináljuk meg bele a 'hajo' table-t, hogyha ez nem létezik még benne 
*/

create table if not exists 'hajo'(
    regiszter int(11) primary key not null auto_increment,
    nev varchar(12),
    tipus varchar(12),
    utas varchar(11) not null,
    dij int(11) not null 
);

/*
    Nem csak a varchar-nál, hanem az int-nél is meg tudjuk határozni, hogy milyen hosszú legyen, hány karaktert tartalmazhat
    -> int(11), de ezt nem muszály, varchar-nál sem kell mindig, hogy varchar(11) hanem lehet VARCHAR is és akkor itt nem határoztuk meg, hogy
    hány karaktert tartalmazhat majd 
*/

create table if not exists 'tura'(
    azon int(11) primary key not null auto_increment,
    hajoazon int(11) not null,
    nap int(11) not null,
    szemely int(11) not null
);

/*
    és akkor ha nem a table-n belül adjuk meg, hogy mi legyen a foreign key, akkor ezt meg lehet adni kivül is az ALTER TABLE-vel
*/

ALTER TABLE 'tura' 
ADD CONSTRAINT 'FK_tura_hajoazon'
FOREIGN KEY(hajoazon)
REFERENCES 'vitorlasberles.'hajo'(regiszter)'
ON DELETE CASCADE
ON UPDATE CASCADE;