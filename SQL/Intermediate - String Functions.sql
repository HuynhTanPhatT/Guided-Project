-------------string functions
--upper() & lower() & len()
select	upper(first_name) as first_name,
		lower(last_name) as last_name,
		len(concat(first_name,' ',last_name)) as Length_Full_Name
from dbo.employee_demographics
order by Length_Full_Name desc;

---left(), right(), substring(string,start,end)
select	first_name,
		left(first_name,3) as left_name,
		substring(first_name,4,2) as mid_name,
		right(first_name,2) as right_name
from dbo.employee_demographics

--Argument data type date is invalid for argument 1 of substring function: Sử dụng substring để xử lý datetime 
select	left(birth_date,4) as Date,
		month(birth_date) as m_name,
		right(birth_date,2) as day
from dbo.employee_demographics

select birth_date
from dbo.employee_demographics

-----Replace()
select	department_name,
		replace(department_name,'r','zh') as replaced_department
from dbo.parks_departments
