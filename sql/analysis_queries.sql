-- =========================================================
-- NYC Yellow Taxi Revenue Analysis
-- SQL Queries
-- =========================================================


-- 1. Preview trips
SELECT *
FROM trips
LIMIT 5;


-- 2. High-value trips
SELECT
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount
FROM trips
WHERE total_amount > 100
ORDER BY total_amount DESC
LIMIT 10;


-- 3. Payment method summary
SELECT
    payment_method,
    COUNT(*) AS trips,
    ROUND(AVG(total_amount), 2) AS avg_trip_amount,
    ROUND(SUM(total_amount), 2) AS total_payments
FROM trips
GROUP BY payment_method
ORDER BY trips DESC;


-- 4. Evening trip analysis
SELECT
    pickup_hour,
    COUNT(*) AS trips,
    ROUND(AVG(total_amount), 2) AS avg_trip_amount
FROM trips
WHERE pickup_hour BETWEEN 16 AND 20
GROUP BY pickup_hour
ORDER BY pickup_hour;


-- 5. Top pickup zones by trip volume
SELECT
    z.Borough,
    z.Zone,
    COUNT(*) AS trips,
    ROUND(SUM(t.total_amount), 2) AS total_payments
FROM trips AS t
JOIN zones AS z
    ON t.PULocationID = z.LocationID
GROUP BY
    z.Borough,
    z.Zone
ORDER BY trips DESC
LIMIT 10;


-- 6. Top pickup zones by total payments
SELECT
    z.Borough,
    z.Zone,
    COUNT(*) AS trips,
    ROUND(AVG(t.total_amount), 2) AS avg_trip_amount,
    ROUND(SUM(t.total_amount), 2) AS total_payments
FROM trips AS t
JOIN zones AS z
    ON t.PULocationID = z.LocationID
GROUP BY
    z.Borough,
    z.Zone
ORDER BY total_payments DESC
LIMIT 10;