--create table Sales
--(
--dt datetime,
--sales int
--);

----==========get the precetage of improvement from the previous sales===----

with t1 as
(
select *,lag(sales,1,0) over(order by dt) PreviousSales
from sales)
select dt,
case when PreviousSales=0 then 0 else ((sales-PreviousSales)*100/PreviousSales) end VarPrecentage
from t1
where PreviousSales<=sales ;