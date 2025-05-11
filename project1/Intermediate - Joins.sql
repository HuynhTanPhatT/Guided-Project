select *
from dbo.employee_demographics
select *
from dbo.employee_salary
select *
from dbo.parks_departments
---------------------------------------------------------------
--Full Outer Join
select	es.employee_id,
		concat(es.first_name,' ',es.last_name) as full_name,
		concat(ed.first_name,' ',ed.last_name) as full_name,
		es.occupation, es.salary,
		ed.age, ed.gender, ed.birth_date
from dbo.employee_demographics ed
full outer  join dbo.employee_salary es
on ed.employee_id = es.employee_id
order by es.employee_id asc;
---------------------------------------------------------------
-- Left Join
select	es.employee_id,
		concat(es.first_name,' ',es.last_name) as full_name,
		es.occupation, 
		ed.age, ed.gender, ed.birth_date
from dbo.employee_demographics ed
right join dbo.employee_salary es
on ed.employee_id = es.employee_id
order by es.employee_id asc;
---------------------------------------------------------------
-- Left Join
select	es.employee_id,
		concat(es.first_name,' ',es.last_name) as full_name,
		concat(ed.first_name,' ',ed.last_name) as full_name,
		es.occupation, es.salary,
		ed.age, ed.gender, ed.birth_date
from dbo.employee_demographics ed
left join dbo.employee_salary es
on ed.employee_id = es.employee_id
order by es.employee_id asc;
------------------------------------------------- --------------
--Self Join : Thêm dữ liệu cho Ron Swaanson
select	es1.employee_id as  emp_santa, 
		concat(es1.first_name,' ',es1.last_name) as full_name,
		es1.salary,
		es2.employee_id as emp_santa,
		concat(es2.first_name,' ',es2.last_name) as full_name,
		es2.salary
from dbo.employee_salary es1
join dbo.employee_salary es2
on es1.employee_id + 1 = es2.employee_id

-------------------------------------------------
--Joining Multiple Tables
select	es.employee_id,
		concat(es.first_name,' ',es.last_name) as full_name,
		ed.age, ed.gender, ed.birth_date,
		es.occupation, es.salary,
		pd.department_id, pd.department_name
from dbo.employee_demographics ed
right join dbo.employee_salary es
on ed.employee_id = es.employee_id
left join dbo.parks_departments pd
on es.dept_id = pd.department_id
order by  es.employee_id asc;


