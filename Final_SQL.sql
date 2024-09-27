--create cumulative table
create temp table all_years as
select * from bluebikes_2016
UNION ALL 
select * from bluebikes_2017
UNION ALL
select * from bluebikes_2018
UNION ALL
select * from bluebikes_2019;


--check for duplicates
select count(concat(bike_id,start_time)) from bluebikes_2016; --1236203 rows
select count(distinct(concat(bike_id,start_time))) from bluebikes_2016; --1236203 rows

select count(concat(bike_id,start_time)) from bluebikes_2017; --1313774 rows
select count(distinct(concat(bike_id,start_time))) from bluebikes_2017; --1313774 rows

select count(concat(bike_id,start_time)) from bluebikes_2018; --1767806 rows
select count(distinct(concat(bike_id,start_time))) from bluebikes_2018; --1767806 rows

select count(concat(bike_id,start_time)) from bluebikes_2019; --2522537 rows
select count(distinct(concat(bike_id,start_time))) from bluebikes_2019; --2522537

select count(*) from (
select concat(bike_id,start_time) from bluebikes_2016
UNION ALL 
select concat(bike_id,start_time) from bluebikes_2017
UNION ALL
select concat(bike_id,start_time) from bluebikes_2018
UNION ALL
select concat(bike_id,start_time) from bluebikes_2019) as T1; --6840320 rows

select count(*) from (select distinct * from (
select concat(bike_id,start_time) from bluebikes_2016
UNION ALL 
select concat(bike_id,start_time) from bluebikes_2017
UNION ALL
select concat(bike_id,start_time) from bluebikes_2018
UNION ALL
select concat(bike_id,start_time) from bluebikes_2019) as T1) as T2; --6840320 rows
-- no duplicates defined by same bike ID and same start time

-- check for nulls
SELECT *
FROM (
select * from bluebikes_2016
UNION ALL 
select * from bluebikes_2017
UNION ALL
select * from bluebikes_2018
UNION ALL
select * from bluebikes_2019) as T1
Where 
	bike_id is null
	OR start_time is null
	OR end_time is null
	OR start_station_id is null
	OR end_station_id is null
	OR user_type is null
	OR user_gender is null; --0 rows

--user gender not available
SELECT *
FROM all_years
Where 
	user_gender = 0; --953292 rows

-- user birth year not available
SELECT *
FROM all_years
Where 
	user_birth_year is null; --447149 rows
	
--2016
select * 
from bluebikes_2016
where user_birth_year is null; --226610 rows

--2017
select * 
from bluebikes_2017
where user_birth_year is null; --210947 rows

--2018
select * 
from bluebikes_2018
where user_birth_year is null; --9592 rows

--2019
select * 
from bluebikes_2019
where user_birth_year is null; --0 rows
--birth year entry is now mandatory starting sometime in March of 2018 (03/2018)


--most popular starting/ending stations
	--top 10 most popular stations by year
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2016 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips DESC
LIMIT 10;

	--2017
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2017 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips DESC
LIMIT 10;

	--2018
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2018 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips DESC
LIMIT 10;

	--2019
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2019 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips DESC
LIMIT 10;

	--most popular for all years combined
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(T2.bike_id, T2.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(T2.bike_id, T2.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM (
	select * from all_years as T1) as T2
         
    JOIN 
        bluebikes_stations s ON T2.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips DESC
LIMIT 10;

	--Least popular for all years
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(T2.bike_id, T2.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(T2.bike_id, T2.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM (
	select * from all_years as T1) 
	as T2
         
    JOIN 
        bluebikes_stations s ON T2.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips
LIMIT 10;

	--Least popular 2019
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2019 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips
LIMIT 10;

	--2018
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2018 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips
LIMIT 10;

	--2017
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2017 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips
LIMIT 10;

 --2016
SELECT  
    name as station,
    number_of_trips_started + number_of_trips_ended AS total_station_trips,
	number_of_trips_started,
    number_of_trips_ended,
    latitude, 
    longitude, 
    total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
FROM (
    SELECT 
        s.id, 
        s.name,
        COUNT(CONCAT(y.bike_id, y.start_time)) AS number_of_trips_started,
        COUNT(CONCAT(y.bike_id, y.end_time)) AS number_of_trips_ended,
        s.latitude, 
        s.longitude, 
        s.total_docks
    FROM 
        bluebikes_2016 y 
    JOIN 
        bluebikes_stations s ON y.start_station_id = s.id
    GROUP BY 
        s.id, 
        s.name,
        s.latitude, 
        s.longitude, 
        s.total_docks
) AS subquery
ORDER BY 
    total_station_trips
LIMIT 10;

--10 least popular stations from each of the 4 years. then seperated by year to track growth/decline
select 
	station,
	(number_of_trips_started + number_of_trips_ended) as total_trips,
	number_of_trips_started,
	number_of_trips_ended,
	year,
	total_docks,
	(number_of_trips_started + number_of_trips_ended)/total_docks as trips_per_dock
from(select 
		s.name as station, 
		count(distinct concat(ay.bike_id, ay.start_station_id)) as number_of_trips_started, 
		count(distinct concat(ay.bike_id, ay.end_station_id)) as number_of_trips_ended,
		date_part('YEAR', ay.start_time) as year,
		s.total_docks
from all_years ay join bluebikes_stations s on ay.start_station_id = s.id
where s.name 
	 in (
'Morton St T',
'Belgrade Ave at Walworth St',
'Blue Hill Ave at Almont St',
'Mattapan Library',
'Thetford Ave at Norfolk St',
'Codman Square Library',
'Talbot Ave At Blue Hill Ave',
'Bennington St at Constitution Beach',
'Mattapan T Stop',
'Washington St at Talbot Ave',
'Four Corners - 157 Washington St',
'Columbia Rd at Ceylon St',
'Huron Ave At Vassal Lane',
'Chelsea St at Saratoga St',
'Bennington St at Byron St',
'Walnut Ave at Warren St',
'Franklin Park - Seaver St at Humbolt Ave',
'Grove Hall Library - 41 Geneva Ave',
'Uphams Corner T Stop - Magnolia St at Dudley St',
'Glendon St at Condor St',
'Boston East - 126 Border St',
'Chelsea St at Saratoga St',
'Glendon St at Condor St',
'The Eddy - New St at Sumner St',
'Bennington St at Byron St',
'Columbia Rd at Ceylon St',
'Orient Heights T Stop - Bennington St at Saratoga St',
'Walnut Ave at Warren St',
'Bowdoin St at Quincy St',
'Piers Park',
'Washington St at Walsh Playground',
'Spring St at Powell St',
'Washington St at Fuller St',
'Central Ave at River St',
'Mt. Hope St at Hyde Park Ave',
'American Legion Hwy at Canterbury St',
'Centre St at Parkway YMCA',
'Centre St at W. Roxbury Post Office',
'Northbourne Rd at Hyde Park Ave',
'Geiger Gibson Community Health Center')
group by 1,4,5) as T1
group by 1,2,3,4,5,6
order by 5,2,7;


--determine most popular routes by number of trips and calculate average length of trip by route AND calculate revenue for top routes

WITH trip_duration AS (
    SELECT 
        CONCAT(ay.bike_id, ay.start_time) AS trip_id, 
        ay.start_station_id, 
        start_station.name AS start_station_name, 
        ay.end_station_id, 
        end_station.name AS end_station_name,
        ay.start_time,
        ay.end_time,
        user_type,
        EXTRACT(EPOCH FROM (ay.end_time - ay.start_time)) / 60 AS duration_minutes
    FROM 
        all_years ay 
    JOIN 
        bluebikes_stations start_station ON ay.start_station_id = start_station.id
    JOIN 
        bluebikes_stations end_station ON ay.end_station_id = end_station.id
)

-- Calculate the total revenue earned for each trip based on the pricing scheme
SELECT
    CONCAT(start_station_name, ' **TO** ', end_station_name) AS route, 
    COUNT(trip_id) AS total_trips,
    ROUND(AVG(duration_minutes), 2) AS avg_trip_length,
    SUM(
        CASE 
            WHEN user_type = 'Customer' THEN
                CASE 
                    WHEN duration_minutes <= 30 THEN 2.95
                    ELSE 2.95 + CEIL((duration_minutes - 30) / 30) * 4.00
                END
            ELSE
                CASE 
                    WHEN duration_minutes <= 45 THEN 0
                    ELSE 0 + CEIL((duration_minutes - 45) / 45) * 4.00
                END
        END
    )::money AS total_revenue
FROM
    trip_duration
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

--Revenue generated from the most popular stations
/*
'MIT at Mass Ave / Amherst St'
'South Station - 700 Atlantic Ave'
'Central Square at Mass Ave / Essex St'
'MIT Stata Center at Vassar St / Main St'
'Kendall T'
'Harvard Square at Mass Ave/ Dunster'
'MIT Pacific St at Purrington St'
'Ames St at Main St'
'Nashua Street at Red Auerbach Way'
'MIT Vassar St'
------------------------------------
least popular
'The Eddy - New St at Sumner St',
'Bennington St at Byron St',
'Chelsea St at Saratoga St',
'Glendon St at Condor St',
'Four Corners - 157 Washington St'
*/

WITH trip_duration AS (
    SELECT 
        CONCAT(ay.bike_id, ay.start_time) AS trip_id, 
        ay.start_station_id, 
        start_station.name AS start_station_name, 
        ay.end_station_id, 
        end_station.name AS end_station_name,
        ay.start_time,
        ay.end_time,
        user_type,
        EXTRACT(EPOCH FROM (ay.end_time - ay.start_time)) / 60 AS duration_minutes
    FROM 
        all_years ay 
    JOIN 
        bluebikes_stations start_station ON ay.start_station_id = start_station.id
        AND start_station.name IN (
            'MIT at Mass Ave / Amherst St',
            'South Station - 700 Atlantic Ave',
            'Central Square at Mass Ave / Essex St',
            'MIT Stata Center at Vassar St / Main St',
            'Kendall T',
            'Harvard Square at Mass Ave/ Dunster',
            'MIT Pacific St at Purrington St',
            'Ames St at Main St',
            'Nashua Street at Red Auerbach Way',
            'MIT Vassar St',
            'The Eddy - New St at Sumner St',
            'Bennington St at Byron St',
            'Chelsea St at Saratoga St',
            'Glendon St at Condor St',
            'Four Corners - 157 Washington St'
        )
    JOIN 
        bluebikes_stations end_station ON ay.end_station_id = end_station.id
        AND end_station.name IN (
            'MIT at Mass Ave / Amherst St',
            'South Station - 700 Atlantic Ave',
            'Central Square at Mass Ave / Essex St',
            'MIT Stata Center at Vassar St / Main St',
            'Kendall T',
            'Harvard Square at Mass Ave/ Dunster',
            'MIT Pacific St at Purrington St',
            'Ames St at Main St',
            'Nashua Street at Red Auerbach Way',
            'MIT Vassar St',
            'The Eddy - New St at Sumner St',
            'Bennington St at Byron St',
            'Chelsea St at Saratoga St',
            'Glendon St at Condor St',
            'Four Corners - 157 Washington St'
        )
)

-- Calculate the total revenue earned for each trip based on the pricing scheme
SELECT
    start_station_name AS station_name, 
    COUNT(trip_id) AS total_trips,
    ROUND(AVG(duration_minutes), 2) AS avg_trip_length,
    SUM(
        CASE 
            WHEN user_type = 'Customer' THEN
                CASE 
                    WHEN duration_minutes <= 30 THEN 2.95
                    ELSE 2.95 + CEIL((duration_minutes - 30) / 30) * 4.00
                END
            ELSE
                CASE 
                    WHEN duration_minutes <= 45 THEN 0
                    ELSE 0 + CEIL((duration_minutes - 45) / 45) * 4.00
                END
        END
    )::money AS total_revenue
FROM
    trip_duration
GROUP BY 
    start_station_name
ORDER BY 
    total_revenue DESC
LIMIT 50;

