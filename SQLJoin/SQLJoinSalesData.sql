CREATE DATABASE IF NOT EXISTS SQLSalesData CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;
 USE SQLSalesData;
 
 -- Turning off SQL_SAFE_UPDATES
 SET SQL_SAFE_UPDATES = 0;
 SHOW VARIABLES LIKE 'SQL_SAFE_UPDATES';
 
 -- TABLES WERE CREATED WITH THE CSV FILES USING THE 'TABLE DATA IMPORT WIZARD' IN MYSQL WORKBENCH.
 -- SHOWING ALL TABLES AND DESCRIPTIONS
 SELECT * FROM customers;
 SELECT * FROM employees;
 SELECT * FROM locations;
 SELECT * FROM products;
 SELECT * FROM salesData;
 
 -- ---------------------
 DESCRIBE customers;
 DESCRIBE employees;
 DESCRIBE locations;
 DESCRIBE products;
 DESCRIBE salesData;
 
 
 -- ALTERING TABLES TO CREATE REQUIRED PRIMARY AND FOREIGN KEYS RELATIONSHIPS
 ALTER TABLE customers
 MODIFY COLUMN customer_id INT NOT NULL PRIMARY KEY,
 MODIFY COLUMN name VARCHAR(150) NOT NULL;
 
 ALTER TABLE employees
 MODIFY COLUMN employee_id INT NOT NULL PRIMARY KEY,
 MODIFY COLUMN name VARCHAR(150) NOT NULL;

ALTER TABLE locations
RENAME COLUMN `zip code` TO zip_code,
RENAME COLUMN countries TO country;

ALTER TABLE locations
MODIFY COLUMN id INT NOT NULL PRIMARY KEY,
MODIFY COLUMN city VARCHAR(100) NOT NULL,
MODIFY COLUMN country VARCHAR(100) NULL,
MODIFY COLUMN zip_code INT NULL,
MODIFY COLUMN latitude VARCHAR(50) NULL,
MODIFY COLUMN longitude VARCHAR(50) NULL,
MODIFY COLUMN state VARCHAR(50) NULL;

ALTER TABLE products
RENAME COLUMN `profit margine` TO profit_margine,
RENAME COLUMN `tax rate` TO tax_rate;

ALTER TABLE products
MODIFY COLUMN product_id INT NOT NULL PRIMARY KEY,
MODIFY COLUMN product VARCHAR(50) NULL,
MODIFY COLUMN price DECIMAL(6, 2) NULL,
MODIFY COLUMN profit_margine DECIMAL(6, 2) NULL,
MODIFY COLUMN tax_rate DECIMAL(6, 2) NULL;

ALTER TABLE salesData
MODIFY COLUMN id INT NOT NULL PRIMARY KEY,
MODIFY COLUMN customer_id INT NOT NULL,
MODIFY COLUMN location_id INT NOT NULL,
MODIFY COLUMN product_id INT NOT NULL,
MODIFY COLUMN employee_id INT NOT NULL,
MODIFY COLUMN date DATE,
MODIFY COLUMN quantity INT NOT NULL;

ALTER TABLE salesData
ADD CONSTRAINT salesData_to_customer_foreignkey_relations FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
ADD CONSTRAINT salesData_to_location_foreignkey_relations FOREIGN KEY(location_id) REFERENCES locations(id),
ADD CONSTRAINT salesData_to_product_foreignkey_relations FOREIGN KEY(product_id) REFERENCES products(product_id),
ADD CONSTRAINT salesData_to_employee_foreignkey_relations FOREIGN KEY(employee_id) REFERENCES employees(employee_id);


# ALL PRODUCTS AND PRICE
SELECT product, price
FROM
products;


-- GET CUSTOMERS' AND THEIR ORDER
SELECT * FROM customers;
SELECT * FROM salesData;

SELECT c.customer_id, c.name, s.id as order_id, s.location_id, s.date, s.quantity
FROM
customers as c
INNER JOIN
salesData as s 
ON
c.customer_id = s.customer_id;

-- GET Customers' and the total number of quantity of product they have ordered
SELECT c.name, SUM(s.quantity) quantity
FROM
customers as c
INNER JOIN
salesData as s 
ON
c.customer_id = s.customer_id
GROUP BY (c.name)
ORDER BY quantity DESC;

-- How many Customers in the database
SELECT COUNT(*) as total_customer FROM
customers;


-- Show all Customers that their names start with Al 
SELECT name FROM customers
WHERE name LIKE "Al%";

-- Show first 10 Customers with the highest quantity ordered
SELECT c.name, SUM(o.quantity) AS Quantity
FROM
customers as c
INNER JOIN
salesData as o
ON
c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY Quantity DESC
LIMIT 10;

-- Add a new column 'goal_met' on salesData table
ALTER TABLE salesData
ADD COLUMN goal_met ENUM("TRUE", "FALSE") NOT NULL DEFAULT "FALSE";

SELECT * FROM salesData;

-- Set goal_met to true when quantity ordered by a customer is > 4, set false else.
UPDATE salesData
SET goal_met = 
	CASE
		WHEN quantity > 4 THEN  "TRUE"
        ELSE goal_met
	END;
    

-- GEt all the quantities sold each year
SELECT YEAR(date) as Year, sum(quantity) as Quantity
FROM salesData
GROUP BY Year 
ORDER BY Quantity DESC;
 
