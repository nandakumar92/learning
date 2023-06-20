
with data as (
select
a.SalesOrderId,
b.productId,
d.Name,
b.OrderQty
from
salesorderheader a 
join
salesorderdetail b
on a.SalesOrderId=b.SalesOrderId
join product c
on b.productId=c.productId
join productsubcategory d
on c.ProductSubcategoryID=d.ProductSubcategoryID
),

-- bikes as (
-- select
-- round(count((case when bike>0 and components>0 then SalesOrderId end))/count(SalesOrderId),4)*100
-- from
-- (
-- select
-- SalesOrderId,
-- sum(case when Name='Bike' then OrderQty end) as bike,
-- sum(case when Name='Accessories' then OrderQty end) as components
-- from
-- data
-- group by 
-- 1
-- )a

bikes as (
select
SalesOrderId,
sum(case when Name='Bikes' then OrderQty end) as bike,
sum(case when Name='Accessories' then OrderQty end) as components
from
data
group by 
1
),

two_products as (
select
SalesOrderId
from
data
where Name='Bikes'
group by 
1
having(count(distinct productId)>=2)
)

select
a.SalesOrderId
from
bikes a 
join two_products b
on a.SalesOrderId=b.SalesOrderId