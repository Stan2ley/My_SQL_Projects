SELECT * 
FROM dirty_shipments

select *
into ship_busss
FROM dirty_shipments

select *
from ship_busss


-- now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways



select *
from (
select shipment_id,
origin_warehouse, 
destination_city,
ship_date ,
cast (weight_kg as varchar), 
cast (freight_cost as varchar), 
shipment_status ,
items_count, 
damage_reported	,
row_number() 
over(partition by shipment_id, origin_warehouse, destination_city, ship_date
order by shipment_id) as row_num
FROM ship_busss ) duplicates
WHERE 
	row_num > 1	





--removing duplicates
select * 
from (
select shipment_id, origin_warehouse, destination_city,ship_date ,row_number() 
over(partition by shipment_id, origin_warehouse, destination_city, ship_date 
order by shipment_id) as row_num
FROM ship_buss) duplicates
WHERE 
	row_num > 1
update ship_busss

select * 
from (
select *, row_number() 
over(partition by shipment_id
order by shipment_id) as row_num
FROM ship_buss) duplicates
WHERE 
	row_num > 1




SELECT 
UPPER(LEFT(origin_warehouse,1))+ LOWER(SUBSTRING(origin_warehouse,2,LEN(origin_warehouse))) AS origin_resturante,
shipment_status,
UPPER(LEFT(shipment_status,1))+ LOWER(SUBSTRING(shipment_status,2,LEN(shipment_status))) AS shipment_status,

upper(destination_state) as destination_state,
UPPER(LEFT(destination_state,1))+ LOWER(SUBSTRING(destination_state,2,LEN(destination_state))) AS destination_state,
UPPER(LEFT(carrier,1))+ LOWER(SUBSTRING(carrier,2,LEN(carrier))) AS carriere

FROM dirty_shipments


update ship_buss

select distinct destination_city
from ship_buss


order by 1
select *
from ship_buss


UPDATE ship_buss
SET
origin_warehouse =
UPPER(LEFT(origin_warehouse,1)) + LOWER(SUBSTRING(origin_warehouse,2,LEN(origin_warehouse))),
destination_city =
UPPER(LEFT(destination_city,1)) + LOWER(SUBSTRING(destination_city,2,LEN(destination_city))),
carrier =
UPPER(LEFT(carrier,1)) + LOWER(SUBSTRING(carrier,2,LEN(carrier))),
shipment_status = 
UPPER(LEFT(shipment_status,1)) + LOWER(SUBSTRING(shipment_status,2,LEN(shipment_status)))
select *
from ship_buss


--to remove negative weights
select 
shipment_id,
case
	when weight_kg < 0 then abs(weight_kg)
	when weight_kg = 0 then null
else weight_kg
end as weight_kg_cleaned
from ship_buss




select 
shipment_id,
case
	when weight_kg < 100 then 'Light'
	when weight_kg >= 100 and weight_kg < 500 then 'Medium'
	when weight_kg >= 500 then 'Heavy'
	else 'Unknown'
end as weight_category

from ship_buss

alter table ship_buss
add weight_category varchar(20)

update ship_buss
set weight_category = 
case
	when weight_kg < 100 then 'Light'
	when weight_kg >= 100 and weight_kg < 500 then 'Medium'
	when weight_kg >= 500 then 'Heavy'
	else 'Unknown'
end


select
shipment_id,
ship_date,
delivery_date,

case
	when delivery_date < ship_date then 'Invalid'
	when delivery_date = ship_date then 'Same day'
	when delivery_date > ship_date then 'Valid'
	else 'Unknown'
end as delivery_status

from ship_buss

UPDATE ship_buss
SET damage_reported = '0'
WHERE damage_reported IS NULL;


SELECT *
FROM ship_busss
WHERE destination_city IS NULL
   OR ship_date IS NULL
   OR delivery_date IS NULL
   OR freight_cost IS NULL
   OR damage_reported IS NULL



--fill the missing values in freight_cost with the average freight cost
UPDATE ship_buss
SET freight_cost =
(SELECT AVG(freight_cost)
 FROM ship_buss
 WHERE freight_cost IS NOT NULL
 )

--WHERE freight_cost IS NULL;
 
 
 UPDATE dirty_shipments
SET damage_reported = 'No'


SELECT *
FROM ship_busss
WHERE items_count < 0

UPDATE ship_buss
SET items_count = ABS(items_count)
WHERE items_count < 0




--standardize the damage_reported column to have consistent values (Yes/No)
 UPDATE ship_buss
SET damage_reported =
CASE
    WHEN UPPER(damage_reported) = 'YES' THEN 'Yes'
    WHEN UPPER(damage_reported) = 'NO' THEN 'No'
    ELSE damage_reported
END


 UPDATE dirty_shipments
SET damage_reported =
CASE
    WHEN UPPER(damage_reported) = 'YES' THEN 'Yes'
    WHEN UPPER(damage_reported) = 'NO' THEN 'No'
    ELSE damage_reported
END;