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

--6: Qual é a média de pit stops?

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

--9: Pegar o melhor desempenho na corrida, os pit stops afetaram?

--10: Qual nacionalidade chegou mais em primeiro?

--11: Montar um pódio com a nacionalidade do primeiro, do segundo e do terceiro maior ganhador;

--12: Média de pontos do ganhador  por temporada;

--13: Melhor por década? segundo melhor

--14: Comparar gerações, quem foi o melhor?

--15: quem foi melhor nikki lauda ou James Hunt?

--16: Qual foi o melhor brasileiro?

--17: Qual construtor e motorista relacionado mais se destacaram dentre as 5 primeiras posições durante os campeonatos?

--18: De quais países advém a maior parte dos construtores?
 
--19: Quais as nacionalidades presentes nos campeonatos? e porque de british? - Será que há algum incentivo diferenciado?
 
--20: Construtora que obteve mais pontos durante o período analisado...
 
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

--- Melhor por década? segundo melhor 
 
select  d.driverid, d.forename, d.surname, r."date", sum(rs."position") as position, sum(rs.points) as points
	from drivers d 
	inner join races r 
	on d.driverid = r.driverid 
	inner join results rs
	on r.driverid = rs.driverid 
	group by d.forename, d.surname, r."date";
	where 
	select avg(position) 
	from results;
----------------------------------------

--- Quem é ou quem foi o melhor brasileiro? 

select distinct d.forename,
	d.surname, d.nationality, 
	sum(r."position") as primeiro_lugar, 
	sum(r.points) as pontuacao, 
	min(r."time") as menor_tempo 
	from drivers d
	left join results r
	on d.driverid = r.driverid 
	where nationality = 'Brazilian'
	and position = 1
	group by d.forename, d.surname, d.nationality 
	order by sum(r."position") desc limit 4;

---------------------------------------------------

--- Qual nacionalidade lidera o primeiro lugar? 

select d.nationality,
    sum(r."position") as primeiro_lugar, 
    sum(r.points) as pontuacao
    from drivers d
    inner join results r
    on d.driverid = r.driverid 
    where  position = 1
    group by  d.nationality
    order by sum(r."position") desc;

-------------------------------------------------

--- Pódio com os três melhores pilotos e suas respectivas nacionalidades.

select d.forename, d.surname, d.nationality,
    sum(r."position") as position,
    sum(r.points) as pontuacao
    from drivers d
    inner join results r
    on d.driverid = r.driverid 
    where  position = 1
    group by  d.nationality, d.forename, d.surname
    order by sum(r."position")desc limit 3;
   
-------------------------------------------------   

   --- Quem foi melhor nikki lauda ou James Hunt? 

select distinct d.forename,
	d.surname, d.nationality, 
	sum(r."position") as primeiro_lugar, 
	sum(r.points) as pontuacao
	 from drivers d
left join results r
on d.driverid = r.driverid 
where forename = 'Hunt'
group by d.forename, d.surname, d.nationality 
order by sum(r."position") desc;

-------------------------------------------------
--- Quem foi melhor nikki lauda ou James Hunt? 

select distinct d.forename,
	d.surname, d.nationality, 
	r."position" as posicao, 
	r.points as pontuacao
	from drivers as d
	inner join results r
	on d.driverid = r.driverid
	where surname = 'Hunt'
	or surname = 'Lauda';
	

-----------------------------------------------------------------------

--- pegar o melhor desempenho na corrida, os pit stops afetaram? 

 select distinct pitstops.driverid, d.forename, d.surname, pitstops.stop, pitstops.milliseconds, d2.wins, results."time" 
 	from pitstops 
 	inner join driverstandings d2
 	on pitstops.driverid = d2.raceid
 	inner join results 
 	on d2.raceid = results.raceid
 	inner join drivers d 
 	on results.raceid = d.driverid
 	order by "milliseconds";