select *
from Parks_and_Recreation.dbo.employee_demographics
select * 
from Parks_and_Recreation.dbo.employee_salary
select *
from Parks_and_Recreation.dbo.parks_departments

--------------------------------------------------------
/* A grouped table*/
select	pd.department_name,
		es.employee_id,
		concat(es.first_name,' ',es.last_name) as Full_name,
		es.occupation, es.salary,
		ed.gender,ed.birth_date, convert(date,getdate()) as present_date,
		ed.age as data_age,
		year(convert(date,getdate())) - year(ed.birth_date) as real_age
--into #grouped_table
from dbo.employee_salary es
left join  dbo.parks_departments pd
on es.dept_id = pd.department_id
inner join dbo.employee_demographics ed
on es.employee_id = ed.employee_id
--------------------------------------------------------
--Calculate the percentage of total rows
SELECT
    department_name,
    COUNT(department_name) AS Freq_values,
    cast( COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () as decimal(10,2)) AS percentage_of_orders
FROM dbo.#grouped_table
GROUP BY department_name;

select	gender,
		count(gender) as freq_values,
		cast(count(*) * 100.0 / sum(count(*)) over () as decimal(10,2)) as percentage_of_orders
from dbo.#grouped_table
group by gender;
--------------------------------------------------------
