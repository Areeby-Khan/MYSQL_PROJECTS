-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product) -- Composite primary key to ensure uniqueness
);

-- Insert data into the Orders table (now in 1NF)
INSERT INTO Orders (OrderID, CustomerName, Product, Quantity)
VALUES
(1001, 'Javeria', 'Pen', 5),
(1001, 'Maria', 'Pencil', 10),
(1002, 'Hassan', 'Notebook', 3),
(1003, 'Bisma', 'Eraser', 2),
(1003, 'Sania', 'Pen', 4);
-- Retrieve all orders in 1NF
SELECT * FROM Orders;

--Select Specific Columns
SELECT OrderID, CustomerName FROM Orders;

--Select with WHERE Clause
SELECT * FROM Orders
WHERE CustomerName = 'Sania';

-- Select Records with Multiple Condition
SELECT * FROM Orders
WHERE CustomerName = 'Javeria' AND Product = 'Pen';

-- Count the Total Number of Orders for a Customer
SELECT COUNT(DISTINCT Product) AS TotalProducts
FROM Orders
WHERE CustomerName = 'Maria';

-- Update a Record
UPDATE Orders
SET Quantity = 15
WHERE OrderID = 1001 AND Product = 'Pen';

