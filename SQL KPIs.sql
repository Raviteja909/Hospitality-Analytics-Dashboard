use days;

SELECT *
FROM dim_date;

--------------------------------------------------------------------------------------------------------------------------

# 1. Total revenue generated

SELECT 
   round(SUM(revenue_generated),2) AS `Total revenue`
FROM fact_bookingscsv;

------------------------------------------------------------------------------------------------------------------------

# 2. count hotels by citys

SELECT city, COUNT(*) AS hotel_count
FROM dim_hotels
GROUP BY city;

--------------------------------------------------------------------------------------------------------------------------
# 3. Show hotel name with booking details

SELECT 
    f.booking_id,
    h.property_name,
    f.booking_status,
    f.revenue_realized
FROM fact_bookingscsv f
JOIN dim_hotels h
    ON f.property_id = h.property_id;

-----------------------------------------------------------------------------------------------------------------
# 4. Revenue by city
SELECT
    h.city,
    SUM(f.revenue_realized) AS total_revenue
FROM fact_bookingscsv f
JOIN dim_hotels h
    ON f.property_id = h.property_id
GROUP BY h.city;

--------------------------------------------------------------------------------------------------------------------
# 5. Occupancy percentage

SELECT
    property_id,
    SUM(successful_bookings) * 100.0 / SUM(capacity) AS occupancy_percentage
FROM fact_aggregated_bookings
GROUP BY property_id;


--------------------------------------------------------------------------------------------------------------------
# 6. Bookings by room class

SELECT
    r.room_class,
    COUNT(*) AS total_bookings
FROM fact_bookingscsv f
JOIN dim_rooms r
    ON f.room_category = r.room_id
GROUP BY r.room_class;

--------------------------------------------------------------------------------------------------------------------
# 7. Total capacity by hotel

SELECT
    h.property_name,
    SUM(a.capacity) AS total_capacity
FROM fact_aggregated_bookings a
JOIN dim_hotels h
    ON a.property_id = h.property_id
GROUP BY h.property_name;










