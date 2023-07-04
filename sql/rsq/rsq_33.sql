
SELECT 
    a.SalesPersonID,
    DATE(a.QuotaDate) AS qtr,
    a.SalesQuota,
    SUM(b.SubTotal) AS sales,
    round((SUM(b.SubTotal) - a.SalesQuota)/a.SalesQuota,4)*100 as percent_to_quota
FROM
    salespersonquotahistory a
        JOIN
    salesorderheader b ON a.SalesPersonID = b.SalesPersonID
    and b.OrderDate between DATE(a.QuotaDate) and  date(date_add(a.QuotaDate, interval 90 day)) 
    group by 1,2,3
    order by 5 desc