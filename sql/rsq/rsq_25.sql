

select 
EmployeeID,
LoginID,
substring_index(LoginID,'\\',1) as domain,
substring_index(LoginID,'\\',-1) as user
from employee