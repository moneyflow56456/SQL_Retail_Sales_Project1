-- project 1 creating the database
create database project_1;
-- create table
create table sales_project(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id	 int,
gender varchar(12),
age int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select * from sales_project
where transactions_id is null;

select * from sales_project
where sale_date is null;

select * from sales_project
where sale_time is null;

select * from sales_project
where customer_id is null;

select * from sales_project
where gender is null;

select * from sales_project
where quantiy is null;

select * from sales_project
where price_per_unit is null;

select * from sales_project
where cogs is null;

select * from sales_project
where total_sale is null;

-- Data Exploration 

-- How many sales do we have?

select * from sales_project;
select count(*) total_sale from sales_project;

-- How many unique customers we have?

select count(distinct customer_id) as total_sale from sales_project;

-- How many categories we have?
select category from sales_project group by category;
select distinct category from sales_project;

-- Q1 write a sql query to retrieve all columns for sales made on '2022-11-05'

select * from sales_project
where sale_date = '2022-11-05';

-- Q2 Write A SQL Query To Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of nov-2022
select * from sales_project where category='clothing' and quantiy>3;

select category, sum(quantiy) from sales_project where category ='Clothing' group by quantiy;

select * from sales_project where category='clothing' and DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' and quantiy >=3;

-- Q3 write a sql query to calculate the total sales (total_sale) of each category

select sum(total_sale) as Total_sales,category, count(*) as total_orders from sales_project group by category;

-- Q4 write a sql query to find the average age of customers who purchased  items from 'beauty' category

select round(avg(age),2) as avg_age from sales_project where category='beauty';

-- Q5 write a sql query to find all the transactions where the total_sales is greater than 1000

select total_sale from sales_project where total_sale>1000;

-- Q6 write a sql query to find the total number of transactions (transaction_id) made by each gender in each category 

select category,gender, count(*) as transactions from sales_project group by category,gender order by 1;

-- Q7 write a sql query to calculate the average sale of each month. Find out the best selling month in each year 

  select year(sale_date),month(sale_date), avg(total_sale) as avg_sale, rank() over(partition by year(sale_date)
  order by avg(total_sale) desc) as rank_ from sales_project group by 1,2 order by 1,3 desc;
  
 -- Q8  write a sql query to find the top 5 customers based on the highest total sale 
 
select customer_id, sum(total_sale) as total from sales_project group by 1 order by 2 desc limit 5;

-- Q9 write a sql query to find the number of unique customers who purchased items from each category

select category,count(distinct(customer_id)) from sales_project group by 1;

-- Q 10 write a sql query to create each shift and number of order (example morning <=12 , afternoon betweeen 12-17, evening >17

select *, 
case 
   when hour(sale_time) <12 then 'morning'
   when hour(sale_time) between 12 and 17 then 'afternoon'
   else 'evening'
end as shift
from sales_project;
 
 -- Q8  write a sql query to find the top 5 customers based on the highest total sale 
 
 select customer_id,sum(total_sale) as total_sale  from sales_project group by 1 order by 2 desc limit 5;
  

-- Q2 Write A SQL Query To Retrieve all transactions where the category is 'Clothing' and the quantity sold is 
-- more than 10 in the month of nov-2022

select *  from sales_project where category='clothing' and  date_format(sale_date, '%Y-%m') ='2022-11' and quantiy>=3; 

-- Q6 write a sql query to find the total number of transactions (transaction_id) made by each gender in each category 
select category,gender, count(*) as transactions from sales_project group by 1,2 order by 1;

-- Total kitni transactions hain?
select count(*) as transaction from sales_project;

-- Unique categories kaun-kaun si hain?
select distinct(category) from sales_project;

-- Sirf Clothing category ka data dikhao

select * from sales_project where category='clothing';

-- Jinki age 40 se zyada hai unka data dikhao

select * from sales_project where age>40;

-- Har category ka total sales nikaalo

select category,sum(total_sale) as total_sale from sales_project group by category;

-- Average age by gender

select round(avg(age),2) as avg_age from sales_project;

-- Kaunsi category sabse zyada revenue generate kar rahi hai

select category, sum(total_sale) as highest_revenue from sales_project group by 1 order by 2 desc limit 1;

-- Har month ka total revenue

select year(sale_date),month(sale_date), sum(total_sale) as total_reenue from sales_project group by 1,2;

-- Top 5 customers by total spending

select customer_id, sum(total_sale) as total_spending from sales_project group by 1 order by 2 desc limit 5;

-- Kis age group ne sabse zyada spending ki 
 
 select age, sum(total_sale) as total_spending from sales_project group by 1 order by 2 desc;
 
 -- Morning sales vs Evening sales compare karo
with hourly_sale
as 
(
select *,
 case
    when hour(sale_time) <12 then 'morning'
    when hour(sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
    end as shift
from sales_project
)
    select shift , count(*) as total_orders 
from hourly_sale
group by shift;


SELECT 
CASE
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 50 THEN '36-50'
    ELSE '50+'
END AS age_group,
SUM(total_sale) AS total_spending
FROM sales_project
GROUP BY age_group
ORDER BY total_spending DESC;


 