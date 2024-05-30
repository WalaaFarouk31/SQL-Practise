--create table UserActivity
--(
--username nvarchar(100),
--activity nvarchar(100),
--startDate smalldatetime,
--endDate smalldatetime
--);


---Get the second activity of each user and the first activity if he only has one activity

with T1 as(
select * ,ROW_NUMBER()over(partition by username order by enddate desc) rn,
count(1)over(partition by username) TotalActivities
from UserActivity)
select USERNAME,ACTIVITY,STARTDate,endDate 
from T1
where rn = case when TotalActivities =1 then 1 else 2 end
