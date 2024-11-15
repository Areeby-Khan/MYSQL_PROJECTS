CREATE DATABASE inventory_management;
USE inventory_management;
--CREATE TABLE : Supplier table Stores supplier details.
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

--CREATE TABLE : Items Table store items
CREATE TABLE Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    supplier_id INT,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

--Inventory Table
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    quantity INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

--Insert Sample Data
INSERT INTO Suppliers (supplier_name, contact_name, phone, email) VALUES
('ABC Supplies', 'Imran Qureshi', '123-456-7890', 'imran@supplies.com'),
('Tech Wholesale', 'Sana javed', '234-567-8901', 'sana@techwholesale.com'),
('Marble Plates','Hashim Asad','333-578-8021','Hashim@marbles.com'),
('Drain Paints','Dawood Ali','210-890-5555','Dawood@Paints.com');

--Add Items
INSERT INTO Items (item_name, supplier_id, category, price) VALUES
('Laptop', 2, 'Electronics', 800.00),
('Office Chair', 1, 'Furniture', 120.00),
('Desk', 1, 'Furniture', 200.00),
('Black Marble',3,'Tile',500.00),
('White Paint',2,'Texture',100.00);
--Add Inventory Records
INSERT INTO Inventory (item_id, quantity) VALUES
(1, 10), 
(2, 25),  
(3, 15);  

-------------------QUERIRES----------------------

--List All Items with Supplier Information

SELECT i.item_id, i.item_name, s.supplier_name, i.category, i.price
FROM Items i
JOIN Suppliers s ON i.supplier_id = s.supplier_id;

--View Inventory with Item Details
SELECT i.item_name, i.category, inv.quantity, i.price
FROM Inventory inv
JOIN Items i ON inv.item_id = i.item_id;

--Find Low Stock Items 
SELECT i.item_name, inv.quantity
FROM Inventory inv
JOIN Items i ON inv.item_id = i.item_id
WHERE inv.quantity < 5;
--Update Stock Quantity for an Item
UPDATE Inventory
SET quantity = quantity + 10
WHERE item_id = 1;  

--View Total Inventory Value for Each Item
SELECT i.item_name, inv.quantity, i.price, (inv.quantity * i.price) AS total_value
FROM Inventory inv
JOIN Items i ON inv.item_id = i.item_id;

--Add New Item with Supplier Details and Stock
-- First, insert the new item
INSERT INTO Items (item_name, supplier_id, category, price)
VALUES ('Printer', 2, 'Electronics', 150.00);

-- Then, add an inventory record for this item
INSERT INTO Inventory (item_id, quantity) VALUES
(LAST_INSERT_ID(), 20);  -- Add 20 units for the new item

--List All Suppliers and Their Supplied Items
SELECT s.supplier_name, i.item_name, i.category
FROM Suppliers s
LEFT JOIN Items i ON s.supplier_id = i.supplier_id
ORDER BY s.supplier_name;
--Count Total Items by Category
SELECT category, COUNT(*) AS total_items
FROM Items
GROUP BY category;
--Calculate the Total Value of Stock by Category
SELECT i.category, SUM(inv.quantity * i.price) AS total_stock_value
FROM Inventory inv
JOIN Items i ON inv.item_id = i.item_id
GROUP BY i.category;
