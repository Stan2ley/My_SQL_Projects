-- Joins

-- joins allow you to combine 2 tables together (or more) if they have a common column.
-- doesn't mean they need the same column name, but the data in it are the same and can be used to join the tables together
-- there are several joins we will look at today, inner joins, outer joins, and self joins


-- here are the first 2 tables - let's see what columns and data in the rows we have in common that we can join on
SELECT *
FROM Stan_Technologies

SELECT *
FROM Stan_Techn

select *
from dept_sections

select *
from oxford

select *
from dept_sections

 --let's start with an inner join -- inner joins return rows that are the same in both columns

 --since we have the same columns we need to specify which table they're coming from

SELECT *
FROM Stan_Technologies 
LEFT JOIN Stan_Techn
	ON Stan_Technologies.employee_id = Stan_Techn.employee_id

SELECT *
FROM Stan_Technologies stac
  join dept_sections depy
	ON stac.dept_id = depy.dept_id

	SELECT *
FROM Stan_Techn


	SELECT *
FROM Stan_Technologies stac
  left outer join dept_sections depy
	ON depy.dept_id =  stac.dept_id 
where depy.dept_name = 'Defense'AND stac.occupation = 'Data Analyst'



	SELECT *
FROM Stan_Technologies 
  left outer join dept_sections 
	ON Stan_Technologies.dept_id = dept_sections.dept_id

SELECT *
FROM dept_sections  
  FULL  join Stan_Technologies 
	ON dept_sections.dept_id = Stan_Technologies.dept_id


	
	-- use aliasing!
	SELECT *
FROM Stan_Technologies as otp
JOIN Stan_Techn as tacs
	ON otp.employee_id = tacs.employee_id



	SELECT *
FROM Stan_Technologies  stac
 JOIN Stan_Techn  tacs
	ON stac.employee_id = tacs.employee_id

----getting info from both tables
--tacs.employee_id ,age ,occupation ,Date_of_birth ,dept_name , username	
--select   age ,occupation ,Date_of_birth ,dept_name , username , tacs.employee_id
select *	
FROM Stan_Technologies as stac
inner JOIN Stan_Techn as tacs
ON stac.employee_id = tacs.employee_id
JOIN dept_sections as dept
ON  stac.dept_id = dept.dept_id
join Oxford as ox
on ox.dept_id = dept.dept_id



select age ,occupation ,Date_of_birth
from Stan_Techn as stac
JOIN Stan_Technologies as tacs
ON stac.employee_id = tacs.employee_id












select *	
FROM Stan_Technologies as stac
 JOIN Stan_Techn as tacs
ON stac.employee_id = tacs.employee_id
left outer JOIN dept_sections as dept
ON  stac.dept_id = dept.dept_id
left outer join Oxford as ox
on ox.dept_id = dept.dept_id




select stac.Employee_id age, gender, occupation, Date_of_birth, stac.First_name, dept_name,  tacs.last_name, username, email ,ox.dept_id
FROM Stan_Technologies as stac
inner JOIN Stan_Techn as tacs

ON stac.employee_id = tacs.employee_id

left JOIN dept_sections as dept

ON  stac.dept_id = dept.dept_id

left outer join Oxford as ox

on ox.dept_id = dept.dept_id

select *
from Oxford
select *
from
dept_sections



select *
FROM Stan_Technologies as stac
left outer JOIN Oxford as ox
on ox.dept_id = stac.dept_id

ON stac.employee_id = tacs.employee_id

select *
FROM Stan_Technologies as stac
left join oxford as ox
on stac.Employee_id =ox.id


select First_name , occupation, Salary,Username ,email

FROM Stan_Technologies as stac
left join oxford as ox
on stac.Employee_id =ox.id

select *
from dept_sections

select *
from Oxford

-- OUTER JOINS

-- for outer joins we have a left and a right join
-- a left join will take everything from the left table even if there is no match in the join, but will only return matches from the right table
-- the exact opposite is true for a right join

SELECT *
FROM Stan_techn tacs
LEFT JOIN Stan_Technologies stac
	ON stac.employee_id = tacs.employee_id

-- so you'll notice we have everything from the left table or the salary table. Even though there is no match to ron swanson. 
-- Since there is not match on the right table it's just all Nulls

-- if we just switch this to a right join it basically just looks like an inner join
-- that's because we are taking everything from the demographics table and only matches from the left or salary table. Since they have all the matches
-- it looks kind of like an inner join
SELECT *
FROM Stan_Technologies
RIGHT JOIN Stan_Techn
	ON Stan_Technologies.employee_id = Stan_Techn.employee_id



-- Self Join

-- a self join is where you tie a table to itself

SELECT *
FROM Stan_Technologies


-- what we could do is a secret santa so the person with the higher ID is the person's secret santa


SELECT *
FROM Stan_Technologies stac
JOIN Stan_Techn tacs
	ON stac.employee_id = tacs.employee_id

	SELECT *
FROM Stan_Technologies emp1
left JOIN Stan_Techn emp2
	ON emp1.employee_id + 3 = emp2.employee_id
    

--lets reduce the number of columns we are selecting to make it easier to read
SELECT emp1.employee_id as emp_Takeover, 
emp1.first_name as takeover_first_name, 
emp1.last_name as takeover_last_name,
emp2.employee_id,
emp2.first_name,
emp2.last_name
FROM Stan_Technologies emp1
JOIN Stan_Techn emp2
	ON emp1.employee_id + 3 = emp2.employee_id
    ;

-- So leslie is Ron's secret santa and so on -- Mark Brandanowitz didn't get a secret santa, but he doesn't deserve one because he broke Ann's heart so it's all good






-- Joining multiple tables

-- now we have on other table we can join - let's take a look at it
SELECT * 
FROM dept_sections 


SELECT *
FROM Stan_Technologies  stac
inner JOIN Stan_Techn  tacs
	ON stac.employee_id = tacs.employee_id
	inner JOIN dept_sections dept
	ON  stac.dept_id = dept.dept_id
	inner join Oxford ox
	on ox.dept_id = dept.dept_id

	----left outer join
SELECT *
FROM Stan_Technologies  stac
left outer join Oxford ox
	on ox.id = stac.Employee_id






SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;

-- now notice when we did that, since it's an inner join it got rid of andy because he wasn't a part of any department

-- if we do a left join we would still include him because we are taking everything from the left table which is the salary table in this instance
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;













	stac.employee_id

select stac.employee_id, age ,occupation ,Date_of_birth 
	
FROM Stan_Technologies as stac
inner JOIN Stan_Techn as tacs
ON stac.employee_id = tacs.employee_id