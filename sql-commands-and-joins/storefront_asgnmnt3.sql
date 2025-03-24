-- Display Recent 50 Orders placed (Id, Order Date, Order Total).
SELECT order_id, order_date, total_amount FROM orders ORDER BY order_date DESC LIMIT 50;

-- Display 10 most expensive Orders.
SELECT order_id, order_date, total_amount FROM orders ORDER BY total_amount DESC LIMIT 10;

-- Display all the Orders which are placed more than 10 days old and one or more items from those orders are still not shipped.
SELECT o.order_id, o.order_date, o.total_amount FROM orders o JOIN order_item oi ON o.order_id = oi.order_id WHERE o.order_date < (current_date - interval 10 day) AND oi.status="oredered";

-- Display list of shoppers which haven't ordered anything since last month.
SELECT user.user_id, user.user_name FROM user LEFT JOIN orders ON user.user_id = orders.user_id WHERE role = "customer" AND order_id IS NULL AND order_date < (CURRENT_DATE - interval 1 MONTH) ;

-- Display list of shopper along with orders placed by them in last 15 days.
SELECT user.user_id, user.user_name, orders.order_id, orders.order_date, orders.total_amount FROM user INNER JOIN orders ON user.user_id = orders.user_id WHERE order_date>(current_date - interval 15 day);

-- Display list of order items which are in “shipped” state for particular Order Id (i.e.: 1020))
SELECT oi.* FROM order_item oi WHERE status = "shipped" AND order_id = 2;

-- Display list of order items along with order placed date which fall between Rs 20 to Rs 50 price.
SELECT oi.*, o.order_date FROM order_item oi INNER JOIN orders o ON oi.order_id = o.order_id WHERE oi.price_at_purchase  BETWEEN 20 AND 50;