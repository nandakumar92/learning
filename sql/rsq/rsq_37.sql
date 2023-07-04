
with data as (
select
a.WorkOrderID,
a.DueDate,
a.ProductID,
a.OrderQty,
a.ScrappedQty,
ScrappedQty/OrderQty as scrap_rate,
row_number()over(order by ScrappedQty/OrderQty desc ) as rn
from workorder a
where ScrappedQty/OrderQty >=0.03
),

perc as (
select
round(0.10* count(*),0) as rows2
from
data
)

select
* from data a 
where rn <= (select rows2 from perc)
order by 
DueDate desc
