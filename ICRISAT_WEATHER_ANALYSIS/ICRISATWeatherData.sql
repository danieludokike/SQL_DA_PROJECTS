CREATE DATABASE IF NOT EXISTS ICRISATWeatherDB CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Table is created from mysql workbench Table Data Import Wizard

-- Using ICRISATWeatherDB
USE ICRISATWeatherDB;
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM ICRISATWeather;

-- Cleaning Data
ALTER TABLE ICRISATWeather
DROP COLUMN `MyUnknownColumn`,
DROP COLUMN `MyUnknownColumn_[0]`,
DROP COLUMN `MyUnknownColumn_[1]`,
DROP COLUMN `MyUnknownColumn_[2]`,
DROP COLUMN `MyUnknownColumn_[3]`,
DROP COLUMN `MyUnknownColumn_[4]`,
DROP COLUMN `MyUnknownColumn_[5]`,
DROP COLUMN `MyUnknownColumn_[6]`,
DROP COLUMN `MyUnknownColumn_[7]`;

DESCRIBE ICRISATWeather;

-- Updating ICRISTATWeather to the right date format
UPDATE ICRISATWeather 
SET
	Date = STR_TO_DATE(Date, "%Y-%m-%d")
;

ALTER TABLE ICRISATWeather
RENAME COLUMN Date TO EventDate;

ALTER TABLE ICRISATWeather
MODIFY COLUMN EventDate DATE;


-- Data Analysis
SELECT * FROM ICRISATWeather;

-- Total Record
SELECT COUNT(EventDate) AS TotalRecord
FROM ICRISATWeather;

-- Cumulative Rain Record each year
SELECT YEAR(EventDate) AS EventYear, SUM(cum_Rain) AS CumulativeRain
FROM ICRISATWeather 
GROUP BY (EventYear)
ORDER BY (CumulativeRain) DESC; -- Hmm the highest cumulative rain record happened in 2018

-- Maximum Mean Temperatur by year
SELECT YEAR(EventDate) As EventYear, AVG(MaxT) as AverageTemperature
FROM ICRISATWeather 
GROUP BY (EventYear)
ORDER BY (AverageTemperature) DESC; -- HIgh temperature inturn high rainfall. Same 2018

SELECT * FROM ICRISATWeather;

