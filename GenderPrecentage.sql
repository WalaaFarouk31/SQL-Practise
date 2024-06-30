--create table Employees
--(
--eid int primary key identity(1,1),
--ename nvarchar(50),
--gender nvarchar(10)
--)

--insert into EMployees values('John Doe','Male');
--insert into EMployees values('John Doe','Male');
--insert into EMployees values('Jane Smith','Female');
--insert into EMployees values('Michael Johnson','Male');
--insert into EMployees values('Emily Davis','Female');
--insert into EMployees values('Robert Brown','Male');
--insert into EMployees values('Sophia Wilson','Female');
--insert into EMployees values('David Lee','Male');
--insert into EMployees values('Emma White','Female');
--insert into EMployees values('James Taylor','Male');
--insert into EMployees values('William Clark','Male');


-------------------------Get the precentage of each gender----------------------------

--=====Way1======----
with cte as(
select sum(case when gender='Male' then 1 else 0 end) as MaleCount,
count(1) as totalCount
from EMployees)
select MaleCount*100/totalCount AS MALE_PERC, (totalCount-MaleCount)*100/totalCount AS FEMALE_PERC
from cte;

----======Way2======------

SELECT [Male]*100/( [Male]+[Female]) as Male_Perc, [Female]*100/([Male]+[Female]) as Female_Perc
FROM  
(
  SELECT gender
  FROM EMployees
) AS SourceTable  
PIVOT  
(  
  count(gender) 
  FOR gender IN ([Male], [Female])  
) AS PivotTable; 
