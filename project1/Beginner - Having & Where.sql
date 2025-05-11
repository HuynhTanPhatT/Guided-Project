--Having & Where
-- Having: Filters the aggregated data - từng nhóm - Dùng sau group by
-- Where: Filters the base data - Từng dòng riêng lẻ - dùng trước group 
select gender, avg(age)
from dbo.employee_demographics
--where avg(age) > 40 #wrong
group by gender
having avg(age)>40

select occupation, AVG(salary) as AVG
from dbo.employee_salary
where occupation like '%City%'
group by occupation
having AVG(salary) > 50000