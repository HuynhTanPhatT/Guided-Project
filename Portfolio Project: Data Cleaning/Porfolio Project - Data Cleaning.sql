-------Porfolio Project: Data Cleaning
/* Data Description
total_laid_off : Number of employees laid off
date : Date of layoff
percentage_laid_off :Percentage of employees laid off */

/* Question:
1: Từ tỉ lệ laid với tổng nhân viên lay off, mình truy ngược lại tổng số nhân viên ở thời diểm đó được không ?
nếu 22% = 248 người => 100% = (248/22)*100 = 1127
*/

-----------------------------------------------------------------------------------------
--How to avoid the "divide by zero" error in SQL?: percentage_laid_off  giá trị null / 0
SET ARITHABORT OFF 
SET ANSI_WARNINGS OFF
-----------------------------------------------------------------------------------------
--Check Data Type
select column_name, data_type
from information_schema.COLUMNS
where table_name = 'layoff' and table_schema = 'dbo';

select column_name, data_type
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'layoff_copy' and TABLE_SCHEMA = 'dbo';
-----------------------------------------------------------------------------------------
--- 1. Remove Duplicates
--- 2. Standardize the Data
--- 3. Null Values or Blank Values
--- 4. Remove Any Columns or Rows which are not necessary
-----------------------------------------------------------------------------------------
/* Create a copy table: The reason to create a copy table, because if we make mistakes => destroy the raw data */
/* In the workplace, we dont work on the raw data*/
select * 
into layoff_copy
from dbo.layoff;

select *
from dbo.layoff_copy;

/* 1.Identify Duplicates: 'Cazoo',...*/
With duplicates_cte as (
select	*,
		row_number() over (partition by company, location, total_laid_off,date, 
										percentage_laid_off, industry, stage, funds_raised, country  order by date) as row_num
from layoff_copy
)
delete
from duplicates_cte
where row_num > 1;

/* 2. Standardize the Data */
select	company,
		trim(company)
from dbo.layoff_copy 

--a/Remove white spaces
Update dbo.layoff_copy
set company = trim(company);

--b/Remove ,Non-U.S & ,Raleigh & ,Victoria & ,New York City   || Malmö => Malmo / Düsseldorf => Dusseldorf  
select distinct(location)
from dbo.layoff_copy
order by 1;

update dbo.layoff_copy
set location = replace(replace(replace(replace(replace(location, ',Non-U.S.', ''), ',Raleigh', ''), ',Raleigh', ''),',Victoria',''),',New York City','')

update dbo.layoff_copy
set location = 'Malmo'
where location like 'Malmö'

update dbo.layoff_copy
set location = 'Dusseldorf'
where location like 'Düsseldorf'

--c/ convert a string to datetime [date column]
update dbo.layoff_copy
set date = cast(date as date);
---Change the format to date
ALTER TABLE dbo.layoff_copy
alter column date DATE;

/* 3. Null values and Blank Values */
--a/ Note: Appsmith => Industry Null => Không thể thêm dữ liệu để hết null được bởi vì chỉ có 1 công ty  => Set to 'Other'
update dbo.layoff_copy
set industry = 'Other'
where industry is null;

select *
from dbo.layoff_copy
where company = 'Appsmith'
--where industry is null or industry = ''

--b/ If there is no lay off in the company based on "Total_laid_off" and "Percentage_laid_off"" 
--When filter null value from total_laid_off, i see that there are lots of percentages column also have null values. 
--I don't think is nesscary to keep total and percentages are null in a row
select *
from dbo.layoff_copy
where total_laid_off is null
and percentage_laid_off is null;

-----------------------------------------------------------------------------------------








--Bởi vì percentage_laid_off có ký tự % nên là string => mình sẽ rút số ra bỏ %
--Take all the values from left except '%'
select left(percentage_laid_off,len(percentage_laid_off)-1)
from dbo.layoff_copy

select	company,
		location, 
		total_laid_off, percentage_laid_off, 
		((total_laid_off / left(percentage_laid_off,len(percentage_laid_off)-1))*100) as total_employee_before_laidoff
from dbo.layoff_copy

---------------------------------------------------------
