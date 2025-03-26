
-- Display Shopper’s information along with number of orders he/she placed during last 30 days.
SELECT 
    u.*, COUNT(o.order_id) AS no_of_order
FROM
    user u
        JOIN
    orders o ON u.user_id = o.user_id
WHERE o.order_date>(current_date - INTERVAL 30 DAY)
GROUP BY u.user_id;

-- Display the top 10 Shoppers who generated maximum number of revenue in last 30 days.
SELECT 
    u.user_name,
    u.email,
    SUM(o.total_amount) AS revenue_generated
FROM
    user u
        JOIN
    orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY SUM(o.total_amount) DESC
LIMIT 10;

-- Display top 20 Products which are ordered most in last 60 days along with numbers.
SELECT 
    p.product_id,
    p.product_name,
    COUNT(oi.order_item_id) AS amount_sold
FROM
    product p
        JOIN
    order_item oi ON p.Product_id = oi.product_id
GROUP BY p.Product_id
ORDER BY COUNT(oi.order_item_id) DESC
LIMIT 20;

-- Display Monthly sales revenue of the StoreFront for last 6 months. It should display each month’s sale.
SELECT 
    SUM(o.total_amount) AS sales_revenue
FROM
    orders o
WHERE
    o.order_date >= (CURRENT_DATE - INTERVAL 6 MONTH);
    
-- Mark the products as Inactive which are not ordered in last 90 days.
UPDATE product 
SET 
    status = 'inactive'
WHERE
    product_id NOT IN (SELECT DISTINCT
            product_id
        FROM
            order_item oi
                JOIN
            orders o ON o.order_id = oi.order_id
        WHERE
            o.order_date >= (CURRENT_DATE() - INTERVAL 90 DAY));


-- Given a category search keyword, display all the Products present in this category/categories. 
SELECT 
    c.category_name, p.product_name
FROM
    category c
        JOIN
    prod_cat pc ON c.category_id = pc.category_id
        JOIN
    product p ON pc.product_id = p.product_id
WHERE
    c.category_name LIKE 'A%';
    
    
-- Display top 10 Items which were cancelled most.
SELECT 
    p.product_id, p.product_name
FROM
    product p
        JOIN
    order_item oi ON p.product_id = oi.product_id
WHERE
    oi.status = 'cancelled';
