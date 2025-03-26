-- Create a view displaying the order information (Id, Title, Price, Shopper’s name, Email, Orderdate, Status)
-- with latest ordered items should be displayed first for last 60 days.
-- Use the above view to display the Products(Items) which are in ‘shipped’ state.
-- Use the above view to display the top 5 most selling products.

CREATE VIEW order_information AS
    SELECT 
        oi.order_item_id,
        p.product_name,
        oi.price_at_purchase,
        u.user_name,
        U.email,
        o.order_date,
        oi.status
    FROM
        order_item oi
            JOIN
        product p ON oi.product_id = p.Product_id
            JOIN
        orders o ON o.order_id = oi.order_id
            JOIN
        user u ON u.user_id = o.user_id
    WHERE
        o.order_date >= (CURRENT_DATE() - INTERVAL 60 DAY)
    ORDER BY o.order_date DESC;


-- Use the above view to display the Products(Items) which are in ‘shipped’ state.
SELECT 
    *
FROM
    order_information
WHERE
    status = 'shipped';

-- Use the above view to display the top 5 most selling products.
SELECT product_name, COUNT(order_item_id) FROM order_information GROUP BY product_name ORDER BY COUNT(order_item_id) DESC LIMIT 5;