CREATE DATABASE composite;
USE composite;
CREATE TABLE Courses (
    course_id INT NOT NULL,
    couse_name VARCHAR(80),
    course_type VARCHAR (80)
);
INSERT INTO Courses (course_id,couse_name,course_type) VALUES
(1,'Java','Computer'),
(2,'python','Machine learning'),
(3,'c sharp','Science');
SELECT*FROM Courses;

CREATE TABLE Students(
    student_id INT ,
    student_name VARCHAR (80),
    student_age  INT not NULL
);
INSERT INTO Students (student_id,student_name,student_age)VALUES
(1,'sana',20),
(2,'mria',22),
(3,'ali',21),
(4,'alena',20);
SELECT *FROM Students;
CREATE TABLE student_Course(
    student_id INT ,
    course_id INT,
    Grade VARCHAR(20),
    PRIMARY KEY (student_id,course_id)
);
