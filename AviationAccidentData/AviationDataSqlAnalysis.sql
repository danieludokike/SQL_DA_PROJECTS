CREATE DATABASE IF NOT EXISTS AviationAccidentData CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

USE AviationAccidentData;
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM AviationData;

-- Making table columns datatype to be in the right format
ALTER TABLE AviationData
MODIFY `Event.Date` DATE,
MODIFY  `Event.Id` VARCHAR(50) NOT NULL,
ADD COLUMN ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT AFTER `Event.Id`;


DESCRIBE AviationData;

-- AVIATION ACCIDENT BY DATE
SELECT `Event.Date`, Location, Country, `Total.Fatal.Injuries`
FROM AviationData;

-- AVIATION ACCIDENT IN UNITED STATES
SELECT `Event.Date`, Location, Country, `Total.Fatal.Injuries`
FROM AviationData
WHERE Country = "United States";

-- AVIATION ACCIDENT BY YEAR
SELECT YEAR(`Event.Date`) AS AccidentYear, SUM(`Total.Fatal.Injuries`) as TotalInjuries
FROM AviationData
GROUP BY (AccidentYear)
ORDER BY  AccidentYear ASC, TotalInjuries ASC;

SELECT Country, SUM(`Total.Fatal.Injuries`) as TotalInjuries
FROM AviationData
GROUP BY Country
ORDER BY Country;

-- Total Injuries LOcations
SELECT Location, SUM(`Total.Fatal.Injuries`) as TotalInjuries
FROM AviationData
GROUP BY (Location);

-- Accident By Weather Condition
SELECT `Weather.Condition`, SUM(`Total.Fatal.Injuries`) AS TotalInjuries
FROM AviationData
GROUP BY (`Weather.Condition`);

-- Aviation Accident By Aircraft Make
SELECT Make, SUM(`Total.Fatal.Injuries`) AS TotalInjuries
FROM AviationData
GROUP BY (Make);


