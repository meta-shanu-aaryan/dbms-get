-- Create a Stored procedure to retrieve average sales of each product in a month. Month and year will be input parameter to function.

SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS sold_quantity,
    AVG(oi.price_at_purchase) AS average_price,
    SUM(oi.price_at_purchase) AS total_earning
FROM
    product p
        JOIN
    order_item oi ON p.product_id = oi.product_id
        JOIN
    orders o ON o.order_id = oi.order_id
WHERE
    MONTH(o.order_date) = 03
        AND YEAR(o.order_date) = 2025
GROUP BY p.product_id;


DELIMITER $$
CREATE PROCEDURE average_sales (order_month INT, order_year INT)
BEGIN
SELECT p.product_id, p.product_name, SUM(oi.quantity) as sold_quantity, AVG(oi.price_at_purchase) AS average_price, SUM(oi.price_at_purchase) AS total_earning FROM product p JOIN order_item oi ON p.product_id = oi.product_id JOIN orders o ON o.order_id = oi.order_id WHERE MONTH(o.order_date) = order_month AND YEAR(o.order_date) = order_year GROUP BY p.product_id;
END$$
DELIMITER ;

CALL average_sales(03,2025);

-- Create a stored procedure to retrieve table having order detail with status for a given period. 
-- Start date and end date will be input parameter. Put validation on input dates like start date is less than end date. 
-- If start date is greater than end date take first date of month as start date.

DELIMITER $$
CREATE PROCEDURE product_status(begin_date DATE, end_date DATE)
BEGIN

IF begin_date>end_date THEN
SET begin_date = (end_date - INTERVAL DAY(end_date-1) DAY);
END IF;

SELECT 
    oi.order_item_id,
    p.product_id,
    o.order_id,
    p.product_name,
    oi.price_at_purchase,
    o.order_date,
    oi.status
FROM
    order_item oi
        JOIN
    orders o ON oi.order_id = o.order_id
        JOIN
    product p ON p.product_id = oi.product_id
WHERE
	o.order_date BETWEEN begin_date AND end_date;
END$$
DELIMITER ;

DROP PROCEDURE 	product_status;

CALL product_status("2025-05-01", "2025-04-02");