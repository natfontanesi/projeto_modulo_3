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

--17: Quais as nacionalidades presentes nos campeonatos?

select distinct nationality 
from drivers

--18: De quais países advém a maior parte dos construtores?
 
--19: Qual construtora se destacou com os menores pit_stops entre 2008 e 2018?

--20: Construtora que obteve mais pontos durante o período analisado...
 
--21: Top 5 dos menores pitstops registrados durante os anos analisados(1950-2018):

select drivers.driverref, pitstops.milliseconds as duração_millisegundos
from drivers
join pitstops on drivers.driverid = pitstops.driverid 
order by duração_millisegundos asc 
limit 5

--22: Qual motorista e construtora mais se destacou com os menores pit_stops?

--23: Quais status(ocorrências) mais recorrentes na Fórmula 1?

select status.status, count(results.statusid) quantidade from status 
join results on results.statusid = status.statusid 
group by  status.statusid
order by quantidade desc
limit 10

--24: Distribuição da quantidade de pilotos por posição nos resultados entre as sessões de 1950 a 2018?

select results.position as posicao, count(results.position) as quantidade_de_pilotos
from results 
group by results.position
order by quantidade_de_pilotos desc

--25: Campeões da ultima década: 

select surname, year, total from vw_campeoes_nome
where year between '2008' and '2018'

--26: Ocorrências potencialmente perigosos/fatais contra vida vivênciadas
-- na modalidade entre os anos de 1950 - 2018

select status.status as ocorrências, count(status.status) as vezes 
from status
join results on results.statusid = status.statusid 
where status.status like 'Fatal accident' or status.status like 'Fire'
or status.status like 'Accident'
or status.status like 'Injured' 
or status.status like 'Collision' 
or status.status like'Collision damage'
group by status.status
order by vezes desc

--27: Campeoes por ano (mais ou menos):

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

	--pontos_campeoes_ano

SELECT 
	vw.year,
	max(vw.total) AS max
FROM 
	vw_pontos_ano_id vw
GROUP BY 
	vw.year
ORDER BY 
	vw.year;

  --vw campeoes
   SELECT pa.forename,
    pa.surname,
    pa.total,
    pa.year,
    pa.driverid
   FROM (vw_pontos_ano_id pa
     JOIN vw_pontos_campeoes_ano pc ON ((pc.max = pa.total)));
