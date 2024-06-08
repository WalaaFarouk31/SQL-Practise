--create table Currency
--(
--currency_code nvarchar(5),
--Cdate date,
--currency_exchange_rate decimal(10,2)
--);

--insert into Currency values('USD','2024-06-01',1.20);
--insert into Currency values('USD','2024-06-02',1.21);
--insert into Currency values('USD','2024-06-03',1.22);
--insert into Currency values('USD','2024-06-04',1.23);
--insert into Currency values('USD','2024-07-01',1.25);
--insert into Currency values('USD','2024-07-02',1.26);
--insert into Currency values('USD','2024-07-03',1.27);

--insert into Currency values('EGP','2024-06-02',1.2);
--insert into Currency values('EGP','2024-06-03',1.00);
--insert into Currency values('EGP','2024-06-04',0.99);
--insert into Currency values('EGP','2024-07-01',0.85);
--insert into Currency values('EGP','2024-07-02',0.8);
--insert into Currency values('EGP','2024-07-03',0.79);
-----------===============Get the currency at the start and end of each month for each currency=========-----------


select distinct  concat(currency_code,'_',year(Cdate),'_',month(cdate)) currency_code_Year_Month,
FIRST_VALUE(currency_exchange_rate) over (partition by currency_code,month(Cdate) order by cdate) currency_changeRate_BeginningOfMonth, 
FIRST_VALUE(currency_exchange_rate) over (partition by currency_code,month(Cdate) order by cdate desc) currency_changeRate_EndOfMonth

from Currency;