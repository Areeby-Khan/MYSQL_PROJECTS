DROP DATABASE First_normal_form;
CREATE DATABASE  IF NOT EXISTS First_Normal_Form;
USE First_Normal_Form;
CREATE TABLE Employee_data (
    emplyee_id INT NOT NULL ,
    emplyee_name VARCHAR(80),
    contact_no VARCHAR(80),
    emplyee_department VARCHAR(80)
);
--This table violates 1NF because the contact_no & department
-- column contains multiple values in a single cell.
INSERT INTO Employee_data VALUES
(1,'Sania','00000 , 22222', 'HR'),
(2,'Samia','20222 , 90090','IT'),
(3,'Kasim', '23332','Sales'),
(4,'Qahil','30800','Tester , Raw checker'),
(5,'Wakar','40402','Marketing');
SELECT*FROM Employee_data;

CREATE TABLE Employee_data_1NF(
      emp_id INT NOT NULL,
      emp_name VARCHAR(80),
      emp_contact_no VARCHAR(80),
      emp_deprt VARCHAR(80)
);
INSERT INTO Employee_data_1NF VALUES
(1,'Sania','00000', 'HR'),
(1,'Sania','22222', 'HR'),
(2,'Samia','20222','IT'),
(2,'Samia','90090','IT'),
(3,'Kasim', '23332','Sales'),
(4,'Qahil','30800','Tester , Raw checker'),
(4,'Qahil','30800','Raw checker'),
(5,'Wakar','40402','Marketing');
SELECT*FROM Employee_data_1NF;
--------------------------------QUERIES-------------------------------------------

--Get All Phone Numbers for Samia:
SELECT emp_contact_no
FROM Employee_data_1NF
WHERE emp_id=2;
--Find Employees with Multiple Phone Numbers:
SELECT  emp_name , COUNT(emp_contact_no) AS Contact_count
FROM Employee_data_1NF
GROUP BY emp_name
HAVING Contact_count >1;

--Find Employees in a Specific Department
SELECT  emp_id,emp_name 
FROM Employee_data_1NF
WHERE emp_deprt = 'IT';

--Count the Total Number of Phone Numbers for Each Employee
SELECT emp_name , COUNT(emp_contact_no) AS emp_phone_no
FROM Employee_data_1NF
GROUP BY emp_name;

-- List Employees with More Than One Phone Number
SELECT emp_name , emp_id 
FROM Employee_data_1NF
GROUP BY emp_name , emp_id 
HAVING COUNT(emp_contact_no) >1;

--Retrieve Employees with a Specific Phone Number
SELECT  emp_id, emp_name
FROM Employee_data_1NF
WHERE emp_contact_no='40402';

--Find All Departments with More Than One Employee
SELECT emp_deprt , COUNT (emp_id) AS emp_count
FROM Employee_data_1NF
GROUP BY emp_deprt
HAVING emp_count;

--Get the Total Number of Phone Numbers in the Company
SELECT COUNT(emp_contact_no) AS TotalPhoneNumbers
FROM Employee_data_1NF;

-- Retrieve Employees Without a Phone Number
SELECT emp_name
FROM Employee_data_1NF
WHERE emp_contact_no IS NULL;

--Add a New Phone Number for an Existing Employee
INSERT INTO Employee_data_1NF (emp_id, emp_name,emp_contact_no, emp_deprt)
VALUES (2, 'Orhan', '55555', 'IT');

--Update an Employee's Phone Number
UPDATE Employee_data_1NF
SET emp_contact_no = '45403'
WHERE emp_id=4 ;

--Delete an Employee's Specific Phone Number
DELETE FROM Employee_data_1NF
WHERE emp_id= 5 AND emp_contact_no = '40402';

--Find Employees Whose Name Starts with 'A'
SELECT emp_name
FROM Employee_data_1NF
WHERE emp_name LIKE 'S%';

--List All Employees Sorted by Department and Name
SELECT DISTINCT emp_id ,emp_name , emp_contact_no , emp_deprt
FROM Employee_data_1NF
ORDER BY emp_deprt,emp_name;








