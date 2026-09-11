/* Level 1 */
use SalesDB;

/*
1 Write a query to find the second highest salary in an employee table.
*/
with cte as (
select *,
ROW_NUMBER() over(order by salary desc) as rn
from Sales.Employees
)
select Salary as second_highest_salary 
from cte
where rn = 2;

/*
2 Fetch all employees whose names contain the letter "a" exactly twice.
*/
with cte as (
select *, CONCAT(FirstName, ' ', LastName) as FullName 
from Sales.Employees
)
select FullName 
from cte
where FullName like '%a%a%' and FullName not like '%a%a%a%';

with cte as (
select *, CONCAT(FirstName, ' ', LastName) as FullName 
from Sales.Employees
)
select FullName 
from cte
where len(FullName) - LEN(lower(REPLACE(FullName, 'a', ''))) = 2;

/*
3 How do you retrieve only duplicate records from a table?
*/
with cte as (
select *,
ROW_NUMBER() over(partition by EmployeeID order by EmployeeID) as rn
from Sales.Employees
)
select * 
from cte
where rn <> 1;


/*
4 Write a query to calculate the running total of sales by date.
*/
select *,
SUM(sales) over(order by OrderDate rows between unbounded preceding and current row) as running_total
from Sales.Orders;

/*
5 Find employees who earn more than the average salary in their department.
*/
with cte as (
select *,
AVG(Salary) over(partition by Department) as avg_salary
from Sales.Employees
)
select * 
from cte
where Salary >= avg_salary;

/*
6 Write a query to find the most frequently occurring value in a column.
*/
with cte as (
select Sales, COUNT(Sales) as count_sales
from Sales.Orders
group by Sales
)
select Sales 
from cte 
where count_sales = (select MAX(count_sales) from cte);

/*
7 Fetch records where the date is within the last 7 days from today.
*/

select * from Sales.Orders
where DATEDIFF(D,CreationTime, GETDATE()) = 7;

select * from Sales.Orders
where CreationTime between GETDATE()-7 and GETDATE();

/*
8 Write a query to count how many employees share the same salary.
*/
select Salary, COUNT(EmployeeID) as total_employees
from Sales.Employees
group by Salary
having COUNT(EmployeeID) > 1;

/*
9 How do you fetch the top 3 records for each group in a table?
*/
with ranked_sales as (
select o.OrderID,
        o.ProductID,
        o.Sales,
        p.Category,
        p.Product,
dense_rank() over(partition by p.Category order by o.Sales desc) as sales_rank
from Sales.Orders as o
left join Sales.Products as p
on o.ProductID = p.ProductID
)
select * from ranked_sales
where sales_rank <=3 
order by Category, sales_rank;
 
/*
10 Retrieve products that were never sold
*/
select p.ProductID, p.Product, p.Category, p.Price
from Sales.Orders as o
right join Sales.Products as p
on o.ProductID = p.ProductID
where o.OrderID is null;

/* Level 2 */

/*
1 Retrieve customers who made their first purchase in the last 6 months.
*/
with cte as (
select CustomerID, MIN(OrderDate) as FirstOrderDate
from Sales.Orders
group by CustomerID
)
select * 
from cte as o
left join Sales.Customers as c
on o.CustomerID = c.CustomerID
where o.FirstOrderDate >= DATEADD(MONTH, -6, GETDATE());

/*
2 How do you pivot a table to convert rows in columns?
*/
select EmployeeID, FirstName, department, salary
from (
select EmployeeID, FirstName, Marketing, Sales, Hr , Gender
from (
select * 
from Sales.Employees
) as source_table
pivot (
sum(salary)
for department in (Marketing, Sales, Hr)
) as pivot_table
) as p
unpivot (
salary
for department in (Marketing, Sales, Hr)
) as unpivot_table;

/*
3 Write a query to calculate the percentage change in sales month-over-month.
*/
with cte as (
select MONTH(OrderDate) as Month_name, SUM(Sales) as total_sales
from Sales.Orders
group by MONTH(OrderDate)
),
cte1 as (
select *,
Lag(total_sales) over(order by Month_name) as previous_month_sales
from cte
)
select *,
Round(((total_sales - previous_month_sales) * 100) / (nullif(previous_month_sales, 0)), 2) as percent_change
from cte1;



/*
4 Find the median salary of employees in a table.
*/
with cte as (
select * ,
ROW_NUMBER() over (order by Salary) as rn,
count(*) over() as total_counts
from Sales.Employees
),
cte1 as (
select salary 
from cte 
where rn in ((total_counts+1)/2, (total_counts+2)/2) 
)
select AVG(salary) as median_salary
from cte1;

/*
5 Fetch all users who logged in consecutively for 3 days or more.
*/



/*
6 Write a query to delete duplicate rows while keeping one occurrence.
*/



/*
7 Create a query to calculate the ratio of sales between two categories.
*/



/*
8 How would you implement a recursive query to generate a hierarchical structure?
*/




/*
9 Write a query to find gaps in sequential numbering within a table.
*/





/*
10 Split a comma-separated string into individual rows using SQL.
*/


/* Advanced Problem-Solving*/

/*
1 Rank products by sales in descending order for each region.
*/






/*
2 Fetch all employees whose salaries fall within the top 10% of their department.
*/





/*
3 Identify orders placed during business hours
*/





/*
4 Write a query to get the count of users active on both weekdays and weekends.
*/




/*
5 Retrieve customers who made purchases across at least three different categories.
*/
