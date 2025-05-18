--Sub Queries
--Outer Query là các dòng lệnh bên ngoài subquery
--A query within a query
--Phải lấy đúng bảng dữ liệu, nếu mình lấy park_department thì nó chỉ show ra một row trong khi đó, có hơn 3 rows có employ_id =1
select *
from dbo.employee_demographics
where employee_id in (
	select employee_id
	from employee_salary
	where dept_id = 1
)
--Where employee_id from employee_demographics is trying to match those employee_id in the subquery
--Execute subquery sẽ dễ hiểu hơn
------------------------------------------------
--Compare average salary to everyone
select	first_name, salary,
		( select avg(salary) from dbo.employee_salary)
from dbo.employee_salary
group by first_name, salary
------------------------------------------------
--Nhớ đặt tên cho các cột

select gender, avg(age) as avg_avg, 
		max(age) as max_avg, min(age) as min_avg, 
		count(age) as total_count
from dbo.employee_demographics
group by gender

select *
from 
(
	select	gender, 
			avg(age) as avg_avg, 
			max(age) as max_avg, 
			min(age) as min_avg, 
			count(age) as total_count
	from employee_demographics
	group by gender
)  as Agg_table;

select avg(max_avg)
from 
(
	select	gender, 
			avg(age) as avg_avg, 
			max(age) as max_avg, 
			min(age) as min_avg, 
			count(age) as total_count
	from employee_demographics
	group by gender
)  as Agg_table
group by gender;
