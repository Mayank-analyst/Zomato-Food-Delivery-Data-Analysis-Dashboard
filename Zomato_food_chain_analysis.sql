DROP TABLE orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    restaurant_name TEXT,
    city TEXT,
    delivery_time INT,
    distance FLOAT,
    cost FLOAT,
    rating FLOAT,
    order_date TEXT,   -- 👈 FIXED
    order_month TEXT,
    order_day TEXT
);

COPY orders
FROM 'C:/temp/data.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM orders LIMIT 10;

SELECT order_date FROM orders LIMIT 5;

ALTER TABLE orders
ALTER COLUMN order_date TYPE DATE
USING TO_DATE(order_date, 'DD/MM/YYYY');

#1. Find total number of orders.

SELECT 
     COUNT(Order_id) AS Total_orders
FROM orders;	

#2. Find average delivery time of all orders.

SELECT
     ROUND(AVG(delivery_time),2) AS average_order_delivery_time
FROM orders;	 

#3. Find total number of orders in each city.

SELECT
     city,
     COUNT(order_id) AS total_orders
FROM orders
GROUP BY city
ORDER BY total_orders DESC;

#4. Find average delivery time for each city.

SELECT
     city,
	 ROUND(AVG(delivery_time),2) AS average_delivery_time
FROM orders
GROUP BY city
ORDER BY average_delivery_time DESC; 	 

#5. Find average rating for each city.

SELECT 
     city,
     ROUND(AVG(rating)::numeric, 2) AS average_ratings
FROM orders
GROUP BY city
ORDER BY average_ratings DESC;

#6. Find city-wise average delivery time AND average rating together.

SELECT 
     city,
	 ROUND(AVG(delivery_time),2) AS average_delivery_time,
	 ROUND(AVG(rating)::numeric, 2) AS average_ratings
FROM orders
GROUP BY city
ORDER BY average_ratings DESC;

#7. Find TOP 3 cities with highest delivery time.

SELECT 
     city,
	 ROUND(AVG(delivery_time),2) AS average_delivery_time
FROM orders
GROUP BY city
ORDER BY average_delivery_time DESC
LIMIT 3;

#8. Find TOP 3 cities with HIGHEST average rating.

SELECT
     city,
	 ROUND(AVG(rating)::numeric, 2) AS average_ratings
FROM orders
GROUP BY city
ORDER BY average_ratings DESC
LIMIT 3;

#9. Find cities where:

--Delivery time is HIGH
--AND rating is LOW

SELECT 
     city,
	 ROUND(AVG(delivery_time),2) AS average_delivery_time,
	 ROUND(AVG(rating)::numeric, 2) AS average_ratings
FROM orders
GROUP BY city
HAVING 
      ROUND(AVG(delivery_time),2) > 30 AND
	  ROUND(AVG(rating)::numeric, 2) < 3.0
ORDER BY average_delivery_time DESC;	

#10. Find cities where:

--Delivery time is LOW
--AND rating is HIGH

SELECT 
     city,
	 ROUND(AVG(delivery_time),2) AS average_delivery_time,
	 ROUND(AVG(rating)::numeric, 2) AS average_ratings
FROM orders
GROUP BY city
HAVING 
      ROUND(AVG(delivery_time),2) < 50 AND
	  ROUND(AVG(rating)::numeric, 2) >= 3.0
ORDER BY average_delivery_time DESC;

#11. Find top 5 restaurants with highest average rating.

SELECT 
     restaurant_name,
	 ROUND(CAST(AVG(rating) AS numeric), 2) AS Highest_average_rating
FROM orders
GROUP BY restaurant_name
ORDER BY Highest_average_rating DESC
LIMIT 5;

#12. Rank restaurants based on average rating (highest = rank 1).

SELECT
     restaurant_name,
     avg_rating,
     RANK() OVER (ORDER BY avg_rating DESC) AS rank
FROM (
     SELECT
          restaurant_name,
          ROUND(AVG(rating)::numeric, 2) AS avg_rating
     FROM orders
     GROUP BY restaurant_name
) sub;

#13. Create cost_bucket using CASE WHEN.

SELECT
     order_id,
     cost,
     CASE 
          WHEN cost < 300 THEN 'Low'
          WHEN cost < 700 THEN 'Medium'
          ELSE 'High'
     END AS cost_bucket
FROM orders;

#14. Restaurants with above average rating.

SELECT 
     restaurant_name,
	 ROUND(AVG(rating)::numeric,2) AS average_rating
FROM orders
GROUP BY restaurant_name
HAVING AVG(rating) > ( 
                    SELECT AVG(rating) FROM orders);
