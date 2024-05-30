----==========Download database : https://techtfq.com/blog/practice-writing-sql-queries-using-real-dataset ========---

-----========List down total gold, silver and bronze medals won by each country.==============-------------
----=====First way using pivot table===--

select * from
(
select noc_regions.region, Olympics_Events.noc,medal
from Olympics_Events
JOIN noc_regions ON noc_regions.NOC=Olympics_Events.NOC
where medal in ('Gold','bronze','silver'))
src
pivot (count(medal)
for medal in ([Gold],[Silver],[Bronze]))
piv

ORDER BY GOLD DESC,BRONZE DESC, Silver desc


-----======Second way===--
with t_gold as
(
select noc,count(1) as gold_count from Olympics_Events 
where medal='Gold'
group by noc)
,t_silver as
(
select noc,count(1) as silver_count from Olympics_Events 
where medal='silver'
group by noc
)
,t_bronze as
(
select noc,count(1) as bronze_count from Olympics_Events 
where medal='bronze'
group by noc
)
select distinct noc_regions.region as county,noc_regions.noc,
case when gold_count is null then 0 else gold_count end as gold,
case when silver_count is null then 0 else silver_count end as silver ,
case when bronze_count is null then 0 else bronze_count end  as bronze
from
noc_regions
left join 
t_gold on t_gold.noc=noc_regions.NOC
left join
t_silver on t_silver.noc=noc_regions.NOC
left join
t_bronze on t_bronze.noc=noc_regions.NOC
where 
gold_count is not null or silver_count is not null or bronze_count is not null


---====== Get the top 5 most successful countries in olympics. Success is defined by no of medals won ====-------

with t1 as
(
select noc, count(1) Medals_Count
from 
Olympics_Events
where Medal<>'NA'
group by noc)
,T2 AS
(
select t1.noc,noc_regions.region,Medals_Count,dense_rank()over(order by Medals_Count desc) rn
from t1
join noc_regions on noc_regions.NOC=t1.NOC)
SELECT * FROM T2
WHERE RN <=5;


---------------================List down total gold, silver and bronze medals won by each country corresponding to each olympic games ==========----------

select * from
(
select Olympics_Events.Games, noc_regions.region, Olympics_Events.noc,medal
from Olympics_Events
JOIN noc_regions ON noc_regions.NOC=Olympics_Events.NOC
where medal in ('Gold','bronze','silver'))
src
pivot (count(medal)
for medal in ([Gold],[Silver],[Bronze]))
piv

ORDER BY GOLD DESC,BRONZE DESC, Silver desc


----------================ display for each Olympic Games, which country won the highest gold, silver and bronze medals ======------


select distinct games,CONCAT(FIRST_VALUE(Gold) over(partition by games order by gold desc),
'-',FIRST_VALUE(noc) over(partition by games order by gold desc)) as Max_Gold,

CONCAT(FIRST_VALUE(Silver) over(partition by games order by Silver desc),
'-',FIRST_VALUE(noc) over(partition by games order by Silver desc)) as Max_Silver,

CONCAT(FIRST_VALUE(Bronze) over(partition by games order by Bronze desc),
'-',FIRST_VALUE(noc) over(partition by games order by Bronze desc)) as Max_Bronze
from
(
select games,noc,medal
from 
Olympics_Events
where medal IN ('Gold','Bronze','Silver'))src
pivot
(
 count(medal)
 for medal in ([Gold],[Silver],[Bronze])) as pv

 --------=================== fetch the countries which have won silver or bronze medal but never won a gold medal =============

 
select *
from
(
select noc,medal
from 
Olympics_Events
where medal IN ('Gold','Bronze','Silver'))src
pivot
(
 count(medal)
 for medal in ([Gold],[Silver],[Bronze])) as pv
 where gold=0 and (silver >0 or bronze >0)

 ----------============== Get the event which has won India the highest no of medals ========---------------

 WITH T1 AS(
select noc_regions.region,EVENT,count(medal) MEDAL_Count from 
Olympics_Events
join noc_regions
on Olympics_Events.NOC=noc_regions.noc
where noc_regions.region='India'and medal<>'NA'
GROUP BY noc_regions.region,Event)

SELECT distinct region,FIRST_VALUE(event)over(order by MEDAL_Count desc) as sport,
FIRST_VALUE(MEDAL_Count)over(order by MEDAL_Count desc) from t1;


-----------------==================== Get details of all Olympic Games where India won medal(s) in hockey ========-----------
select SPORT,noc_regions.region,GAMES,COUNT(1) Total_Medal 
from Olympics_Events
join noc_regions 
on noc_regions.NOC=Olympics_Events.noc
where noc_regions.region='India' and sport='Hockey' and Medal <> 'NA'
group by  games,sport,noc_regions.region
order by Total_Medal desc;

-----=====Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games====


-----=======First way
with t1 as(

select *,(Gold+silver+bronze) as total_medals
from
(
select games,noc,Medal
from Olympics_Events
where medal in ('Gold','Bronze','Silver')
)src
pivot
(
count(medal)
for medal in ([Gold],[Silver],[Bronze])
)pv)
select distinct games,
concat(FIRST_VALUE(noc)over(partition by games order by gold desc),'-',FIRST_VALUE(Gold)over(partition by games order by gold desc)) Max_Gold,
concat(FIRST_VALUE(noc)over(partition by games order by silver desc),'-',FIRST_VALUE(silver)over(partition by games order by silver desc)) Max_Silver,
concat(FIRST_VALUE(noc)over(partition by games order by Bronze desc),'-',FIRST_VALUE(Bronze)over(partition by games order by Bronze desc)) Max_Bronze,
concat(FIRST_VALUE(noc)over(partition by games order by total_medals desc),'-',FIRST_VALUE(total_medals)over(partition by games order by total_medals desc)) Max_medals

from t1
order by games;


---====second way

with t1 as(

select * 
from
(
select games,noc,Medal
from Olympics_Events
where medal in ('Gold','Bronze','Silver')
)src
pivot
(
count(medal)
for medal in ([Gold],[Silver],[Bronze])
)pv),
totalMedal1 as
(select noc,games,count(1) total_medals from Olympics_Events group by games,noc)
select distinct t1.games,
concat(FIRST_VALUE(t1.noc)over(partition by t1.games order by gold desc),'-',FIRST_VALUE(Gold)over(partition by t1.games order by gold desc)) Max_Gold,
concat(FIRST_VALUE(t1.NOC)over(partition by t1.games order by silver desc),'-',FIRST_VALUE(silver)over(partition by t1.games order by silver desc)) Max_Silver,
concat(FIRST_VALUE(t1.NOC)over(partition by t1.games order by Bronze desc),'-',FIRST_VALUE(Bronze)over(partition by t1.games order by Bronze desc)) Max_Bronze,
concat(FIRST_VALUE(t1.noc)over(partition by t1.games order by total_medals desc),'-',FIRST_VALUE(total_medals)over(partition by t1.games order by total_medals desc)) Max_medals

from t1
join totalMedal1 on t1.Games=totalMedal1.Games And t1.NOC = totalMedal1.NOC

order by games;
