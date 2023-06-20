with data as (
select
a.CreditCardId,
STR_TO_DATE(concat(b.ExpMonth,"-30-",b.ExpYear),"%m-%d-%y") as expdt,
cast(max(a.OrderDate) as date) as last_order_date
from
salesorderheader a
join
creditcard b
on a.CreditCardId=b.CreditCardId
group by 
1,2
)

select
a.CreditCardId,
a.expdt,
a.last_order_date,
count(distinct case when cast(b.OrderDate as Date)<=a.expdt then SalesOrderID end) as orders_before,
count(distinct case when cast(b.OrderDate as Date)>a.expdt then SalesOrderID end) as orders_after
from
data a 
join
salesorderheader b
on a.CreditCardId=b.CreditCardId
group by 
1,2,3

