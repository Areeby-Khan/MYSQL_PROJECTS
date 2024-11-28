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

