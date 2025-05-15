-----Window Functions

--Window Functions
select
		gender, salary,
		avg(salary) over  (partition by gender) as Avg_Salary,
		sum(salary) over (partition by gender order by es.employee_id) as Rolling_salary --Cộng dần theo salary
from dbo.employee_demographics ed
join dbo.employee_salary es
on ed.employee_id = es.employee_id;

--Aggregate Functions:
select	gender,
		avg(salary) as Avg_Salary,
		sum(salary) as Sum_salary
from dbo.employee_demographics ed
join dbo.employee_salary es
on ed.employee_id = es.employee_id
group by gender;
-----------------------------------------------------------------
--Row Number & rank
select	ed.first_name, ed.last_name,
		ed.gender, es.salary,
		ROW_NUMBER() over (partition by ed.gender order by es.salary desc) as row_num,
		rank() over (partition by ed.gender order by es.salary desc) as rank_num,
		DENSE_RANK() over (partition by ed.gender order by es.salary desc) as dense_rank
from dbo.employee_demographics ed
join dbo.employee_salary es
	on ed.employee_id = es.employee_id; 