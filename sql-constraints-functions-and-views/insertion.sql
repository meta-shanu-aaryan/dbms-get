-- inserting data in database

INSERT INTO category (category_name) 
	VALUES("Electronics"),
		  ("Appliances"),
          ("Furniture");
          
INSERT INTO category (category_name, parent_category_id)
	VALUES("Laptop", 1),
		  ("Camera", 1),
          ("Accessories",1),
          ("Printers",1),
          ("Televisions",2),
          ("Air Coolers",2),
          ("Fridgers",2),
          ("Chairs",3),
          ("Tables",3),
          ("Cupboards",3),
          ("Dining Sets",3);

INSERT INTO product(product_name, price, quantity) 
	VALUES ("Ideapad Gaming 3", 56999, 30),
		   ("HP Pavilion", 54999, 70),
           ("Nikon NK400", 43999, 12),
           ("Canon D400", 43999, 22),
           ("Redgear Gaming Mouse", 599, 73),
           ("HP Inkjet Printer", 14999, 50),
           ("Voltas Stand Desert Cooler", 13999, 26),
           ("HyperX Gaming Chair", 23899, 12),
           ("WoodMark brownwood adjustable table", 59000, 27),
           ("Illuminous Table Lamp", 1299, 120);
           

INSERT INTO prod_cat(product_id, category_id)
	VALUES (1,4),(2,4),(3,5),(4,5),(5,6),(6,7),(7,9),(8,11),(9,12),(10,3),(10,6);
    
    
INSERT INTO image(image_url, product_id)
	VALUES ("ideapad_url",1),
		   ("pavilion url",2),
           ("lamp url", 10),
           ("cooler url", 7),
           ("nikon cam url",3);
          
INSERT INTO user(user_name, email, role)
	VALUES ("SHANU AARYAN", "shanuaaryan@email.com","admin"),
    ("SWAYAM", "swayam@mail.com", "customer"),
    ("Tinku", "tinku@mail.com", "customer"),
    ("Mary", "mary@mail.com", "customer");
    
    
INSERT INTO shipping_address(user_id, address, postal_code)
	VALUES (1,"bOKARO", 828403),
    (2,"Yamunanagar",431574),
    (3,"Chomu", 303807),
    (4,"Lapataganj", 911393);
    

INSERT INTO orders(user_id, address_id, total_amount)
	VALUES (1,1,53498);

INSERT INTO orders(user_id, address_id, total_amount)
	VALUES (2,2,58998);

INSERT INTO orders(user_id, address_id, total_amount)
	VALUES (3,3,599);

INSERT INTO orders(user_id, address_id, total_amount)
	VALUES (4,4,73297);


INSERT INTO order_item(product_id,order_id,price_at_purchase,quantity,status)
	VALUES (1,1,52999,1,"shipped"),
    (6,1,499,1,"ordered"),
    (3,2,43999,1,"delivered"),
    (6,2,14999,1,"shipped"),
    (6,3,599,1,"ordered"),
    (10,4,1299,1,"shipped"),
    (9,4,50999,1,"delivered"),
    (8,4,20999,1,"shipped");

INSERT INTO orders(user_id, address_id, total_amount)
	VALUES (1,1,53498);

INSERT INTO order_item(product_id,order_id,price_at_purchase,quantity,status)
	VALUES (1,1,52999,1,"shipped"),
    (6,1,499,1,"cancelled");