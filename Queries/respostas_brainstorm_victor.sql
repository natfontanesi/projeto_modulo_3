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

select * from races;

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

