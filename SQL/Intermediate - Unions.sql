--Union

select employee_id, first_name, last_name
from dbo.employee_demographics
union all
select employee_id, first_name, last_name
from dbo.employee_salary


--Combine two datasets using UNION
select	first_name, last_name,
		(
		case 
		when age < 30 then 'Young'
		when age < 50 then 'Adult'
		else 'Old'
		end 
		+ ' ' +
		case
		when gender = 'Male' then 'Man'
		when gender = 'Female' then 'Woman'
		end) as Label
from dbo.employee_demographics
where age > 40 
Union 
select first_name, last_name, 'Highly Paid Employees' as Label
from dbo.employee_salary
where salary > 70000;

select *
from dbo.employee_demographics
