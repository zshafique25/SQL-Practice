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



/*
4 Write a query to calculate the running total of sales by date.
*/
select *,
SUM(sales) over(order by OrderDate rows between unbounded preceding and current row) as running_total
from Sales.Orders;

/*
5 Find employees who earn more than the average salary in their department.
*/
select *,
AVG(Salary) over(partition by Department) as avg_salary
from Sales.Employees;

/*
6 Write a query to find the most frequently occurring value in a column.
*/


/*
7 Fetch records where the date is within the last 7 days from today.
*/

/*
8 Write a query to count how many employees share the same salary.
*/


/*
9 How do you fetch the top 3 records for each group in a table?
*/


/*
10 Retrieve products that were never sold
*/




/* Level 2 */

/*
1 Retrieve customers who made their first purchase in the last 6 months.
*/



/*
2 How do you pivot a table to convert rows in columns?
*/




/*
3 Write a query to calculate the percentage change in sales month-over-month.
*/




/*
4 Find the median salary of employees in a table.
*/




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
