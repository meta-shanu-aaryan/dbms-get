-- Consider a form where providing a Zip Code populates associated City and State. 
-- Create appropriate tables and relationships for the same and write a SQL
-- query for that returns a Resultset containing Zip Code, City Names and
-- States ordered by State Name and City Name.
-- (Create 3 tables to store State, District/City & Zip code separately)

CREATE TABLE state (
    state_id INT PRIMARY KEY AUTO_INCREMENT,
    state_name VARCHAR(50) NOT NULL
);

CREATE TABLE city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(50) NOT NULL
);

CREATE TABLE postal_code (
    zip_code INT PRIMARY KEY,
    state_id INT NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (state_id)
        REFERENCES state (state_id),
    FOREIGN KEY (city_id)
        REFERENCES city (city_id)
);



-- Insert more states
INSERT INTO state (state_name) VALUES 
('Uttar Pradesh'),
('Rajasthan'),
('Gujarat'),
('Madhya Pradesh'),
('Telangana'),
('Punjab'),
('Haryana'),
('Bihar'),
('Odisha'),
('Assam');

-- Insert more cities
INSERT INTO city (city_name) VALUES 
('Lucknow'),
('Jaipur'),
('Ahmedabad'),
('Indore'),
('Hyderabad'),
('Chandigarh'),
('Gurgaon'),
('Patna'),
('Bhubaneswar'),
('Guwahati');

-- Insert more postal codes
INSERT INTO postal_code (zip_code, state_id, city_id) VALUES 
(226001, 1, 1),  -- Lucknow, Uttar Pradesh
(302001, 2, 2),  -- Jaipur, Rajasthan
(380001, 3, 3),  -- Ahmedabad, Gujarat
(452001, 4, 4), -- Indore, Madhya Pradesh
(500001, 5, 5), -- Hyderabad, Telangana
(160001, 6, 6), -- Chandigarh, Punjab
(122001, 7, 7), -- Gurgaon, Haryana
(800001, 8, 8), -- Patna, Bihar
(751001, 9, 9), -- Bhubaneswar, Odisha
(781001, 10, 10); -- Guwahati, Assam


SELECT 
    p.zip_code, c.city_name, s.state_name
FROM
    postal_code p
        JOIN
    city c ON p.city_id = c.city_id
        JOIN
    state s ON p.state_id = s.state_id
WHERE
    p.zip_code = 122001;
    
