-----Exploratory Data Analysis
select *
from dbo.layoff_copy

------------------------------------------------------------------------------------------------
/* Add a "Total employee before laid off" column */
-- Total = laid_off / percentage => Percentage = (total / laid_off)*100 || laid_off = total * percentage
-- Take all the values from left except '%':  left(percentage_laid_off,len(percentage_laid_off)-1)
Alter table dbo.layoff_copy
add "total_employee_before_laid_off" float

UPDATE dbo.layoff_copy
SET total_employee_before_laid_off = CAST(
    NULLIF(total_laid_off, 0) / 
    NULLIF(CAST(LEFT(percentage_laid_off, LEN(percentage_laid_off) - 1) AS FLOAT) / 100.0, 0)
    AS INT
);


select *
from dbo.layoff_copy
------------------------------------------------------------------------------------------------
select	 year(date) as year, sum(total_laid_off) as layoffs
from layoff_copy
group by year(date)
order by year(date) asc;

--The number of layoff happend in every month
select	country,
		COUNT(total_laid_off) as 'The total number of lay off',
		sum(total_laid_off) as 'employee_laid_off',
		month(date) as month, year(date) as year
from dbo.layoff_copy
group by country, month(date), year(date)
order by year(date), month(date) asc;

select *
from dbo.layoff_copy
where percentage_laid_off = 100
order by total_laid_off desc;



--Rolling lay offs with Date 
-- Extract year 
with rolling_total as (
select	cast(year(date) as varchar(4)) + '-'+ right('0' + cast(month(date) as varchar(2)),2) as YearMonth,
		sum(total_laid_off) as laid_off
from dbo.layoff_copy
group by month(date), year(date)
)
select	YearMonth, laid_off,
		sum(laid_off) over(order by YearMonth) as RollingTotal, laid_off
from	rolling_total;



--Which Year They laid off the most
WITH company_year as (
select	company,
		year(date) as year,
		sum(total_laid_off) as total_laid_off
from dbo.layoff_copy
group by company, year(date)
), Company_Year_Rank as (
select	*,
		DENSE_RANK() over( partition by year order by total_laid_off desc) as rank_c_laid_off
from company_year
where total_laid_off is not null
)
select *
from Company_Year_Rank
where rank_c_laid_off <=5;
