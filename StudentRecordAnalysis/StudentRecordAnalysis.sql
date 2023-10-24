CREATE DATABASE IF NOT EXISTS StudentRecord CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

USE StudentRecord;

SET SQL_SAFE_UPDATES = 1;

-- STUDENTS' TABLE
CREATE TABLE IF NOT EXISTS Students(
	student_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    mat_no VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY(student_id)
);
ALTER TABLE Students
AUTO_INCREMENT = 1000;


-- COURSES' TABLE
CREATE TABLE IF NOT EXISTS Courses(
	course_id INT NOT NULL AUTO_INCREMENT,
    course_code VARCHAR(50) NOT NULL,
    course_title VARCHAR(100) NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY(course_id),
    FOREIGN KEY(student_id) REFERENCES Students(student_id) ON DELETE CASCADE
);
ALTER TABLE Courses
AUTO_INCREMENT = 2000;


-- Populating the DB
INSERT INTO Students (first_name, last_name, mat_no)
VALUES
	("Udokike", "Daniel", "AAN/18/2021"),
    ("IKegbunam", "Daniel", "AAN/18/2022"),
    ("Johnson", "Jamubam", "AAN/18/2023"),
    ("Oduenyi", "Ogalanya", "AAN/19/7000")
;


INSERT INTO Courses (course_code, course_title, student_id)
VALUES
	("CSC404", "Software Engineering", "1000"),
    ("CSC404", "Software Engineering", "1001"),
    ("CSC404", "Software Engineering", "1002"),
    ("CSC404", "Software Engineering", "1003"),
	("CSC405", "Data Base Administration", "1000"),
    ("CSC405", "Data Base Administration", "1001"),
    ("CSC405", "Data Base Administration", "1002"),
    ("CSC405", "Data Base Administration", "1003")
;

SELECT * FROM Students;
SELECT * FROM Courses;

SELECT * FROM Students as s
INNER JOIN
Courses as c On
s.student_id = c.student_id;

CREATE TABLE StudentRecordCopy AS
SELECT * FROM Students;

SELECT * FROM Students;


