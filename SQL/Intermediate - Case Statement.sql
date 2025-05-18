select (
		case
		when age <=30 then 'Young'
		when age between 31 and 50 then 'Old'
		end) as age_bracker
from dbo.employee_demographics ed
inner join dbo.employee_salary es
on ed.employee_id = es.employee_id
inner join dbo.parks_departments pd
on es.dept_id = pd.department_id

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% Bonus

select	first_name, last_name, 
		(
		case
		when salary < 50000 then salary + (salary* 0.05)
		when salary > 50000 then salary + (salary * 0.07)
		end) as new_salary,
		(
		case
		when dept_id = 6 then salary* 0.1
		end) as bonus
from dbo.employee_salary
