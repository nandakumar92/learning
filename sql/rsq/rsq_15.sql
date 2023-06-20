
select
TerritoryID,
count(SalesOrderID) as orders,
round(count(case when OnlineOrderFlag=0 then SalesOrderID end)/count(SalesOrderID),4)*100 as non_online_perc,
round(count(case when OnlineOrderFlag=1 then SalesOrderID end)/count(SalesOrderID),4)*100 as online_perc
from
salesorderheader
group by 
1
order by 
1
