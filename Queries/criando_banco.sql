--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\circuits.csv data-engine_postgres:/home

create table circuits(
	circuitId int PRIMARY KEY NOT NULL,
	circuitRef VARCHAR,
	name VARCHAR,
	location VARCHAR,
	country VARCHAR,
	lat VARCHAR,
	lng VARCHAR,
	alt VARCHAR,
	url VARCHAR
);


copy circuits
from 'formula_correto/circuits.csv' with delimiter ',' csv header ENCODING 'windows-1251';
--------------------------------------------------------------------------------------

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\constructorResults.csv data-engine_postgres:/home

create table constructorResults(
	constructorResultsId int PRIMARY KEY NOT NULL,
	raceId int,
	constructorId int,
	points float8,
	status VARCHAR
	);

copy constructorResults
from '/home/constructorResults.csv' with delimiter ',' csv header ENCODING 'windows-1251';

----------------------------------------------------------------------------------------

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\constructors.csv data-engine_postgres:/home

create table constructors(
	constructorId int PRIMARY KEY NOT NULL,
	constructorRef VARCHAR,
	name VARCHAR,
	nationality VARCHAR,
	url VARCHAR
	);

copy constructors
from '/home/constructors.csv' with delimiter ',' csv header ENCODING 'windows-1251';
-----------------------------------------------------------------------------------------

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\constructorStandings.csv data-engine_postgres:/home

create table constructorStandings(
    constructorStandingsId int PRIMARY KEY NOT NULL,
    raceId int,
    constructorId int,
    points float8,
    position int,
    positionText VARCHAR,
    wins int
);
copy constructorStandings
from '/home/constructorStandings.csv' with delimiter ',' csv header ENCODING 'windows-1251';
--------------------------------------------------------------------------------------------

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\drivers.csv data-engine_postgres:/home

CREATE TABLE drivers(
	driverId int PRIMARY KEY NOT NULL,
	driverRef VARCHAR,
	number int,
	code VARCHAR,
	forename varchar,
	surname varchar,
	dob date,
	nationality varchar,
	url varchar
	);
	
	copy drivers
from '/home/drivers.csv' with delimiter ',' csv header ENCODING 'windows-1251';
-------------------------------------------------------------------------------------------

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\driverStandings.csv data-engine_postgres:/home

create table driverStandings(
    driverStandingsId int PRIMARY KEY NOT NULL,
    raceId int,
    driverId int,
    points float8,
    position int,
    wins int
);

copy driverStandings
from '/home/driverStandings.csv' with delimiter ',' csv header ENCODING 'windows-1251';
---------------------------------------------------------------------------------------------

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\lapTimes.csv data-engine_postgres:/home
create table lapTimes(
    raceId int,
    driverId int,
    lap int,
    position int,
    time time,
    milliseconds int
);
copy lapTimes
from '/home/lapTimes.csv' with delimiter ',' csv header ENCODING 'windows-1251';
---------------------------------------------------------------------------------------------------------
--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\pitStops.csv data-engine_postgres:/home

create table pitStops(
    raceId int,
    driverId int,
    stop int,
    lap int,
    time time,
    duration interval,
    milliseconds int
);

copy pitStops
from '/home/pitStops.csv' with delimiter ',' csv header ENCODING 'windows-1251';
---------------------------------------------------------------------------------------------------------

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\qualifying.csv data-engine_postgres:/home


create table qualifying(
    qualifyId int PRIMARY KEY NOT NULL,
    raceId int,
    driverId int,
    constructorId int,
    number int,
    position int,
    q1 VARCHAR,
    q2 VARCHAR,
    q3 varchar
);



copy qualifying
from '/home/qualifying.csv' with delimiter ',' csv header ENCODING 'windows-1251';
--tabela com "defeito" tem que substituit "" por nada.
-----------------------------------------------------------------------------------------------------------
--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\races.csv data-engine_postgres:/home4

--NÃO DEU CERTO NAO CONSIGO SABER O PQ
create table races(
    raceId int PRIMARY KEY NOT NULL,
    year int,
    round int,
    circuitId int,
    name varchar,
    date varchar,
    time time,
    url varchar
);
copy races
from '/home/races.csv' with delimiter ',' csv header ENCODING 'windows-1251';

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\results.csv data-engine_postgres:/home

create table results(
    resultId int PRIMARY KEY NOT NULL,
    raceId int,
    driverId int,
    constructorId int,
    number int,
    grid int,
    position int,
    positionText varchar,
    positionOrder int,
    points float8,
    laps int,
    time interval,
    milliseconds int,
    fastestLap int,
    rank int,
    fastestLapTime interval,
    fastestLapSpeed varchar,
    statusId int
);

copy results
from '/home/results.csv' with delimiter ',' csv header ENCODING 'windows-1251';

--docker cp C:\Users\natas\OneDrive\Documentos\Formula_virgula\status.csv data-engine_postgres:/home

create table status(
    statusId int PRIMARY KEY NOT NULL,
    status varchar
);
copy status
from '/home/status.csv' with delimiter ',' csv header ENCODING 'windows-1251';


-----------------------------------------------------------------------------------------
                             -- FK: constructorId 
-----------------------------------------------------------------------------------------

ALTER TABLE constructorResults ADD foreign key(constructorId) 
references constructors(constructorId)


ALTER TABLE constructorStandings ADD foreign key(constructorId) 
references constructors(constructorId);


ALTER TABLE results ADD foreign key(constructorId) 
references constructors(constructorId)



------------------------------------------------------------------------------------------
                             --	FK: racesId
-----------------------------------------------------------------------------------------

ALTER TABLE constructorStandings ADD foreign key(raceId) 
references races(raceId);


ALTER TABLE constructorResults ADD foreign key(raceId) 
references races(raceId);


ALTER TABLE results ADD foreign key(raceId) 
references races(raceId);


ALTER TABLE driverStandings ADD foreign key(raceId) 
references races(raceId);



-----------------------------------------------------------------------------------------
                      -- FK: driverId 
-----------------------------------------------------------------------------------------


ALTER TABLE results ADD foreign key(driverId) 
references drivers(driverId);


ALTER TABLE qualifying ADD foreign key(driverId) 
references drivers(driverId);


ALTER TABLE driverStandings ADD foreign key(driverId) 
references drivers(driverId);

-----------------------------------------------------------------------------------------
                            -- FK: statusId
-----------------------------------------------------------------------------------------


ALTER TABLE results ADD foreign key(statusId) 
references status(statusId);

-----------------------------------------------------------------------------------------
							-- FK: circuitId
------------------------------------------------------------------------------------------


ALTER TABLE races ADD foreign key(circuitId) 
references circuits(circuitId);

ALTER TABLE lapTimes ADD foreign key(raceId) 
references races(raceId);

ALTER TABLE lapTimes ADD foreign key(driverId) 
references drivers(driverId);

ALTER TABLE qualifying ADD foreign key(raceId) 
references races(raceId);

ALTER TABLE qualifying ADD foreign key(driverId) 
references drivers(driverId);
