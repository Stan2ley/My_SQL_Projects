	create table Stan_Technologies(
	Employee_id int,
	First_name varchar(50),
    last_name varchar(50),
	occupation varchar(50),
	Salary int,
	dept_id int
	)

	select * from Stan_Technologies
insert into Stan_Technologies values
('1001','James','Okafor','Engineer','100000','01'),
('1002','John','Smith','Data Analyst','95000','02'),
('1003','Michael','Johnson','Software Developer','120000','03'),
('1004','David','Brown','Project Manager','110000','04'),
('1005','Chris','Davis','UX Designer','90000','05'),
('1006','Sarah','Miller','Data Scientist','115000','06'),
('1007','Emily','Wilson','Product Manager','105000','07'),
('1008','Daniel','Moore','DevOps Engineer','125000','08'),
('1009','Jessica','Taylor','QA Engineer','85000','09'),
('1010','Matthew','Anderson','Business Analyst','95000','10'),
('1011','Olivia','Thomas','Database Administrator','100000','11'),
('1012','Sophia','Jackson','Network Engineer','95000','12'),
('1013','Ava','White','Cybersecurity Analyst','120000','13'),
('1014','Isabella','Harris','Cloud Architect','110000','14'),
('1015','Mia','Martin','AI Engineer','90000','15'),
('1016','Charlotte','Thompson','Mobile App Developer','115000','16'),
('1017','Amelia','Garcia','Front-end Developer','105000','17'),
('1018','Harper','Martinez','Back-end Developer','125000','18'),
('1019','Evelyn','Robinson','Full Stack Developer','85000','19'),
('1020', 'Abigail', 'Clark', 'Data Engineer', '95000', '20'),
('1020', 'Abigail', 'Clark', 'Data Engineer', '95000', '20')
select * from Stan_Technologies

--#Let's try selecting a specific column
SELECT First_name
FROM  Stan_Technologies
--#As you can see from the output, we only have the one column here now and don't see the others


--#Now let's add some more columns, we just need to separate the columns with columns

SELECT First_name ,occupation
FROM  Stan_Technologies

select distinct occupation
from Stan_Technologies

select *
from Stan_Technologies

 
 --You'll  also often see SQL queries formatted like this.

SELECT last_name, 
first_name, 
gender, 
age
FROM Stan_Techn

--#The query still runs the exact same, but it is easier to read and pick out the columns
--#being selected and what you're doing with them.

--#For example let's take a look at using a calculation in the select statement

#You
can see here we have the total_money_spent - we can perform calculations on this

SELECT first_name,
 last_name,
 occupation,
 Salary + 10000
FROM Stan_Technologies

SELECT first_name,
 last_name,
 SALARY + 10000 AS NEW_SALATY
FROM Stan_Technologies
----#See how it's pretty easy to read and to see which columns we are using.

--#Now what will the output be when we do this?
SELECT first_name, 
last_name,
salary,
(salary + 100) * 10
FROM Stan_Technologies


--# Pemdas

--#One thing I wanted to show you about the select statement in this lesson is the DISTINCT Statement - this will return only unique values in
--#The output - and you won't have any duplicates

SELECT dept_id
FROM Stan_Technologies

SELECT DISTINCT dept_id 
FROM Stan_Technologies

--#Now a lot happens in the select statement. We have an entire module dedicated to just the 
--#select statement so this is kind of just an introduction to the select statement.select *


--# So basically if we say "Where name is = 'Alex' - only rows were the name = 'Alex' will return
--# So this is only effecting the rows, not the columns
--#Let's take a look at how this looks

SELECT *
FROM Stan_Technologies
WHERE salary > 100000

SELECT *
FROM Stan_Technologies
WHERE salary >= 50000

SELECT *
FROM Stan_Techn
WHERE gender = 'Female'

SELECT *
FROM Stan_Techn
WHERE age = 30




--select *
--from Stan_Techn
--where gender !='female'

select *
from Stan_Technologies
where salary >'120000'


select *
from Stan_Technologies
where Last_name like 'Jo%'

select *
from Stan_Technologies
where First_name like '90000%'


select *
from Stan_Technologies
where Salary like '90000%'

select First_name , Last_name, Salary , Avg(Salary)
from Stan_Technologies



SELECT Occupation, COUNT(*) AS Number_of_Employees
FROM Stan_Technologies
GROUP BY Occupation;

SELECT SUM(Salary) AS Total_Salary
FROM tech_stan;

SELECT AVG(Salary) AS Average_Salary
FROM Stan_Technologies;

SELECT Occupation, AVG(Salary)  ASAL
FROM Stan_Technologies
GROUP BY Occupation;

SELECT  First_name, min(Salary) AS Total_Salary
FROM Stan_Technologies
GROUP BY First_name;

select top  min(Salary) AS Total_Salary
FROM Stan_Technologies
--GROUP BY is used to organize rows with the same value into groups, usually so that you can apply aggregate functions 
--such as COUNT(), SUM(), AVG(), MIN(), and MAX().
