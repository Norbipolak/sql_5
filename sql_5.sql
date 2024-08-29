/*
    3. A felmérés eredményeit tartalmazó adatbázisban a magyar szerzőkön túl számos külföldi
    szerző műve helyet kapott. Lekérdezéssel határozza meg, hogy milyen nemzetiségű külföldi
    írók szerepelnek az adatbázisban! Ügyeljen arra, hogy egy nemzetiség csak egyszer jelenjen
    meg! (3. feladat:)
*/

select distinct nemzetiseg
from szerzo where nemzetiseg != 'magyar';

/*
    Ami itt nagyon fontos, hogyha azt akarjuk, hogy csak egy egyszer szerepeljen a listában, akkor kell a DISTINCT 
    és mivel itt a select, tehét a nemzetiseget kérdezzük le és nagyon sok költő mondjuk német, akkor a DINSTINCT-vel azt érjük el, hogy 
    a lekerdézéssel csak egyszer fog kijönni, hogy német!!!! 
*/

/*
    4. Készítsen lekérdezést, amely kilistázza a szerzők nevét és 
    a felmérés évében betöltött korát!
    A lekérdezés a felméréskor már elhunyt szerzőket ne vegye figyelembe! A mezők címkéjét
    a minta szerint állítsa be! (4. feladat:)
*/

select nev, (2005 - szulEv) as "kor" 
from szerzo where halEv is null;

/*
    Itt kettő dolog kell, hogy legyen a lekérdezésben és mindegyiket ugyanarról a tábláról fogjuk majd megkapni
    1. név 
    2. mennyi éves most a szerző, tekintve, hogy most 2005-t írunk 
        ez egy sima kivonásos müvelet a 2005-ből kivonjuk a szulEv-et 

    Kikötés még, hogy nem lehet halott a költő, tehát a halÉv-nek nullának kell lennie!!!! 
    Ezt úgy csinákljuk meg, hogy WHERE-vel kiválasztjuk a kikötést, ami majd a halEv-re fog vonatkozni és azt ottani értéknull kell, hogy legyen 
        -> WHERE halEv is null 

    Ha valamilyen müveletet végzünk, akkor fontos, hogy az egy ()-ben legyen -> (2005 - szulEv)

    Ami itt még nagyon fontos, hogy ha lekérdezünk valamit, tehát SELECT van, de nem egy mezőt kérdezünk le hanem pl. itt, hogy hány éves 
    amit kiszámolunk (2005 - szulEv) akkor ott az AS-vel meg tudjuk határozni, hogy a lekérdezésben mi legyen a címsor megnevezése!!!!!! 
    ****************************************************************************************
*/

/*
    vitorlasos feladatok 
*/

/*
    1. Jelenítse meg milyen típusú hajók vannak az adatbázisban! Ismétlodések ne legyenek! Az
    eredmény legyen ABC sorrendben!
*/

select distinct tipus from hajo
order by tipus;

/*
    Ami itt nagyon fontos ebben a feladatban, hogy azt írja, hogy ismétlődések ne legyenek 
    Ezt úgy tudjuk elérni, hogy amikor a SELECT-vel kiválasszük, hogy melyik mezőt kérdezzük le, akkor odaírjuk, hogy DISTINCT 
    és akkor bármennyi rekordnak lehet ugyanaz a tipusa, csak egyszer fogja kihozni 

    ABC sorrendben legyenek 
    Itt kell majd az ORDER BY, mert ezzel tudunk rendszerezni és itt a tipus-ra fog vonatkozni, tehát ha lejöttek a tipusok, akkor az 
    ORDER BY tipus-val abc sorrendbe rakja őket!!!! 
    de ez lehet mondjuk, hogy itt számok vannak azzal is müködik és lehet még odaírni, hogy ASC vagy DESC legyen!!! 
*/

/*
    2. Mennyibe kerül a legolcsóbb hajó viteldíja?
*/

SELECT MIN(dij) as "legolcsóbb" FROM hajo;

/*
    Ugy van egy olyan mező, hogy dij és nekünk majd ezt kell lekérdezni, de nem az összesre vagyunk kivácsiak, hanem azt akarjuk, hogy csak 
    a legolcsóbb jöjjön le, erre van egy beépített metódus a MIN(), ami vár egy mezőt 
        és onnan csak egyet fog lehozni a legkisebb értéket!!! 
*/

/*
    Melyik az a három hajó, melyekre a legtöbben férnek fel? Jelenítse meg a nevét, az utasok
    számát és a vitledíjat.
*/

select nev, utas, dij from hajo
ORDER BY utas DESC
LIMIT 3;

/*
    Meg kell jeleníteni a nev-et, utas-okat és a dij-at 
    Azt írja a feladat, hogy amelyekre a legtöbben férnek fel, tehát ezt csopotosítani kell majd az utas mező szerint 
    méghozzá DESC, ilyenkor az lesz az első rekord, amelyre a legtöbben férnek fel és eszerint megy lefele 
    de volt még egy kikötés, hogy csak az első 3-at kell majd megjeleníteni, ilyenkor kell a LIMIT 

    Tehát ebben a feladatban mi a fontos 
    1. milyen mezőket kell majd megjeleníteni -> SELECT 
    2. ha ilyen van a feladatban, hogy legtöbb, legnagyobb, legkisebb, akkor biztos, hogy csoportosítani kell majd -> ORDER BY 
    3. ha olyan van, hogy sok rekord van, de azt írja a feladat, hogy jelenítsük meg 3-at, 4-et stb 
        LIMIT és ide megadjuk, hogy mennyit akarunk majd megjeleníteni 
*/

/*
    4. Határozza meg típusonként mennyi az átlagos viteldíj?
*/

select tipus, SUM(dij) as "átlagos viteldíj"from hajo
GROUP BY tipus;

/*
    Ha ilyen van, hogy típusonként vagy valami szerint, akkor biztos, hogy GROUP BY 
    Tehát itt a feladaban csak egy valamit kell majd megjeleníteni a dij-at és méghozza annak az átlagát -> AVG -> AVG(dij)
    meg a tipus-t is és aszerint kell majd GROUP BY és akkor minden tipus csak egyszer fog szerepelni 

    Tehát a group by-val azt érjük el, hogy mindegyik érték egyszer fog szerepelni valami szerint 
    a order by-val meg, hogy milyen sorrendben jelenjen meg 

    a GROUP BY, tehát arra vagyunk kiváncsiak, hogy egy adott mezőben ugyanaz az érték többször van és mi csak egyszer akarjuk, hogy megjelenjen 
    a GROUP BY az sokszor együtt van olyan beépített funkciókkal mint a COUNT(), SUM(), AVG(), MIN(), MAX() 
    count - megadja, hogy az rekord hányszor szerepel az adott táblán
    sum - amik ugyanazok azoknak az értékeit összeadja, de ez csak akkor ha valami szerint GROUP BY-olva va..

    pl. van egy ilyen table, hogy sales

    salesperson	product	amount
    John	A	100
    John	B	150
    Jane	A	200
    Jane	B	250

    Using GROUP BY:
    SELECT salesperson, SUM(amount)
    FROM sales
    GROUP BY salesperson;

    Output:
    salesperson	SUM(amount)
    John	250
    Jane	450

    SELECT salesperson, product, amount
    FROM sales
    ORDER BY salesperson ASC, amount DESC;


    salesperson	product	amount
    Jane	B	250
    Jane	A	200
    John	B	150
    John	A	100

    Ha ORDER BY akkor meg az összes meg fog jelenni, az összes rekord!!! 

    In summary, 
    GROUP BY is used for aggregation, and it groups similar data into single rows, while 
    ORDER BY is used for sorting the rows in a particular order without affecting the total number of rows in the result set.
*/

/*
    5. Határozza meg hajónként mennyi a bevétele, 
    ha teljes kihasználtsággal megy!
*/

select nev, (utas * dij) as "bevétel teljes kihasználtsággal"
from hajo;

/*
    Itt is egy table van még csak és utas meg a dijat össze kell szorozni úgy kapjuk meg amit akarunk 
    és mivel itt is egy müveletet csináltunk két mezőből -> (utas * dij) 
    ezért kell használni egy AS-t, hogy amikor lekérdezzük majd mi legyen a mező neve ami alatt lesz a (utas * dij)
*/

/*
    Jelenítse meg, hogy az egyes hajókat 
    hányszor bérelték ki.
*/

SELECT nev, COUNT(hajoazon) as "bérlések száma" /*itt nagyon fontos, hogy kell egy as ha nem pontosan egy létező mezőt kérdezünk le!!!*/
FROM hajo 
INNER JOIN tura
ON hajo.regiszter = tura.hajoazon
GROUP BY hajo.regiszter 
ORDER BY COUNT(hajoazon) DESC;

/*
    Kell a hajónak majd a neve meg azt, hogy hányszor bérelték ki azt a másik tablából tudjuk majd leszedni és ott van egy olyan mező, hogy 
    hajoazon, itt minden hajónak minden bérlése itt van, ezért kell a count, méghozzá az id-re, hogy hányszor szerepel az a hajó azon a listán

    Tehét fontos, hogy 
    1. count -> megszámolni, hogy hányszor van (szerepel) egy bizonyos id-jű hajó a table-ben 
    2. összekötni a két table-t, mert az egyik adat a ha a masik meg a tura table-n van FROM esődleges table INNER JOIN másodlagas table ON
        hogy mivel csatoltuk össze foreign key meg a primary key a másikból   
    A szerint szeretnénk csoportósítani, hogy hajo.regiszter 
    
    Magyarázat 

    SELECT nev, COUNT(hajoazon) as "bérlések száma"

    A SELECT nev, COUNT(hajoazon) as "bérlések száma" 
    Azt mondja meg, hogy a lekérdezés eredményeként a hajó nevét ('nev') és a bérlések számát ('COUNT(hajoazon)') szeretnénk megjeleníteni 
    A COUNT(hajoazon) összeszámolja, hogy hányszor szerepel az adott hajó azonosítója (hajoazon) a 'tura' táblán
    Az eredményt elnevezzük "bérlések számának"  

    FROM hajo INNER JOIN tura ON tura.hajoazon = hajo.regiszter

    Itt egy INNER JOIN müvelet történik a 'hajo' és a 'tura' tábla között, ahol a 'tura' tábla a 'hajoazon' mezője megegyezik a 'hajo' tábla 
    'regiszter' mezőjével. Ez azt jelenti, hogy csak azok az adatok kerülnek be a lekérdezés eredményébe, ahol van megfelelő kapcsolat a két 
    tábla között (vagyis csak azokat a hajokat jelenítjük meg, amelyekhez tartozik tura is) 

    GROUP BY hajo.regiszter

    Csoportosítás 
    Ez a sor azt mondja meg az SQL-nek, hogy a leklrdezés eredményét csoportosítja a 'hajo.regiszter' mező szerint, azaz minden egyes hajó 
    regisztrációs számát tekintse külön csoportnak. Minden csoportban a 'COUNT(hajoazon)' összesíti, hogy az adott hajót hányszor bérelték ki 

    ORDER BY COUNT(hajoazon) DESC
    Rendezés 
    Ez a sor rendezi a lekérdezés eredményét az alapján, hogy hányszor bérelték ki az egyes hajókat. A 'COUNT(hajoazon)' függvény használatával 
    a bérlések számát rendezzük mégpedig csökkenő sorrendben DESC, a legtöbbet bérelt hajók kerülnek majd a lista elejére 

    Mi van ha kihagyjuk az order by-t 
    SELECT nev, COUNT(hajoazon) as "bérlések száma"
    FROM hajo 
    INNER JOIN tura 
    ON tura.hajoazon = hajo.regiszter
    GROUP BY hajo.regiszter;

    Az eredmény gyakorlatilag ugyanaz marad, minden hajónév mellett megjelenik a hozzá tartazó bérlések száma 
    A sorrend azonban nem lesz meghatározott. Az SQL általában nem garantál semmilyen specifikus sorrendet, ha csak nem adunk meg valamilyen 
    explicit elrendezést Az adatok megjelenhetnek véletlenszerűen vagy abban a sorrendben, ahogy a csoportok elöször vannak a táblán  

    És ami nagyon fontos, hogy mi van ha kihagyjuk a GROUP BY-t 
    SELECT nev, COUNT(hajoazon) as "bérlések száma"
    FROM hajo 
    INNER JOIN tura 
    ON tura.hajoazon = hajo.regiszter
    ORDER BY COUNT(hajoazon) DESC;

    Ha kihagyjuk a GROUP BY hajo.regiszter, akkor a függvény az összes értéket fogja számolni, ami a hajo és a tura táblák összekapcsolásából
    származik.
    Az eredmény csak egy sor lesz!!!!!!!!! ami az összes hajó bérlésének összesített számát mutatja 

    Név mező értéke 
    A név mező értéke viszont ebben az esetben nem lesz egyértelmű. Véletlenszerűen lesz választva 

    Példa 
    Ha van mondjuk 5 hajó és összesen 20 bérlés történt, akkor az eredményben 20 bérlés fog megjelenni egy sorban, de a hajó neve véletlenszerűen 
    lesz kiválasztva az oszlopból.

    ORDER BY kihagyása 
    ->
    Az eredmények ugyanazok maradnak, csak a megjelenítés sorrendje nem lesz meghatározott 

    GROUP BY kihagyása 
    ->
    Az összes rekord egy sorba tömörül, az összesített bérlésszámot látjuk, plusz a hajó neve is véletlenszerűen lesz meghatározva 

    Ami itt nagyon fontos, hogyha van aggregáló függvény, mint pl. a COUNT, SUM, AVG, akkor általában szükségünk lesz a GROUP BY használatára is!!
    Hogy az adatok csoportosítása megfelelően történjen!!! 
*/

/*
    7. Jelenítse meg melyik hajót összesen hány napra bérelték ki! Az eredményt a legtöbb napra
    kibérelt hajóval kezdje!
*/

SELECT nev, SUM(nap) 
FROM hajo 
INNER JOIN tura 
ON hajo.regiszter = tura.hajoazon
GROUP BY hajo.regiszter
ORDER BY SUM(nap) DESC;

/*
    Kell a hajó neve és, hogy összesen hány napra bérelték ki, ebben az esetben nem azt nézzük meg, hogy hányszor fordul elő, tehát nem a COUNT-ot 
    használjuk, hanem a SUM-ot, ami összeadja az adott mezőben lévő értékeket 
    És ha nincsen GROUP BY, akkor megszámolja az összeset és majd lesz egy sor az összeset összeadva 
    ezért ugyanúgy, mint az előbb a hajo.regiszter alapján csoportosítunk, mert ez egy egyedi érték, ami minden hajó hozzá van rendelve egy!! 

    Ami még fontos, nem csak akkor, amikor van egy bizonyos müvekelet pl. (2005 - szulEv) vagy (dij * fő) stb. hanem akkor is kell 
    AS ha COUNT vagy SUM-olunk egy mezőt pl. itt as "napok száma", hogy tudjuk, hogy miről van szó!!!!!  
*/

/*
    8. Összesen hány fo utazott kalóz hajón?
*/

/*
    Ez nagyon hasonló lesz, mint az elöbb, mert ha benne van, hogy összesen, akkor a SUM-ot kell majd használni 
    És ugyanúgy van két táblánk amit össze kell majd kapcsolni 

    Ami különbség, hogy itt van egy további kikötés -> WHERE 
    az, hogy a kalóz, ami a tipusnál van, hogy milyen tipusú a hajó, ezért WHERE tipus = "kalóz"; 
*/

SELECT nev, SUM(szemely) 
FROM hajo 
INNER JOIN tura
ON hajo.regiszter = tura.hajoazon
WHERE tipus = "Kalóz" 
GROUP BY hajo.regiszter
ORDER BY SUM(szemely) DESC;

/*
    9. Jelenítse meg azoknak a hajóknak a nevét, melyek pont egy hétre lettek kibérelve.
*/

select nev from hajo 
where regiszter = 
any(select hajoazon from tura where nap = 7);

/*
    Itt is kétféle módszer lehet allekérdezés vagy a JOIN 

    JOIN 
    Amikor 'JOIN' müveletet használunk, közvetlen kapcsoljuk össze a két táblát a lekérdezésben egy közös oszlop 
    például egy külső kulcs és egy esődleges kulcs alapján 

    INNER JOIN -> csak azokat a sorokat adja vissza, ahol a két tábla között van egyezés 
    LEFT JOIN -> Minden sort visszaad a bal oldali táblából, és ha nincsen egyezés a jobb oldali táblával, akkor a jobb oldali 
    tábla mezői null-ok lesznek 
    RIGHT JOIN -> Az ellenkezője a LEFT JOIN-nak, azaz minden sort visszaad a jobb oldali táblából, és a bal oldali tábla mezői lesznek 
    null-ok, ha nincsen egyezés 

    INNER JOIN-os példa 
    SELECT nev
    FROM hajo
    INNER JOIN tura ON hajo.regiszter = tura.hajoazon
    WHERE tura.nap = 7;

    Összekapcsoljuk a tura meg a hajo táblát, és csak azokat a hajókat jelenítjük meg, amelyeknél a tura táblában a nap értéke = 7 
    Csak akkor kapunk találatot ha van egyezés a regiszter és a hajoazon között 

    Allekérdezés (Subquery vagy Subselect) 
    Az allekérdezés egy olyan módszer, ahol egy másik lekérdezést (subquery) ágyazunk be a a fő lekérdezésbe. Az allekérdezés eredménye alapján 
    szürjük vagy választjuk ki az adatokat a fő lekérdezésben. 

    SELECT nev
    FROM hajo 
    WHERE regiszter = 
    ANY(SELECT hajoazon FROM tura WHERE nap = 7);

    Ebben az esetben a az allekérdezés (SELECT hajoazon FROM tura WHERE nap = 7) elöször fut le, és visszaadja azokat a hajóazonosítokat 
    (hajoazon), amik megfelelnek a feltételnek (nap = 7) 
    Ezután a fő lekérdezés SELECT nev FROM hajo WHERE regiszter = ANY(...))
    ezek közül az azonosítok közül keresi meg azokat, amelyek egyeznek a hajo táblában lévő regiszter értékekkel és visszaadja a hajók nevét 

    Összefoglalás 
    A JOIN müvelet, akkor hasznosak, ha két táblát kapcsolunk össze és több oszlopot akarunk megjeleníteni az összekapcsolt adatokból 

    Az Allekérdezések akkor hasznosak, ha egy tábla adatait egy másik tábla szűrési eredméynei alapján akarjuk kiválasztani vagy korlátozni 
*/

/*
    ANY 

    Az ANY kulcsszó egy összehasonlító operátor, amely azt vizsgálja, hogy egy adott érték megegyezik-e egy lista bármelyik elemével
    Ha a feltétel bármelyik elem esetében igaz, akkor az egész kifejezés igaznak számit 

    SELECT nev
    FROM hajo 
    WHERE regiszter = 
    ANY(SELECT hajoazon FROM tura WHERE nap = 7);

    ANY kulcsszó azt mondja, hogy a fő lekérdezésben lévő regiszter értékének meg kell egyeznie az allekérdezés által visszaadott bármelyik 
    elemével
    Ha van olyan regiszter érték, ami megegyezik a listában szereplő bármelyik hajoazon értékkel, akkor az adott regiszter-hez tartozó 
    hajó nevét (nev) visszaadja a lekérdezés 

    Példa 
    Tegyük fel, hogy az allekérdezés visszaadja a következő hajoazon értékeket 1,3,5. 
    Az ANY kulcsszó ekkor azt vizsgálja, hogy a hajo táblában a regiszter érték megegyezik-e bármelyik ezek közül (azaz 1,3,5) 
    Ha igen, akkor az adott hajó neve bekerül az eredménybe. 

    Összefoglalva 
    Az ANY kulcsszó tehát azt biztosítja, hogy a fő lekérdezés olyan sorokat találjon ahol a regiszter érték megegyezik az allakérdezés 
    által visszaadott lista bármelyik elemével. 
    Olyan mintha azt mondanánk, hogy van-e legalább egy olyan érték, amely megfelel a feltételnek!!!!! 

    Ha nem írunk any-t 
    1. több értéket talált az allekérdezés pl. mint a példában 1,3,5
    Ha az allekérdezés több értéket add vissza és nincs ANY, akkor hiba történik 

    2. ha csak egy értéket talált pl. 3-ast 
    Ha az allekérdezés egyetlen értéket ad vissza, akkor a WHERE feltétel müködik de csak azzal az egy értékkel hasonlít össze 

    3. ha nincs egyezés, találat 
    Ha az allekérdezés nem talál semmit, akkor a lekérdezés nem ad vissza eredményt 

    Tehát az any kulcsszó, azért fontos, mert lehetővé teszi, hogy a WHERE feltétel több eredményt között keressen anélkül, hogy 
    hibát kapnánk, ha az allekérdezés több értéket ad vissza!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!44
*/

/*
    11. Melyik hajó mennyi bevételt hozott összesen? 
    Rendezze bevétel szerint csökkeno sorrendbe!
*/

select nev, SUM(dij * nap * szemely) as "bevétel"
from hajo
inner join tura 
on hajo.regiszter = tura.hajoazon
group by hajo.regiszter
order by nev;

/*
    Mi a bevétel -> dij * nap * személy és ez lesz majd az AS-vel bevétel 
    és még kell a hajó neve is, mert ahhoz rendezzük majd a bevételeket 

    és ezt a müveletet egy SUM-ba kell tenni ez nagyon fontos, hisz az összesnél össze kell majd számolni nem csak egy sorban, rekordban!!!!!

    ez is majd egy INNER JOIN és itt is kell majd, hogy legyen GROUP BY, hiszen ha van SUM, akkor azt akarjuk, hogy ne csak egy számot adjon 
    majd vissza, hanem minden id-jű hajóhoz majd a megfelelőt 
*/

/*
    12. Több hajó neve HUN-XXX (az XXX helyén számok vannak) formátumú. Jelenítse meg, hogy
    ezek közül melyiket hányszor bérelték ki!
*/

SELECT nev, COUNT(hajoazon)
FROM hajo
INNER JOIN tura
ON hajo.regiszter = tura.hajoazon
GROUP BY hajo.regiszter 
HAVING nev LIKE "HUN%" /*nagyon fontos, hogy HAVING és LIKE like-nak meg % vagy előtte vagy utána*/

/*
    itt is majd össze kell számolni, hogy hányszor szerepel a hajoazon, mert abból tudjuk, hogy pontosan hányszor volt kibérelve
    -> COUNT(hajoazon) 
    és mivel van COUNT, ezért itt is kell majd a GROUP BY-val rendezni 

    De van még egy feltétel, hogy csak azok a hajók kellenek itt amelyiknek a neve egy bizonyos dologgal kezdődik 
    És itt nem a WHERE használjuk, hanem a HAVING-et és ahhoz kell a LIKE, amivel majd meg tudjuk ezt hastározni, hogy mivel kezdődik 
*/

/*
    13. Hányszor béreltek ki hajót teljes kihasználtsággal?
*/

SELECT COUNT(regiszter) /*megszámoljuk, hogy hány hajó van*/
FROM hajo 
WHERE utas = (SELECT szemely FROM tura
WHERE tura.hajoazon = hajo.regiszter)

/*
    Itt majd egy allekérdezés lesz, ahol tehát WHERE az utas meg, hogy egyezen a másik táblaban lévő személyek számával 
    Úgy, hogy összekötjük a WHERE-vel a két táblát 
*/

/*
    14. Jelenítse meg azon Cadet típusú hajók nevét, melyek 
    összbevétele meghaladja a száz ezer forintot
*/

SELECT nev, SUM(dij * nap * szemely) as "bevétel"
from hajo
INNER JOIN tura
ON hajo.regiszter = tura.hajoazon
WHERE tipus = "Cader"
GROUP BY hajo.regiszter
HAVING SUM(dij * nap * szemely) > 100000
ORDER BY SUM(dij * nap * szemely);

/*
    15. Jelenítse meg a B betuvel kezdodo típusú hajók közül 
    azokat, melyeket többször is csak egy fo
    bérelt (nem feltétlen ugyanaz a személy).
*/

SELECT nev, COUNT(azon) as "bérlések száma" 
FROM hajo 
INNER JOIN tura 
ON hajo.regiszter = tura.hajoazon
WHERE szemely = 1 
GROUP BY hajo.regiszter
HAVING COUNT(azon) > 1
AND nev LIKE "B%";

/*
The HAVING and WHERE clauses in SQL are both used to filter data, but they are applied at different stages 
in the query process and are used for different purposes.

1. WHERE Clause

Purpose: The WHERE clause is used to filter rows before any groupings are made or any aggregate functions 
(like COUNT, SUM, AVG, etc.) are applied. It works on individual rows of data.
Usage: WHERE is typically used to filter data based on conditions that involve columns, without considering any aggregate calculations.

SELECT department, employee, salary
FROM employees
WHERE salary > 50000;
Explanation: This query filters the employees table to only include rows where the salary is greater than 50,000.

2. HAVING Clause

Purpose: The HAVING clause is used to filter rows after groupings have been made by the GROUP BY clause and after aggregate functions have been calculated. It works on grouped data.
Usage: HAVING is used to filter the results of an aggregate function or to filter groups of data.

SELECT department, COUNT(employee) as num_employees
FROM employees
GROUP BY department
HAVING COUNT(employee) > 10;
Explanation: This query first groups the employees by department, then counts the number of employees in each department, and finally filters out those departments that have 10 or fewer employees.
Key Differences:
When They Are Applied:

WHERE filters rows before grouping and aggregation.
HAVING filters groups or aggregate results after the grouping and aggregation have been done.
What They Filter:

WHERE can only filter rows based on non-aggregate conditions.
HAVING can filter based on conditions involving aggregate functions.
Usage:

Use WHERE when you need to filter data before any aggregation (e.g., filter rows based on a condition like salary > 50000).
Use HAVING when you need to filter after aggregation (e.g., only include groups where the aggregate result meets certain criteria).

SELECT department, COUNT(employee) as num_employees, AVG(salary) as avg_salary
FROM employees
WHERE salary > 50000
GROUP BY department
HAVING AVG(salary) > 60000;
Explanation:
WHERE salary > 50000: Filters out employees with a salary of 50,000 or less before any grouping.
GROUP BY department: Groups the remaining employees by department.
HAVING AVG(salary) > 60000: Only includes those departments where the average salary (calculated after filtering and grouping) 
is greater than 60,000.

In summary, WHERE is used for filtering rows before aggregation, and HAVING is used for filtering after aggregation.
*/
