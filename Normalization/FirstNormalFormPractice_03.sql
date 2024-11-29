Use Local_Bus_Ticketing_System;

DROP TABLE Students;

CREATE TABLE students (
    student_id INT ,
    student_name VARCHAR(80),
    student_roll_no VARCHAR(80),
    student_courses VARCHAR (80),
    student_age INT NOT NULL
);
INSERT INTO students VALUES  (1,'Rahul',1,'C++ / C-sharp', 20);
INSERT INTO students VALUES  (1,'Haris',1,'Java', 21);
INSERT INTO students VALUES  (2,'Sahil',2,'C++ / C-sharp', 23);
INSERT INTO students VALUES  (3,'adnan',3,'C++ / C-sharp', 22);
INSERT INTO students VALUES  (4,'Lishi',4,'Python / Java', 20);
INSERT INTO students VALUES  (5,'Jamil',5,'Laravel / python', 24);
SELECT *FROM students;
ALTER TABLE students;
ALTER TABLE students
ADD PRIMARY KEY (student_id, student_name);
SELECT student_id
FROM students;

CREATE TABLE Person (
    person_id INT ,
    person_roll_no INT ,
    person_first_name VARCHAR (80),
    person_last_name VARCHAR (80),
    email VARCHAR(80),
    PRIMARY KEY (person_id,person_roll_no),
    UNIQUE (email),
    UNIQUE (person_id,person_first_name,email)
);
INSERT INTO Person VALUES(1,101,'ali','ahmad','ali@gmail.com');
INSERT INTO Person VALUES(2,102,'sana','khan','sana@gmail.com');
SHOW CREATE TABLE Person;
SELECT * 
FROM Person
WHERE person_roll_no = 101 AND person_id = 1;
SELECT email, COUNT(*)
FROM Person
GROUP BY email
HAVING COUNT(*) < 2;

