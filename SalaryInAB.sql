--create table tableA
--(
--empid int,
--ename nvarchar(10),
--SALARY INT
--)

--ALTER table tableB ADD  SALARY INT 


--create table tableB
--(
--empid int,
--ename nvarchar(10),
--SALARY INT
--)

--insert into  tableA VALUES(1,'AA',1000);
--insert into  tableA VALUES(2,'BB',300);
--insert into  tableB VALUES(2,'BB',400);
--insert into  tableB VALUES(3,'BB',100);


-===- select the salary for each employee given that if same employee is repeated in both tables then get minimum salary======---

WITH CTE AS
(
SELECT *
FROM tableA A
UNION 
SELECT * FROM TABLEB B
)
SELECT EMPID,ENAME,MIN(SALARY) AS MinimusSalary FROM CTE
GROUP BY EMPID,ENAME ;