SELECT 
    CASE
		WHEN trip_distance <= 1 THEN 'Range 1'
        WHEN trip_distance >1 AND trip_distance <=3 THEN 'Range 3'
        WHEN trip_distance >3 AND trip_distance <=7 THEN 'Range 7'
		WHEN trip_distance >7 AND trip_distance <=10 THEN 'Range 10'
        ELSE 'Bigger distance'
    END AS ranges,
    COUNT(*) AS trip_count
FROM green_taxi
WHERE CAST(lpep_pickup_datetime AS DATE) >= '2019-10-1' 
AND CAST(lpep_dropoff_datetime AS DATE) < '2019-11-1' 
GROUP BY ranges;


SELECT lpep_pickup_datetime,trip_distance
FROM green_taxi
ORDER BY trip_distance DESC
LIMIT 1;

SELECT z."Zone", SUM(gt.total_amount) AS total_sum
FROM green_taxi gt
INNER JOIN taxi_zones z
ON gt.PULocationID = z.LocationID
WHERE CAST(gt.lpep_pickup_datetime AS DATE) = '2019-10-18'
AND z."Borough" != 'Unknown'
GROUP BY z."Zone"
HAVING SUM(gt.total_amount) > 13000
ORDER BY total_sum DESC
LIMIT 3;


SELECT z2."Zone", max(tip_amount) as Max_tip
FROM green_taxi gt
INNER JOIN taxi_zones z2
ON gt.DOLocationID = z2.LocationID
INNER JOIN taxi_zones z1
ON gt.PULocationID = z1.LocationID
WHERE z1.Zone = 'East Harlem North'
GROUP BY z2."Zone"
ORDER BY Max_tip DESC
LIMIT 1;