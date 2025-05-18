---------------- Temporary Tables
CREATE TABLE #temp_table (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favourite_movie VARCHAR(100)
);
select *
from #temp_table;

--Insert data into temp_table
insert into #temp_table
VALUES ('Huynh','Phat','Dextor_NF');
 --------------------------------------------------
 --Another way to creat temp_table

create table #salary_over_50k
(
employee_id int,
first_name varchar(50),
last_name varchar(50),
salary float
);
insert into #salary_over_50k (employee_id, first_name, last_name, salary)
select	employee_id, first_name, last_name, salary
from employee_salary
where salary >= 50000;

select*
from #salary_over_50k

