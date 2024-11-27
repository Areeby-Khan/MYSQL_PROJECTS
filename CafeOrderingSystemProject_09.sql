CREATE DATABASE small_cafe_ordering_system;
USE small_cafe_ordering_system;

--A system for managing orders, menu items, and customers in a small café.
CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR (80),
    item_price DECIMAL (5,4),
    item_category ENUM ('Desert','Drink','Main Course', 'Chinese Cuisine'),
    item_description ENUM('Healthy', 'Fast Food')
);
INSERT INTO Menu_Items (item_name,item_price,item_category,item_description)VALUES 
('Latte',4.50,'Drink','Healthy'),
('Cheesecake',5.00,'Desert','Fast Food'),
('Pasta',3.70,'Main Course','Fast Food'),
('Brownies',6.00,'Desert','Fast Food'),
('Sandwich',2.90,'Main Course','Healthy'),
('Choumin',6.66,'Chinese Cuisine','Fast Food'),
('Espresso',3.00,'Drink','Healthy'),
('Lasania',8.50,'Main Course','Healthy'),
('Burger',4.44,'Main Course','Fast Food'),
('Pizza',6.41,'Main Course','Fast Food');
SELECT *FROM Menu_Items;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT ,
    first_name VARCHAR (80),
    last_name VARCHAR (80),
    contact_no VARCHAR (30),
    email VARCHAR(80)
);
INSERT INTO Customers (first_name,last_name,contact_no,email) VALUES 
('Sana','Khan','0310-1234-6768','sana123@gmail.com'),
('Samia','Arshad','0319-8090-2222','Samia@gmail.com'),
('Noor','Sarim','0311-8210-8502','noor@gmail.edu'),
('Maheen','Danial','0318-8468-9090','maheen@gmail.com'),
('Maria','Hassan','0345-6767-8888','maria@gmail.com'),
('Kamran','Haleem','0306-7042-6032','kamran@gmail.com'),
('Jamil','Rahman','0333-1079-6033','jamil@gmail.pk'),
('Yaseen','Kareem','0336-6950-9046','yaseen@gmail.com');
SELECT*FROM Customers;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT ,
    order_date DATE ,
    total_amount DECIMAL (7,4),
    Foreign Key (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-10-15', 12.00),
(2, '2024-10-16', 19.00),
(3, '2024-10-17', 11.00),
(4,'2024-10-18',12.00),
(5,'2024-10-20',14.00),
(6,'2024-10-21',13.00);
SELECT *FROM Orders;

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT ,
    order_id INT,
    item_id INT,
    quantity INT,
    Foreign Key (order_id) REFERENCES Orders(order_id),
    Foreign Key (item_id) REFERENCES Menu_Items(item_id)
);
INSERT INTO Order_Items (order_id, item_id, quantity) VALUES
(1, 1, 1), 
(1, 2, 1), 
(2, 3, 2), 
(3, 4, 2), 
(2, 5, 1),
(4,3,1);
SELECT *FROM Order_Items;

-----------------------------QUERIES---------------------------------------

--List All Menu Items with Their Prices
SELECT item_id,item_name,item_price
FROM Menu_Items;

--List All Orders with Customer Names and Total Amounts
SELECT Orders.order_id , Orders.order_date , Customers.customer_id,Customers.first_name,Orders.total_amount
FROM Orders
JOIN Customers ON Orders.customer_id=Customers.customer_id;

-- Find the Most Frequently Ordered Item
SELECT m.item_name, SUM(oi.quantity) AS total_quantity
FROM Order_Items oi
JOIN Menu_Items m ON oi.item_id = m.item_id
GROUP BY m.item_id
ORDER BY total_quantity DESC
LIMIT 1;

--Calculate the Total Earnings for the Café
SELECT SUM(total_amount) AS total_earnings
FROM Orders;

--Show Customers Who Haven't Placed Any Orders
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Find Customers Who Ordered Specific Items (e.g., Cheesecake)
SELECT DISTINCT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Menu_Items m ON oi.item_id = m.item_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE m.item_name = 'Cheesecake';

-- Total Quantity Sold Per Item
SELECT 
    m.item_name, 
    SUM(oi.quantity) AS total_quantity_sold
FROM Order_Items oi
JOIN Menu_Items m ON oi.item_id = m.item_id
GROUP BY m.item_id
ORDER BY total_quantity_sold DESC;

--Top Spending Customers
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
    SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;

--Create a View for Most Frequently Ordered Items
CREATE VIEW MostFrequentlyOrderedItems AS
SELECT 
    m.item_name, 
    SUM(oi.quantity) AS total_quantity_sold
FROM Order_Items oi
JOIN Menu_Items m ON oi.item_id = m.item_id
GROUP BY m.item_id
ORDER BY total_quantity_sold DESC;

SELECT * FROM MostFrequentlyOrderedItems;























