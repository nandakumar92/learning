select
year,
max(total) as max,
min(total)as min,
avg(total) as avg
from
(
select
year(a.order_Date) as year,
a.SalesOrderId,
sum(a.subtotal) as total
from
salesorderheader
group by 
1,2
)a
group by 
1