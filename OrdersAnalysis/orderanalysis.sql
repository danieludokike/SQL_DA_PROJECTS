CREATE DATABASE IF NOT EXISTS OrderAnalysis CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

USE OrderAnalysis;
SET SQL_SAFE_UPDATES = 0;

SHOW TABLES;

-- CLEANING AND FORMATING cookietypes
SELECT * FROM CookieTypes;

-- Replacing dollar sign with empty string
UPDATE CookieTypes
SET RevenuePerCookie = REPLACE(RevenuePerCookie, "$", ""),
CostPerCookie = REPLACE(CostPerCookie, "$", "");

-- REPLACING THE $ WITH EMPTY STRING SO AS TO MAKE CALCULATIONS WITH THE COLUMNS
ALTER TABLE CookieTypes
RENAME COLUMN `Cookie Type` TO CookieType;
ALTER TABLE CookieTypes
RENAME COLUMN `Revenue Per Cookie` To RevenuePerCookie;
ALTER TABLE CookieTypes
RENAME COLUMN `Cost Per Cookie` TO CostPerCookie;

ALTER TABLE CookieTypes
	MODIFY COLUMN RevenuePerCookie DECIMAL(6, 2) NOT NULL,
	MODIFY COLUMN CostPerCookie DECIMAL(6, 2) NOT NULL
;


-- CLEANING AND FORMATING Customers TABLE 
SELECT * FROM Customers;
DESCRIBE Customers;


-- CLEANING AND FORMATING Orders TABLE
SELECT * FROM Orders;
DESCRIBE Orders;

UPDATE Orders
	SET `Units Sold` = REPLACE(`Units Sold`, ",", "");

ALTER TABLE Orders
	MODIFY COLUMN `Customer ID` INT NOT NULL,
    MODIFY COLUMN `Order ID` INT NOT NULL,
    MODIFY COLUMN `Product` VARCHAR(100) NOT NULL,
    MODIFY COLUMN `Units Sold` DECIMAL(6, 2);


-- CLEANING Customers Table 

ALTER TABLE Customers
RENAME COLUMN `Customer ID` TO CustomerID;
ALTER TABLE Customers
RENAME COLUMN `Order ID` TO OrderID;
ALTER TABLE Customers
RENAME COLUMN `Units Sold` TO UnitsSold;