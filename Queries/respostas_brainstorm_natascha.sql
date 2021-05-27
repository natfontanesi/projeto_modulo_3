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
SELECT 
	d.forename,
	d.surname,
	c."name",
	c.country,
	MIN(milliseconds) menor_tempo
FROM 
	laptimes l
	JOIN drivers d on l.driverid = d.driverid
	JOIN races rc on rc.raceid=l.raceid
	JOIN circuits c on rc.circuitid=c.circuitid
GROUP BY
	d.forename,
	d.surname,
	c.circuitid,
	c.country
ORDER BY
	menor_tempo


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
SELECT 
	AVG(duration)
FROM
	pitstops

--7: Quantos brasileiros foram campeões?
   select
	c.driverid,
	c.forename,
	c.surname,
	count (c.driverid) as vezes_campeao
from 
	vw_campeoes_nome c
	join drivers d on d.driverid=c.driverid
where 
	d.nationality='Brazilian'
group by 
	c.driverid,
	c.forename,
	c.surname

--8: Qual piloto teve mais pole position?
SELECT
	d.forename,
	d.surname,
	COUNT(q."position") as qtd_pole_position
FROM
	qualifying q
	JOIN drivers d ON d.driverid=q.driverid
WHERE 
	q."position" = 1
GROUP BY
	d.forename,
	d.surname
ORDER BY
	qtd_pole_position desc

--9: Pegar o melhor desempenho na corrida, os pit stops afetaram?

--10: Qual nacionalidade chegou mais em primeiro?
	--repetida
--11: Montar um pódio com a nacionalidade do primeiro, do segundo e do terceiro maior ganhador;

--12: Média de pontos do ganhador  por temporada;

--13: Melhor por década? segundo melhor

--14: Comparar gerações, quem foi o melhor?

--15: quem foi melhor nikki lauda ou James Hunt?


--16: Qual foi o melhor brasileiro?
	select
	c.driverid,
	c.forename,
	c.surname,
	count (c.driverid) as vezes_campeao
from 
	vw_campeoes_nome c
	join drivers d on d.driverid=c.driverid
where 
	d.nationality='Brazilian'
group by 
	c.driverid,
	c.forename,
	c.surname

--17: Qual construtor e motorista relacionado mais se destacaram dentre as 5 primeiras posições durante os campeonatos?

--18: De quais países advém a maior parte dos construtores?
 
--19: Quais as nacionalidades presentes nos campeonatos? e porque de british? - Será que há algum incentivo diferenciado?
 
--20: Construtora que obteve mais pontos durante o período analisado...
 
--21: Quais os pit-stops mais rápidos dentre os anos analisados e de quem foi? - parada do carro para troca de pneus e reabastecimento

--22: Qual motorista mais se destacou com os menores pit_stops?
SELECT	
	d.surname,
	d.forename,
	MIN(pt.milliseconds)
from 
	pitstops pt
	join drivers d on d.driverid = pt.driverid
GROUP BY
	d.surname,
	d.forename
	limit 10

--23: Qual construtora se destacou com os menores pit_stops durante o espaço de tempo analisado?

--24: Nome do circuito mais presente em cada ano analisado e a quantidade de vezes que aparece.

-

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

-- Quantas corridas e vitórias Schumacher e Hamilton tem:
SELECT
	d.driverid,
	d.forename,
	d.surname,
	count(d.driverid) as corridas,
	count(rs.position) as vitorias,
	(count(rs.position))/ (count(d.driverid))::FLOAT as desempenho
FROM
	results rs
	JOIN drivers d ON d.driverid=rs.driverid
GROUP BY
	d.driverid,
	d.forename,
	d.surname
having d.driverid in (30,1)
ORDER BY
	corridas DESC
-- nao ta dando certo, vou tentar ver com o ruberth
SELECT
	d.driverid,
	d.forename,
	d.surname,
	count(rs.driverid) as corridas,
	sum (case when rs."position"=1 then 1 else 0 end) as vitorias,
	(sum (case when rs."position"=1 then 1 else 0 end)/count(rs.driverid)::FLOAT) as desempenho
FROM
	results rs
	left JOIN drivers d ON d.driverid=rs.driverid
WHERE
	rs.driverid=30 or rs.driverid =1
GROUP BY
	d.driverid,
	d.forename,
	d.surname
ORDER BY
	vitorias DESC

select 
	sum(case when q."position"=1 then 1 else 0 end) as pole_positions,
	d.forename,
	d.surname,
	d.driverid
from qualifying q
	join drivers d on d.driverid=q.driverid
GROUP BY
	d.forename,
	d.surname,
	d.driverid
ORDER BY
	pole_positions desc


select
	c.driverid,
	c.forename,
	c.surname,
	count (c.driverid) as vezes_campeao
from 
	vw_campeoes_nome c
	join drivers d on d.driverid=c.driverid
where 
	d.driverid= 1 or d.driverid=20 or d.driverid=30
group by 
	c.driverid,
	c.forename,
	c.surname
order by
    vezes_campeao desc