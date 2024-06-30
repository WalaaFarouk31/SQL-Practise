--create table Products_tbl
--(
--pid int primary key identity(1,1),
--pname nvarchar(10) not null,
--price int not null
--)

--create table transaction_tbl
--(
--pid int FOREIGN key references Products_tbl(pid),
--sold_date date not null,
--qty int not null,
--amount int not null
--)

--insert into Products_tbl values('A',1000);
--insert into Products_tbl values('B',400);
--insert into Products_tbl values('C',500);

--INSERT into transaction_tbl values(1,'2024-02-01',2,2000);
--INSERT into transaction_tbl values(1,'2024-03-01',4,4000);
--INSERT into transaction_tbl values(1,'2024-03-15',2,2000);
--INSERT into transaction_tbl values(3,'2024-04-24',3,1500);
--INSERT into transaction_tbl values(3,'2024-05-16',5,2500);

-------==================Find product wise total amount, including products with no sales=============----------
with SourceData as
(
select pid,month(sold_date) Sold_Month,sum(amount)total_sales
from transaction_tbl
group by pid,month(sold_date)),
YearMonths as
(
SELECT 1 AS num
    UNION ALL
    SELECT num+1 FROM YearMonths WHERE num+1<=12
)
select num,pname,coalesce( SourceData.total_sales,0) Sales from YearMonths cross join Products_tbl
left join SourceData on  Products_tbl.pid=SourceData.pid and SourceData.Sold_Month=YearMonths.num 
order by Products_tbl.pid, YearMonths.num;
