--CREATE TABLE EMployees
--(
--EId int identity(1,1) primary key,
--Empname nvarchar(50),
--Salary int ,
--managerId int references EMployees(Eid)
--)


-----=============Get Employee whose salary is greater than manager salary=======------

select emp.Empname from EMployees emp
left join EMployees Mangers on emp.managerId=Mangers.eid
where Mangers.salary<emp.salary;