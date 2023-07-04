with data as (
select
ProductId,
StandardPrice,
rank()over(partition by ProductId order by StandardPrice desc) as rnk
from productvendor
)

select
ProductId,
max(case when rnk=1 then StandardPrice end) - max(case when rnk=2 then StandardPrice end) as diff,
round(((max(case when rnk=1 then StandardPrice end) - coalesce(max(case when rnk=2 then StandardPrice end),0))/max(case when rnk=1 then StandardPrice end)),4)*100 as perc
from 
data
group by 
1
having(round(((max(case when rnk=1 then StandardPrice end) - coalesce(max(case when rnk=2 then StandardPrice end),0))/max(case when rnk=1 then StandardPrice end)),4)*100 <100)
order by 
3 
desc