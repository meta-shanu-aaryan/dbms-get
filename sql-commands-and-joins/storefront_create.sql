-- Create all tables of eCommerce Application: StoreFront covered in Session 1 Assignments. 
-- (Write all CREATE commands in a SQL file and run that SQL File).--

CREATE DATABASE StoreFront;

USE StoreFront;

CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(40) NOT NULL,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id)
        REFERENCES category (category_id)
);

CREATE TABLE product (
    Product_id INT PRIMARY KEY AUTO_INCREMENT,
    Product_name VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Quantity INT NOT NULL,
    Category_id INT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Category_id)
        REFERENCES category (category_id)
);

-- Write a command to remove Product table of the StoreFront database
DROP TABLE product;


-- Create the Product table again.
CREATE TABLE product (
    Product_id INT PRIMARY KEY AUTO_INCREMENT,
    Product_name VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Quantity INT NOT NULL,
    Category_id INT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Category_id)
        REFERENCES category (category_id)
);

CREATE TABLE image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    image_url VARCHAR(200),
    product_id INT NOT NULL,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
);

CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(70) NOT NULL,
    role ENUM('admin', 'customer') NOT NULL
);

CREATE TABLE shipping_address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    address VARCHAR(100) NOT NULL,
    postal_code INT NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES user (user_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    total_amount INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
        REFERENCES user (user_id),
    FOREIGN KEY (address_id)
        REFERENCES shipping_address (address_id)
);

CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    price_at_purchase INT NOT NULL,
    quantity INT NOT NULL,
    status ENUM('ordered', 'accepted', 'shipped', 'delivered', 'cancelled', 'pending') DEFAULT 'pending',
    FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
);

-- Write a command to display all the table names present in StoreFront.
SHOW TABLES;


-- DROP DATABASE storefront;

