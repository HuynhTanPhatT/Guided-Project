select *
from dbo.employee_salary
where first_name = 'Leslie'
----------------------------
select *
from dbo.employee_salary
where salary > 50000
----------------------------
select *
from dbo.employee_demographics 
where gender = 'Female' 

-- not equal to: <>  !=
select *
from dbo.employee_demographics
where gender <> 'Female'
----------------------------
-- And or Not - Logical Operation
select *
from dbo.employee_demographics
where year(birth_date) > 1985 and gender = 'Male'

select *
from dbo.employee_demographics
where year(birth_date) > 1985 or not gender = 'Male'

select *
from dbo.employee_demographics
where (first_name= 'Leslie' and age = 44) or (age > 55)
----------------------------
-- Like Statement: %a%, J%, a__(start with a, and then it has 2 characters after)
select *
from dbo.employee_demographics
where first_name like '%a%'

select *
from dbo.employee_demographics
where first_name like 'a__'
----------------------------
