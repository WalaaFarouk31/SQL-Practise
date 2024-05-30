--create table LIFT_Passangers
--(
--Passanger_Name nvarchar(100),
--Weight_KG INT,
--LIFT_ID INT
--)

--Create table lift
--(ID INT,
--CAPACITY_KG INT
--)


----==========Get the passengers that can get on that plane without exceeding the maximum capacity

with t1 as(
select *, 
sum(weight_kg) over(partition by lift_id order by Passanger_Name) as totalWeight
from LIFT_Passangers)
select lift.id,STRING_AGG(Passanger_Name,',') as passangers  from t1
join lift on lift.id=t1.LIFT_ID
where t1.totalWeight<=lift.CAPACITY_KG
group by lift.id;