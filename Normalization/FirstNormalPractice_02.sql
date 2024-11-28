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

CREATE TABLE BorrowedBooks_1NF (
    MemberID INT NOT NULL,
    MemberName VARCHAR(100),
    Book VARCHAR(100),
    BorrowedDate DATE,
    PRIMARY KEY (MemberID, Book, BorrowedDate) -- Composite Primary Key
);

INSERT INTO BorrowedBooks_1NF (MemberID, MemberName, Book, BorrowedDate)
VALUES
(1, 'Ali', 'BookA', '2024-11-01'),
(1, 'Ali', 'BookB', '2024-11-05'),
(2, 'Bakhat', 'BookC', '2024-11-03'),
(3, 'Sana', 'BookD', '2024-11-02'),
(3, 'Sana', 'BookE', '2024-11-04'),
(3, 'Sana', 'BookF', '2024-11-06');

--Retrieve All Records
SELECT * FROM BorrowedBooks_1NF;

--Find All Books Borrowed by a Specific Member
SELECT Book, BorrowedDate
FROM BorrowedBooks_1NF
WHERE MemberName = 'Sana';

--Count Total Books Borrowed by Each Member
SELECT MemberName, COUNT(*) AS TotalBooks
FROM BorrowedBooks_1NF
GROUP BY MemberName;

--Find Borrowing History of a Specific Book
SELECT MemberName, BorrowedDate
FROM BorrowedBooks_1NF
WHERE Book = 'BookA';

--List All Borrowed Books After a Specific Date
SELECT * 
FROM BorrowedBooks_1NF
WHERE BorrowedDate > '2024-11-03';

--Delete a Record
DELETE FROM BorrowedBooks_1NF
WHERE MemberName = 'Ali' AND Book = 'BookB';

--Update Borrowed Date
UPDATE BorrowedBooks_1NF
SET BorrowedDate = '2024-11-07'
WHERE MemberName = 'Sana' AND Book = 'BookD';

--Find Members Who Borrowed More Than 2 Books
SELECT MemberName
FROM BorrowedBooks_1NF
GROUP BY MemberName
HAVING COUNT(*) > 2;
--

