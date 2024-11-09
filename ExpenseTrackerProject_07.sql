--CREATE A DATABASE
CREATE DATABASE expense_tracker;
USE expense_tracker;
--Create Tables
--Create Users Table:
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
--Insert Sample Users:
INSERT INTO Users (username, email) VALUES 
('john_doe', 'john.doe@example.com'),
('jane_smith', 'jane.smith@example.com');

--Create Categories Table:
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);
--Insert Sample Categories:
INSERT INTO Categories (category_name) VALUES 
('Food'),
('Transport'),
('Utilities'),
('Entertainment'),
('Other');

--Create Expenses Table:
CREATE TABLE Expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    expense_date DATE,
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
--Insert Sample Expenses:
INSERT INTO Expenses (user_id, category_id, amount, expense_date, description) VALUES 
(1, 1, 50.00, '2024-01-05', 'Groceries'),
(1, 2, 15.00, '2024-01-07', 'Bus fare'),
(2, 3, 100.00, '2024-01-08', 'Electricity bill'),
(1, 4, 30.00, '2024-01-10', 'Movie tickets');

-- Retrieve all expenses for a user with the total amount spent.
SELECT e.expense_id, c.category_name, e.amount, e.expense_date, e.description
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
WHERE e.user_id = 1;

--Update an expense description.
UPDATE Expenses
SET description = 'Weekly groceries'
WHERE expense_id = 1;
--Remove an expense record.
DELETE FROM Expenses
WHERE expense_id = 2;
--Get Total Expenses for a User:
SELECT SUM(amount) AS total_expenses
FROM Expenses
WHERE user_id = 1;

--List Expenses by Category:
SELECT c.category_name, SUM(e.amount) AS total_per_category
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
GROUP BY c.category_name;

--Find Recent Expenses:
SELECT e.expense_id, c.category_name, e.amount, e.expense_date, e.description
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
WHERE e.expense_date >= CURDATE() - INTERVAL 30 DAY
ORDER BY e.expense_date DESC;

--Count Expenses per User:
SELECT u.username, COUNT(e.expense_id) AS number_of_expenses
FROM Users u
LEFT JOIN Expenses e ON u.user_id = e.user_id
GROUP BY u.user_id;

--List Expenses Over a Certain Amount:
SELECT e.expense_id, c.category_name, e.amount, e.expense_date, e.description
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
WHERE e.amount > 50.00;

--Delete Expenses Older Than a Certain Date:
DELETE FROM Expenses
WHERE expense_date < '2023-01-01';
--Update Multiple Expenses at Once
UPDATE Categories
SET category_name = 'Dining'
WHERE category_name = 'Food';
--Find Users with No Expenses:
SELECT u.username
FROM Users u
LEFT JOIN Expenses e ON u.user_id = e.user_id
WHERE e.expense_id IS NULL;

--Get the Average Expense Amount per Category:
SELECT c.category_name, AVG(e.amount) AS average_expense
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
GROUP BY c.category_name;

--List Expenses in a Given Month:
SELECT e.expense_id, c.category_name, e.amount, e.expense_date, e.description
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
WHERE MONTH(e.expense_date) = 1 AND YEAR(e.expense_date) = 2024;