--create table DeptScores
--(
--eid int,
--dept nvarchar(10),
--scores int
--);

--insert into DeptScores values(1,'d1',1);
--insert into DeptScores values(1,'d1',1);
--insert into DeptScores values(2,'d1',5.28);
--insert into DeptScores values(3,'d1',4);
--insert into DeptScores values(4,'d2',8);
--insert into DeptScores values(5,'d1',2.5);
--insert into DeptScores values(6,'d2',7);
--insert into DeptScores values(7,'d3',9);
--insert into DeptScores values(8,'d4',10.2);


---- =========selecting the same data with maximum score per each department=========-------------
select eid,dept,
max(scores)over(partition by dept) MaxScores
from DeptScores
order by eid;

----=========Update that column score to have the maximum score of the department========--------

update DeptScores set scores=(select max(scores) from DeptScores inn where DeptScores.dept=inn.dept);


