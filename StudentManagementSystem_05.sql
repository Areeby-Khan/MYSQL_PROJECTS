CREATE DATABASE Management_System;
USE Management_System;
CREATE TABLE students (
    stdId INT PRIMARY KEY AUTO_INCREMENT ,
    firstName VARCHAR(70),
    lastName VARCHAR (70),
    email VARCHAR (60),
    Address VARCHAR (70),
    Age INT NOT NULL
);
INSERT INTO students (firstName,lastName,email,Address,Age) VALUES
('Maryam','Basheer','maryam@gmail.com','Model Town A', 20),
('Sana','Ahmad','sana@gmail.com','Hashmi Garden',19),
('Alina','Rehman','alina123@gmail.com','Fawarah Choke',21),
('Farah','Ajmad','farah@gmail.com','Commerical Area',22),
('Rahat','Ali','rahat@gmail.com','Muneeb Choke Mour',20),
('Mahnoor','Aslam','mahnoor@gmail.com','Shahdara colony ',18),
('Minahil','Naveed','minahil@gmail.com','Medical Colony',21),
('Khatija','Khan','khatija11@gmail.com','Haroon Town',24),
('Sehrish','Fahad','sehrish@gmail.com','Sadiq Colony B',23),
('Maria','Majeed','maria@gmail.com','Model Town C',24);

-- The SELECT statement is used to select data from a database.
SELECT*FROM students;
--To Show tables in the database :
SHOW TABLES;

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    course_code VARCHAR(20),
    credits INT
)
INSERT INTO Courses (course_name, course_code, credits) VALUES 
('Mathematics', 'MATH101', 3),
('Computer Science', 'CS101', 4),
('History', 'HIST101', 2),
('Physics','Phy102',5),
('Biology','Bio104',3),
('Chemistry','Chem101',4),
('Machine Learning','ML105',3);

--The SELECT statement is used to select data from a database.
SELECT*FROM Courses;
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    stdId INT ,
    course_id INT , 
    enrollment_date DATE,
    FOREIGN KEY (stdId) REFERENCES students(stdId),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
INSERT INTO enrollments (stdId,course_id,enrollment_date) VALUES
(1, 1, '2024-10-01'),
(1, 2, '2024-10-02'),
(2, 1, '2024-10-01'),
(3, 3, '2024-10-03');

--The SELECT statement is used to select data from a database.
SELECT*FROM enrollments;
--Display All Students with Their Enrolled Courses
SELECT students.firstName,students.lastName,Age ,
Courses.course_name,Courses.course_code,
enrollments.enrollment_date
FROM enrollments
JOIN students ON enrollments.stdId=students.stdId
JOIN Courses ON enrollments.course_id=Courses.course_id;

--Count of Students Enrolled in Each Course
SELECT Courses.course_name , COUNT(enrollments.stdId) AS student_count
FROM Courses  
LEFT JOIN enrollments ON Courses.course_id=enrollments.course_id
GROUP BY Courses.course_name;

--List Courses with No Enrollments
SELECT Courses.course_name 
FROM Courses
WHERE course_id NOT IN (SELECT course_id FROM enrollments);