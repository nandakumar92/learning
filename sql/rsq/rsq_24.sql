with data as (
select
year(OrderDate) as yr,
month(OrderDate) as mth, 
count(OrderDate)over(partition by year(OrderDate),month(OrderDate) order by OrderDate) as days,
sum(subtotal)over(partition by year(OrderDate),month(OrderDate)order by OrderDate) as rev
from
(
select
OrderDate,
sum(subtotal) as subtotal
from
salesorderheader
group by 
1
)a
)


select
yr
,mth
,max(rev) as max_rev
,max(days) as max_days
, max(rev)/max(days)  as rev_per_day
from
data
 group by 
 1,2
 
