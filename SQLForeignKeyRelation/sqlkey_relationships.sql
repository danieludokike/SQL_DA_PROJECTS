CREATE DATABASE IF NOT EXISTS mysqlkey CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

USE mysqlkey;

CREATE TABLE IF NOT EXISTS Users(
	userID VARCHAR(10) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    PRIMARY KEY(userID)
) CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

INSERT INTO Users (userID, first_name, last_name, email_address)
VALUES 
	("uuid001", "Udokike", "Daniel", "udokiked@gmail.com"),
    ("uuid002", "Oduenyi", "Odu", "odu@gmail.com"),
    ("uuid003", "Igwekamma", "Francis", "francis@gmail.com");
    
ALTER TABLE Users
ADD CONSTRAINT unique_email_constraint UNIQUE (email_address);

CREATE TABLE IF NOT EXISTS Courses (
	courseID VARCHAR(10) NOT NULL,
    userID VARCHAR(10) NOT NULL,
    courseCode VARCHAR(20) NOT NULL,
    courseTitle VARCHAR(50) NOT NULL,
    PRIMARY KEY(courseID, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
) CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;


INSERT INTO Courses (courseID, userID, courseCode, courseTitle)
VALUES 
	("csc001", "uuid001", "CSC405", "Compiler Constructions"),
    ("csc002", "uuid001", "INF406", "Information Technology Law"),
    ("csc003", "uuid003", "CSC412", "Web Development");


CREATE TABLE IF NOT EXISTS Orders (
	orderID VARCHAR(10) NOT NULL,
    courseID VARCHAR(10) NOT NULL,
    userID VARCHAR(10) NOT NULL,
    amount DECIMAL(6, 2) NOT NULL,
    orderDate DATETIME DEFAULT NOW(),
    PRIMARY KEY (orderID, courseID, userID),
    FOREIGN KEY (courseID) REFERENCES Courses(courseID),
    FOREIGN KEY (userID) REFERENCES Users(userID)

) CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

INSERT INTO Orders (orderID, courseID, userID, amount)
VALUES 
	("PAY001", "csc001", "uuid001", 10.5),
    ("PAY002", "csc002", "uuid002", 15.54),
    ("PAY003", "csc003", "uuid002", 11.50);

ALTER TABLE Orders
ADD CONSTRAINT amount_check_constraints CHECK (amount >= 10);
    