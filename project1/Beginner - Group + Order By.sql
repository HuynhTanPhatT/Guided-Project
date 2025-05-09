-- Group by
select	gender,
		avg(age) as avg_age,
		min(age) as Min_Age, max(age) as Max_Age ,
		count(age) as Freq_values
from dbo.employee_demographics
group by gender

select occupation, sum(salary) as Total_Salary
from dbo.employee_salary
group by occupation

-----------------------------------------------------------------
--Order by
select * 
from dbo.employee_demographics
order by first_name asc;

select * 
from dbo.employee_demographics
order by first_name desc;

select *
from dbo.employee_demographics
order by gender , age desc;