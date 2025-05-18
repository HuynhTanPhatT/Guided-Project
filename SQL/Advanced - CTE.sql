---------------------CTEs
--cho phép người dùng đặt tên và sử dụng một bảng tạm thời trong phạm vi của một truy vấn cụ thể
With salary_metrics as 
(
select	gender, 
		avg(salary) as Avg,
		max(salary) as Max,
		min(salary) as Min,
		count(salary) as Count
from dbo.employee_demographics ed
join dbo.employee_salary es
on ed.employee_id = es.employee_id
group by gender
)
select	gender,
		Avg, Max, Min, Count
   from salary_metrics
;
-------------------------------------
--Two CTEs
With cte_example as 
(
select employee_id, gender, birth_date
from dbo.employee_demographics
where birth_date > '1985-01-01'
),
cte_example2 as
(
select	employee_id, salary
from dbo.employee_salary
where salary > 50000
) 
select *
from cte_example
join cte_example2
on cte_example.employee_id = cte_example2.employee_id
------------------------SubQueries
select *
from (
select	gender, 
		avg(salary) as Avg,
		max(salary) as Max,
		min(salary) as Min,
		count(salary) as Count
from dbo.employee_demographics ed
join dbo.employee_salary es   
on ed.employee_id = es.employee_id
group by gender
) as metrics