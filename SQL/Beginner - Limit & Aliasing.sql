--Limit 

select top 5 *
from dbo.employee_salary
order by salary desc

-- Aliasing
select gender, avg(age) as avg_age
from dbo.employee_demographics
group by gender;