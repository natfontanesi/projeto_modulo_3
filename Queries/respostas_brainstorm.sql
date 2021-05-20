--1: Qual piloto mais ganhou corridas?

select
    r.driverid,
    r.position,
    d.forename,
    d.surname,
    count (r.driverid) as total_vitorias
from
    results r
    join drivers d on d.driverid = r.driverid
where
    r.position = 1
group by
    r.driverid,
    r.position,
    d.forename,
    d.surname
order by
    count (r.driverid) desc
--2: Qual piloto teve a volta mais rápida?
--3: Qual escuderia teve mais pontos?
select
    c.name,
    sum(cs.points) as total_pontos
from
    constructors c
    join constructorstandings cs on c.constructorid = cs.constructorid
group by
    c.name
order by
    total_pontos desc
--4: Qual país tem mais vitórias?
select
	d.nationality,
	SUM (ds.wins) as total_vitorias
from 
	drivers d 
	join driverstandings ds on d.driverid = ds.driverid
group BY
	d.nationality
order by total_vitorias desc