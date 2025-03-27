-- Create a function to calculate number of orders in a month. Month and year will be input parameter to function.
DELIMITER $$
CREATE FUNCTION orders_in_month(_month INT, _year INT)
	RETURNS INT
		DETERMINISTIC
	BEGIN
		DECLARE no_of_order INT;
        SET no_of_order = (
			SELECT COUNT(order_id) AS number_of_order FROM orders WHERE MONTH(order_date) = _month AND YEAR(order_date) 
        );
        RETURN no_of_order;
	END$$
DELIMITER ;

SELECT orders_in_month(03,2025);

-- Create a function to return month in a year having maximum orders. Year will be input parameter.

SELECT MONTH(order_date) FROM orders WHERE  YEAR(order_date) = 2025 GROUP BY MONTH(order_date) ORDER BY COUNT(order_id) DESC LIMIT 1;

DELIMITER $$
CREATE FUNCTION max_order_month(_year INT)
	RETURNS INT
		DETERMINISTIC
	BEGIN
		DECLARE max_ordered_month INT;
        SET max_ordered_month = (
			SELECT MONTH(order_date) FROM orders WHERE  YEAR(order_date) = _year GROUP BY MONTH(order_date) ORDER BY COUNT(order_id) DESC LIMIT 1
        );
        RETURN max_ordered_month;
	END$$
DELIMITER ;


SELECT max_order_month(2025) AS "maximum ordered month";

