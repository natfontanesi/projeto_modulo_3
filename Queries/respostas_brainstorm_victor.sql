--1: Qual piloto mais ganhou corridas?

select
    r.position,
    d.forename,
    d.surname,
    sum (r."position") as total_vitorias
from
    results r
    join drivers d on d.driverid = r.driverid
where
    r.position = 1
group by
    r.position,
    d.forename,
    d.surname
order by
    count (r.driverid) desc


--2: Qual piloto teve a volta mais rápida?

select 
	d.surname as piloto,
	r.fastestlaptime as tempo,
	r.milliseconds as milisegundos
from 
	results r 
	join drivers d on r.driverid = d.driverid
	where fastestlaptime = (select min(fastestlaptime) from results);


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
	SUM (r."position") as total_vitorias
from 
	drivers d 
	join results r on d.driverid = r.driverid
WHERE
	r."position"=1
group BY
	d.nationality
order by total_vitorias desc

--5: Qual a pista mais rápida?

select  
	r2.name as pista,
	d.surname as piloto,
	r.fastestlaptime as menor_tempo
from results r
	join races r2 on r.raceid = r2.raceid
	join drivers d on d.driverid = r.driverid
	where fastestlaptime = (select min(fastestlaptime) from results);

--6: Qual é a média de pit stops?

select 
	avg(duration) as media_pit_stop 
from 
	pitstops;

--7: Quantos brasileiros foram campeões?
    select
	d.forename, d.surname, d.nationality, 
	sum(r."position") as vitorias
from 
	drivers d 
	join results r on d.driverid = r.driverid
WHERE
	d.nationality='Brazilian' and position=1
group BY
	d.forename, d.surname, d.nationality
	
order by vitorias desc;

--8: Qual piloto teve mais pole position?

select 
	d.forename,
	d.surname,
	d.driverid,
	sum(case when q."position"=1 then 1 else 0 end) as total_pole_positions
from qualifying q
	join drivers d on d.driverid=q.driverid
group by
	d.forename,
	d.surname,
	d.driverid
order by
	total_pole_positions desc
	limit 1;

--9: Pegar o melhor desempenho na corrida, os pit stops afetaram?

--10: Qual nacionalidade chegou mais em primeiro?

--11: Montar um pódio com a nacionalidade do primeiro, do segundo e do terceiro maior ganhador;

--12: Média de pontos do ganhador  por temporada;

--13: Melhor por década? segundo melhor

--14: Comparar gerações, quem foi o melhor?

--15: quem foi melhor nikki lauda ou James Hunt?

--16: Qual foi o melhor brasileiro?

--17: Qual construtor e motorista relacionado mais se destacaram dentre as 5 primeiras posições durante os campeonatos?

--18: Quais países que advém a maior parte das escuderias?

select 
	nationality as nacionalidade,
	count(nationality) as Numero_escuderias
from 
	constructors
group by 
	nationality
order by 
	Numero_escuderias desc
	limit 3;
 
--19: Quais as nacionalidades presentes nos campeonatos? e porque de british? - Será que há algum incentivo diferenciado?
 
--20: Construtora que obteve mais pontos durante o período analisado...

select 
	c2.name, 
	count(points) as pontos
from constructorstandings c1
	join constructors c2 on c1.constructorid = c2.constructorid
group by 
	name
order by 
	pontos desc 
	limit 1;
 
--21: Quais os pit-stops mais rápidos dentre os anos analisados e de quem foi? - parada do carro para troca de pneus e reabastecimento

--22: Qual motorista e construtora mais se destacou com os menores pit_stops?

--23: Qual construtora se destacou com os menores pit_stops durante o espaço de tempo analisado?

--24: Nome do circuito mais presente em cada ano analisado e a quantidade de vezes que aparece.

--Campeoes por ano (mais ou menos):

SELECT 
	rc."year",
	d.forename,
	d.surname,
	sum(rs.points) total
FROM 
	races rc 
	join results rs on rc.raceid = rs.raceid
	join drivers d on rs.driverid = d.driverid 
group by 
	rc."year",
	d.forename,
	d.surname
HAVING
	sum(rs.points)>=30
order BY
	rc."year",
	total desc

-- qtd de pitstops, mas tem alguma coisa errada
SELECT	
	d.driverref,
	rc."year",
	rc."round",
	sum(p.stop)
	
FROM
	pitstops p
	join races rc on p.raceid=rc.raceid
	join drivers d on p.driverid=d.driverid
group BY
	d.driverref,
	rc."year",
	rc."round"
order BY
	rc."year"

