-----------Stored Procedure
-- A way to save your SQL code that you can resus



--Create Procedure
CREATE PROCEDURE over50_salary2 as
Begin
	select *
	from dbo.employee_salary
	where salary >= 50000; --Bởi vì có 2 điều kiện nên sẽ có 2 bảng được print ra
	select *				-- Rỗng thì không đáp ứng điều kiện
	from dbo.employee_salary
	where salary >= 100000;
End;

--Execute the table by using EXEC + Table_name
exec over50_salary2

---------------------------------------------------------------------------------
--Practice

CREATE PROCEDURE Healling_Department1 as
Begin
	With department as (
	select *
	from dbo.parks_departments
	where department_id <=4
	)
	select d.department_name, es.first_name,es.last_name, es.occupation, es.salary
	from department d
	join dbo.employee_salary es
	on d.department_id = es.employee_id
end;

exec Healling_Department1
