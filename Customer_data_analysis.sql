-- Select Database & View Tables
use project_customer_segmentation;
show tables;

-- 
select * 
from customer;

-- Check for Duplicate Records
select invoice_no,customer_id,count(*)
from customer
group by invoice_no,customer_id
having count(*) > 1;

-- Identify Missing Values
select
sum(Invoice_no is null) as miss_invoiceno,
sum(customer_id is null) as miss_customerid,
sum(gender is null) as miss_gender,
sum(age is null) as miss_age
from customer;

-- Detect Age Outliers
-- check outlier detection in age column
select *
from customer 
where age <10 or age>90;

-- check for invalid or negative quantity
select * 
from customer
where quantity <= 0;

-- Identify incorrect gender entries
select *
from customer 
where gender in ('f','M');

-- Tasks

-- TASK 1: How is the shopping distribution according to gender?
select gender,count(*) as total_shopping
from customer
group by gender;

-- TASK 2: Which gender did we sell more products to?
select gender, count(*) as  total_product_sold
from customer
group by gender 
order by total_product_sold desc
limit 1;

-- TASK 3: Which gender generated more revenue?
select gender,sum(quantity*price) as total_revenue
from customer
group by gender 
order by total_revenue desc
limit 1;

-- TASK 4: Distribution of purchase categories relative to other columns
select category,count(*) as total_transactions
from customer
group by category;

-- TASK 5: How is the shopping distribution according to age?
select age,count(*) as total_shopping
from customer
group by age
order by age;

-- TASK 6: Which age category bought the most products?
select 
 case
  when age between 18 and 25 then '18-25'
  when age between 26 and 35 then '26-35'
  when age between 36 and 45 then '36-45'
  when age between 46 and 55 then '46-55'
  else '56+'
 end as age_group,
 sum(quantity) as total_product
from customer
group by age_group
order by total_product desc
limit 1;

-- TASK 7: Which age category generated the most revenue?
select
 case
 when age between 18 and 25 then '18-25'
 when age between 26 and 35 then '26-35'
 when age between 36 and 45 then '35-45'
 when age between 46 and 55 then '46-55'
 else '56+'
end as age_group,
sum(quantity * price) as total_revenue
from customer
group by age_group
order by total_revenue desc
limit 1;

-- TASK 8: Distribution of purchase categories relative to other columns (repeat)
select category,gender,SUM(quantity) AS total_quantity
from customer
group by category, gender
order by category, gender;

-- TASK 9: Does the payment method have a relation with other columns?
select payment_method,gender,count(*) as total
from customer
group by payment_method,gender;

-- TASK 10: How is the distribution of the payment method?
select payment_method,count(*) as total_transaction
from customer 
group by payment_method;



