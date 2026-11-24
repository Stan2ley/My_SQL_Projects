SELECT * 
FROM dirty_shipments

select *
into #ship_buss
FROM dirty_shipments

select *
from ship_buss

select * from ship_buss

--Check Missing Values

-- now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways

SELECT *
FROM ship_buss
WHERE ship_date IS NULL
   OR delivery_date IS NULL
   OR freight_cost IS NULL
   OR damage_reported IS NULL

   
   --Check Duplicate Records
SELECT *,
COUNT(*) AS duplicate_count
FROM ship_buss
GROUP BY shipment_id,
         origin_warehouse,
         destination_city,
         destination_state,
         carrier,
         ship_date,
         delivery_date,
         weight_kg,
         freight_cost,
         shipment_status,
         items_count,
         damage_reported
HAVING COUNT(*) > 1;


SELECT 
UPPER(LEFT(origin_warehouse,1))+ lower (SUBSTRING(origin_warehouse,2,LEN(origin_warehouse))) AS origin_shipment,
shipment_status,

UPPER(LEFT(shipment_status,1))+ LOWER(SUBSTRING(shipment_status,2,LEN(shipment_status))) AS shipment_status,

upper(destination_state) as destination_state,

UPPER(LEFT(carrier,1))+ LOWER(SUBSTRING(carrier,2,LEN(carrier))) AS carriere
select *
FROM ship_busss

--Check Negative Weights
SELECT *
FROM #ship_buss
WHERE weight_kg <= 0

--to remove negative weights
select 
shipment_id,
case
when weight_kg < 0 then abs(weight_kg)
when weight_kg = 0 then null
else weight_kg
end as weight_kg_cleaned
from ship_buss

update #ship_buss
set weight_kg = 
case
when weight_kg < 0 then abs(weight_kg)
--when weight_kg = 0 then null
else weight_kg
END
from #ship_buss

SELECT DISTINCT shipment_id , weight_kg, items_count
FROM #ship_buss

--standadize weight categories
select 
shipment_id,
weight_kg,
case
when weight_kg < 50 then 'Light'
when weight_kg >= 50 and weight_kg < 150 then 'Medium'
when weight_kg >= 150 then 'Heavy'
else 'Unknown'
end as weight_category
from ship_buss

--adding weight category to the table
alter table #ship_buss
add weight_category varchar(20)

update #ship_buss
set weight_category = 
case
	when weight_kg < 100 then 'Light'
	when weight_kg >= 100 and weight_kg < 500 then 'Medium'
	when weight_kg >= 500 then 'Heavy'
	else 'Unknown'
end

SELECT *
from #ship_buss


--Check Invalid Dates
SELECT *
FROM ship_buss
WHERE delivery_date < ship_date

--Check Distinct States

SELECT DISTINCT destination_state
FROM ship_buss

 --Distinct Shipment Statuses

SELECT DISTINCT shipment_status
FROM ship_buss;


--Then Start Cleaning


--Standardize State Names
--UPDATE ship_buss
----SET destination_state = UPPER(destination_state);

SELECT *
from #ship_buss

--Fix Negative Weights
UPDATE #ship_buss
SET weight_kg = ABS(weight_kg)
WHERE weight_kg < 0;

--UPDATE ship_buss
--SET weight_kg = 10
--WHERE weight_kg  = 0;

select distinct weight_kg

SELECT *
from ship_buss



--Replace NULL in Damage Reported
UPDATE #ship_buss
SET damage_reported = 0
WHERE damage_reported IS NULL;



select *
from #ship_buss

--Replace NULL Freight Cost with Average
UPDATE ship_buss
SET freight_cost =(SELECT avg(freight_cost)
FROM ship_buss
)
WHERE freight_cost IS NULL;

 SELECT *
FROM ship_buss
WHERE freight_cost = 15000

 UPDATE #ship_buss
SET freight_cost = (
    SELECT AVG(freight_cost)
    FROM #ship_buss
    WHERE freight_cost <> 15000)


WHERE freight_cost = 15000;
SELECT AVG(freight_cost) AS average_freight_cost
FROM ship_buss
WHERE freight_cost <> 15000;


--Standardize Shipment Status
UPDATE #ship_buss
SET shipment_status =
CASE
    WHEN LOWER(shipment_status) = 'delivered' THEN 'Delivered'
    WHEN LOWER(shipment_status) = 'in transit' THEN 'In Transit'
    WHEN LOWER(shipment_status) = 'pending' THEN 'Pending'
    WHEN LOWER(shipment_status) = 'cancelled' THEN 'Cancelled'
END;

select *
from #ship_buss


UPDATE ship_buss
SET damage_reported = 0
WHERE damage_reported IS NULL;

select *
from ship_buss

SELECT
COUNT(*) AS Total_Records,
SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS Missing_Ship_Date,
SUM(CASE WHEN freight_cost IS NULL THEN 1 ELSE 0 END) AS Missing_Freight_Cost,
SUM(CASE WHEN delivery_date IS NULL THEN 1 ELSE 0 END) AS Missing_Delivery_Date,
SUM(CASE WHEN damage_reported IS NULL THEN 1 ELSE 0 END) AS Missing_Damage_Reported,
SUM(CASE WHEN destination_city IS NULL THEN 1 ELSE 0 END) AS Missing_destination_city,
SUM(CASE WHEN weight_kg < 0 THEN 1 ELSE 0 END) AS Negative_Weights
FROM ship_buss;

select *
from ship_buss

UPDATE #ship_buss
SET destination_city = 'Unknown'
WHERE destination_city IS NULL;

UPDATE ship_buss
SET items_count = ABS(items_count)
WHERE items_count < 0;



UPDATE #ship_buss
SET  origin_warehouse =
CASE
    WHEN UPPER(origin_warehouse) LIKE '%A%' THEN 'Warehouse A'
    WHEN UPPER(origin_warehouse) LIKE '%B%' THEN 'Warehouse B'
    WHEN UPPER(origin_warehouse) LIKE '%C%' THEN 'Warehouse C'
    WHEN UPPER(origin_warehouse) LIKE '%D%' THEN 'Warehouse D'
    ELSE origin_warehouse
END
from #ship_buss

UPDATE #ship_buss
SET  origin_warehouse =
CASE
    WHEN LOWER(origin_warehouse) = 'Warehouse a' THEN 'Warehouse A'
    WHEN LOWER(origin_warehouse) = 'Warehouse b' THEN 'Warehouse B'
    WHEN LOWER(origin_warehouse) = 'Warehouse c' THEN 'Warehouse C'
    WHEN LOWER(origin_warehouse) = 'Warehouse d' THEN 'Warehouse D'
    ELSE origin_warehouse
END
from #ship_buss

SELECT * FROM #ship_buss
WHERE destination_state LIKE '%Da%'










--1. Dataset Overview
--Total Shipments

--Question: How many shipments do we have?

SELECT COUNT(*) total_shipment
FROM ship_buss

--Explanation
--This tells us the size of the dataset.

--2. Warehouse Analysis
--Number of Shipments from Each Warehouse
SELECT origin_warehouse,
       COUNT(*) AS shipment_count
FROM ship_buss
GROUP BY origin_warehouse
ORDER BY shipment_count 
--Explanation
--Shows which warehouse handles the most shipments.
--Business Insight:

--Identify busiest warehouses.
--Allocate resources efficiently.


SELECT weight_category,
       COUNT(*) AS shipment_count
FROM ship_buss
GROUP BY weight_category
ORDER BY shipment_count 

select *
from ship_buss


--3. Carrier Performance
--Shipments by Carrier
SELECT carrier,
       COUNT(*) AS total_shipments
FROM ship_buss
GROUP BY carrier
ORDER BY total_shipments DESC;
--Explanation
--Shows which carrier is used most often.

--4. Freight Cost Analysis
--Average Freight Cost
SELECT
AVG(freight_cost) AS avg_cost,
MIN(freight_cost) AS min_cost,
MAX(freight_cost) AS max_cost
FROM ship_buss;

select shipment_id , freight_cost 
from ship_buss
--Explanation
--Measures shipping expenses.
--Business Insight:


--Understand cost range.
--Identify unusually expensive shipments.


--5. Weight Analysis
--Average Shipment Weight
SELECT
AVG(weight_kg) AS average_weight,
MIN(weight_kg) AS minimum_weight,
MAX(weight_kg) AS maximum_weight
FROM ship_buss;

select shipment_id , weight_kg, weight_category
from ship_buss

--Explanation

--Shows shipment size distribution.

--6. Weight Category Analysis
--Categorize Shipments
SELECT
CASE
    WHEN weight_kg < 100 THEN 'Light'
    WHEN weight_kg BETWEEN 100 AND 499 THEN 'Medium'
    ELSE 'Heavy'
END AS weight_category,
COUNT(*) AS shipment_count
FROM ship_buss
GROUP BY
CASE
    WHEN weight_kg < 100 THEN 'Light'
    WHEN weight_kg BETWEEN 100 AND 499 THEN 'Medium'
    ELSE 'Heavy'
END;
Explanation

Groups shipments into categories.

Business Insight:

--Determine the dominant shipment type.

7. Destination Analysis
Most Common Destination Cities
SELECT destination_city,
       COUNT(*) AS shipment_count
FROM ship_buss
GROUP BY destination_city
ORDER BY shipment_count DESC;

select *
from ship_buss
--Explanation
--Shows where shipments are frequently sent.

8. Destination State Analysis
    SELECT destination_state,
           COUNT(*) AS shipment_count
    FROM ship_buss
    GROUP BY destination_state
    ORDER BY shipment_count DESC;
--Explanation

--Shows states receiving the highest volume of shipments.

9. Shipment Status Analysis
SELECT shipment_status,
       COUNT(*) AS total_shipments
FROM ship_buss
GROUP BY shipment_status;

--Explanation
--Measures operational performance.

--Business Insight:
--Percentage delivered.
--Pending shipments.
--Cancelled shipments.

10. Damage Analysis
Damaged Shipments
SELECT damage_reported,
       COUNT(*) AS total
FROM ship_buss
group BY damage_reported
order  BY carrier
select damage_reported
from ship_buss

--Explanation
--Shows shipment quality performance.

11. Damage Rate by Carrier
SELECT carrier,
       SUM(CASE WHEN damage_reported = 1 THEN 1 ELSE 0 END) AS damaged_shipments,
       COUNT(*) AS total_shipments
FROM ship_buss
GROUP BY carrier;

--Explanation
--Identifies carriers associated with more damaged shipments.

12. Items Analysis
Average Items Per Shipment

SELECT
AVG(items_count) AS average_items,
MIN(items_count) AS minimum_items,
MAX(items_count) AS maximum_items
FROM ship_buss;

select items_count 
from ship_buss
--Explanation
--Shows shipment volume.


select * from ship_buss
UPDATE ship_buss
SET items_count = ABS(items_count)
WHERE items_count < 0;

13. Delivery Duration Analysis

Calculate Delivery Time
SELECT shipment_id,
       DATEDIFF(day, ship_date, delivery_date) AS delivery_days
FROM ship_buss;

--Explanation
--Measures delivery speed.

14. Average Delivery Time

--Explanation
--Shows overall logistics efficiency.

15. Carrier Delivery Performance
SELECT carrier,
       AVG(DATEDIFF(day, ship_date, delivery_date)) AS avg_delivery_days
FROM ship_buss
GROUP BY carrier
ORDER BY avg_delivery_days;

--Explanation
--Determines the fastest carrier.

16. Revenue Contribution by Carrier
SELECT carrier,
       SUM(freight_cost) AS total_revenue
FROM ship_buss
GROUP BY carrier
ORDER BY total_revenue DESC;

--Explanation
--Shows which carrier generates the most shipping revenue.


select *
from ship_buss


--Key Business Insights

--Warehouse A and B are the busiest warehouses.

--FastFreight is the most frequently used carrier.
--Dallas is the most common shipment destination.

--Medium-weight shipments dominate operations.

--72% of shipments were successfully delivered.


--FastFreight provides the fastest deliveries.

--QuickShip experiences the highest damage rate.sele

--Texas receives the largest shipment volume.

--SpeedyHaul generates the most revenue.

--The dataset contains data-quality issues such as negati
ve weights, missing values, inconsistent casing, 
and an extreme freight-cost outlier that should be cleaned before final reporting.

select *
from ship_buss
dirty_shipments