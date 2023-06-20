

select
LocationId,
products,
qty,
sum(products)over(order by LocationId) as cum_products,
sum(qty)over(order by LocationId) as cum_qty
from
(
select
a.LocationId,
count(distinct ProductID) as products,
sum(quantity) as qty
from
productinventory a
group by
1
)a