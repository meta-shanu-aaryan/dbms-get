-- Display the list of products (Id, Title, Count of Categories) which fall in more than one Category.
SELECT 
    p.product_id, p.product_name, COUNT(pc.product_id)
FROM
    product p
        JOIN
    prod_cat pc ON p.product_id = pc.product_id
GROUP BY p.product_id , p.Product_name
HAVING COUNT(pc.product_id) > 1;


-- Display Count of products as per below price range:
SELECT 
    CASE
        WHEN price BETWEEN 0 AND 1000 THEN '1-1000'
        WHEN price BETWEEN 1001 AND 15000 THEN '1001-15000'
        WHEN price BETWEEN 15001 AND 30000 THEN '15001-30000'
        ELSE 'Above 30000'
    END AS price_range,
    COUNT(*) AS product_count
FROM
    product
GROUP BY price_range
ORDER BY FIELD(price_range,
        '0-1000',
        '1001-15000',
        '15001-30000',
        'Above 3000');


-- Display the Categories along with number of products under each category.
SELECT 
    c.category_name, COUNT(pc.product_id)
FROM
    category c
        JOIN
    prod_cat pc ON c.category_id = pc.category_id
GROUP BY c.category_name;
