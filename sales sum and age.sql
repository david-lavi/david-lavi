/****** this quarry shows a table from chapter 2 data base ******/
SELECT*
  FROM [Chapter 2 - Sales ].[dbo].[Customer]
  SELECT*
  FROM[dbo].[OnlineSales]
  select*
from[dbo].[Geography]
/****** this quarry shows the avrage salary and the sum of sales to all custmers and partitiond by age
i have also  showed  what date the first order and last order had been plased for that age group ******/
    select  distinct mytable.age,avg(mytable.YearlyIncome) as avgsalary,sum(mytable.SalesAmount) as sumsales
	,min(mytable.firstorder) as firstorderage,max(mytable.lastorder) as lastorderbyage
from(
  select [dbo].[OnlineSales].CustomerKey,[dbo].[Geography].City,datediff(year,BirthDate,getdate()) as age,YearlyIncome,EducationLevel,SalesAmount
  ,min(OrderDate) over(PARTITION by [dbo].[OnlineSales].CustomerKey) as firstorder
  ,max(DueDate)  over(PARTITION by [dbo].[OnlineSales].CustomerKey) as lastorder
  from[dbo].[Customer]
  join [dbo].[OnlineSales] on [dbo].[Customer].CustomerKey=[dbo].[OnlineSales].CustomerKey
  join [dbo].[Geography] on [dbo].[Customer].GeographyKey=[dbo].[Geography].GeographyKey
  ) as mytable
  group by mytable.age
  order by sumsales desc
  /*this quarry does the same as the above qurry but allso groupes the ages by age groups and makes a new table callad income_and_salary_by_age1 
 which we can forther manipulate to extrect more data*/
        select distinct mytable.age, avg(mytable.YearlyIncome) as avgsalary,sum(mytable.SalesAmount) as sumsales,
	    	 case
    when mytable.age between 36 and 65 then 'adult'
	  when mytable.age between 65 and 99 then 'senior'
	   when mytable.age >= 99   then 'centenarian'
	   end as grouped_age
	    into [Chapter 2 - Sales ].dbo.income_and_salary_by_age1
from(
  select [dbo].[OnlineSales].CustomerKey,[dbo].[Geography].City,datediff(year,BirthDate,getdate()) as age,YearlyIncome,EducationLevel,SalesAmount
  from[dbo].[Customer]
  join [dbo].[OnlineSales] on [dbo].[Customer].CustomerKey=[dbo].[OnlineSales].CustomerKey
  join [dbo].[Geography] on [dbo].[Customer].GeographyKey=[dbo].[Geography].GeographyKey
  ) as mytable
  group by  mytable.age
  order by mytable.age


  /*this quarry shows the avg salary and sum of sales partitiond by grouped age by the table craeted by quarry above */
  select grouped_age,sum(avgsalary) as avg_salary_by_group,sum(sumsales) as sum_sales_for_group
  from [dbo].[income_and_salary_by_age]
  group by grouped_age

