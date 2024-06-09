--create table customer_tbl
--(
--cid int,
--email nvarchar(26)
--)

----------------------============================Insert data==========---------------
--insert into customer_tbl values(1,'abc@gmail.com');
--insert into customer_tbl values(2,'xyz@gmail.com');
--insert into customer_tbl values(,'pqr@gmail.com');
--insert into customer_tbl values(4,'x@hotmail.com');
--insert into customer_tbl values(5,'rewr32@outlook.com');
--insert into customer_tbl values(6,'pr@yahoo.com');
--insert into customer_tbl values(7,'pr_y');
--insert into customer_tbl values(8,'pr@yahoo');
--insert into customer_tbl values(9,'pr@');

-------============Get the domain of all the email======--------


--select stuff(email, 1, case when CHARINDEX('@',email)>0 then CHARINDEX('@',email) else len(email) end, '') as domain from customer_tbl;

----Or
with cte as 
(
select charindex('@',email) Ind,email from customer_tbl
)
select case when Ind=0 then '' else substring(email,ind+1,len(email)-ind)  end domain  from cte;