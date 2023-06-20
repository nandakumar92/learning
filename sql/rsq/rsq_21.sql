
select
a.ProductID,
a.Name,
b.ProductReviewID,
b.ReviewerName,
b.EmailAddress,
d.CustomerID
from product a
join productreview b
on a.ProductID=b.ProductID
join contact c
on b.EmailAddress=c.EmailAddress
left join salesorderheader d
on c.ContactID=d.CustomerID
