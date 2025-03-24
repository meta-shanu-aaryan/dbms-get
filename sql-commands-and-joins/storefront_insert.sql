-- Insert sample data in StoreFront tables by using SQL files.

INSERT INTO category(category_name) VALUES("Electronics"),("Grocery");

INSERT INTO category(category_name, parent_category_id) VALUES ("Snacks", 2),("Sweets", 2), ("Cooking Essentials", 2), ("Laptop", 1), ("Mobile", 1);

INSERT INTO product(Product_name, price, quantity, category_id) VALUES("IdeaPad Gaming3 Ryzen 5 4600H", 50000, 70, 1),("Redmi note 13 pro plus", 23999, 40,1),
("kurkure", 50, 139, 3), ("lays", 20, 190, 3), ("gulabjamun",149,20,4), ("wheat flour", 230, 34, 5);

INSERT INTO image(image_url, product_id) VALUES("LAP_URL",1),("NOTE13PROPLUS_URL",4),("note14proplus_url",2);

INSERT INTO user(user_name, email, role) VALUES("Shanu Aaryan", "shanuaaryan@gmail.com", "admin"), ("Swayam", "swayam@gmail.com", "customer"), ("Sam", "sam@gmail.com", "customer");

INSERT INTO shipping_address(user_id, address, postal_code) VALUES(1, "Lalji Chowk, Telo", 828403), (2, "Yamunanagar, Haryana", 362834), (3, "Udaipuria mod, chomu",303807);

INSERT INTO orders(user_id,address_id,total_amount) VALUES(2,2,45000),(3,3,20000);

INSERT INTO order_item(product_id, order_id, price_at_purchase, quantity) VALUES(3, 1, 45000, 1), (4, 2, 20000,1);


-- Display Id, Title, Category Title, Price of the products which are Active and recently added products should be at top.

SELECT 	product_id, product_name, category_name, price, updated_at FROM product INNER JOIN category ON product.category_id = category.category_id WHERE product.status='active' ORDER BY product.updated_at DESC;

-- Display the list of products which don't have any images.

SELECT product.product_id, product.product_name FROM product LEFT JOIN image ON image.product_id = product.product_id WHERE image.product_id IS NULL;

-- Display all Id, Title and Parent Category Title for all the Categories listed, 
-- sorted by Parent Category Title and then Category Title. (If Category is top category then Parent Category
-- Title column should display “Top Category” as value.)

SELECT c.category_id, c.category_name, COALESCE(p.category_name,'TOP_CATEGORY') AS category_name FROM category c LEFT JOIN category p ON c.parent_category_id = p.category_id ORDER BY p.category_name, c.category_name;

-- Display Id, Title, Parent Category Title of all the leaf Categories (categories which are not parent of any other category)

SELECT c.category_id, c.category_name, p.category_name FROM category c INNER JOIN category p ON c.parent_category_id = p.category_id;

-- Display Product Title, Price & Description which falls into particular category Title

SELECT product_name, price FROM product INNER JOIN category ON product.category_id = category.category_id WHERE category.category_name = "Snacks";

-- Display the list of Products whose Quantity on hand (Inventory) is under 50.

SELECT * FROM product WHERE quantity<50;

