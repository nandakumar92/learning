
with data as (
select
a.SalesOrderId,
b.productId,
e.Name,
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
join productcategory e
on d.ProductCategoryID=e.ProductCategoryID
)

select
Bikes,
Clothing,
Components,
Accessories,
count(distinct SalesOrderId) as orders
from
(
select
SalesOrderId,
max(case when Name='Bikes' then 1 else 0 end) as Bikes,
max(case when Name='Clothing' then 1 else 0 end) as Clothing,
max(case when Name='Components' then 1 else 0  end) as Components,
max(case when Name='Accessories' then 1 else 0  end) as Accessories
from
data
group by
1
)a
group by
1,2,3,4


