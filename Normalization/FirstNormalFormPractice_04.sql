Use Local_Bus_Ticketing_System;

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(80),
    suppliers VARCHAR(80),
    supply_quantity INT ,
    PRIMARY KEY (product_id,suppliers) -- Composite Key
);

INSERT INTO Products (product_id, product_name, suppliers, supply_quantity)
VALUES
(101, 'Laptop', 'SupplierA', 50),
(101, 'Laptop', 'SupplierB', 30),
(102, 'Phone', 'SupplierC', 100),
(103, 'Tablet', 'SupplierA', 20),
(103, 'Tablet', 'SupplierD', 40),
(104,'Washing Machine','SupplierD',20),
(104,'Washing Machine','SupplierA',30),
(105,'Oven','SupplierE',20);

--Retrieve all suppliers for a specific product:
SELECT suppliers,supply_quantity
FROM Products
WHERE product_name = 'Washing Machine';

--Retrieve All Records for a Specific Composite Key
SELECT * 
FROM Products
WHERE product_id = 103 AND suppliers = 'SupplierA';

-- Retrieve All Suppliers for a Specific Product
SELECT suppliers , supply_quantity
FROM Products
WHERE product_id= 103;

--. Find Total Supply Quantity for Each Product
SELECT product_id, product_name , SUM(supply_quantity) AS total_quantity
FROM Products
GROUP BY product_id , product_name;

--Update the Supply Quantity for a Specific Composite Key
UPDATE Products
SET supply_quantity=70
WHERE product_id=101 AND suppliers='SupplierA';

--Delete a Specific Record Using the Composite Key
DELETE FROM Products
WHERE product_id = 101 AND suppliers='SupplierA';

SELECT *FROM Products;
--Retrieve Products Supplied by More Than One Supplier
SELECT  product_id, product_name, COUNT(DISTINCT suppliers ) AS suppliers_Count
FROM Products
GROUP BY  product_id, product_name 
ORDER BY suppliers_Count>1;

-- Find the Largest Supply Quantity for Each Supplier
SELECT  suppliers , MAX(supply_quantity) As largest_supplier
FROM Products
GROUP BY  suppliers;

--Identify Suppliers Who Supply a Specific Product
SELECT suppliers
FROM Products
WHERE product_name='Phone';

--Retrieve Products with Supply Quantity Greater Than a Threshold
SELECT product_name , suppliers  , product_id
FROM Products
WHERE supply_quantity >40;

--Count Total Products Supplied by Each Supplier
SELECT  suppliers, COUNT(DISTINCT product_id)
FROM Products
GROUP BY suppliers;

--Find Suppliers Supplying Multiple Products
SELECT suppliers, COUNT(DISTINCT product_id) AS ProductCount
FROM Products
GROUP BY suppliers
HAVING ProductCount > 1;

--List Products with Total Supply Quantity Across All Suppliers
SELECT product_id, product_name , SUM(supply_quantity) AS TotalSupply
FROM Products
GROUP BY product_id, product_name
ORDER BY TotalSupply DESC;

--Retrieve Suppliers Who Supply the Least Quantity for Each Product
SELECT product_id ,product_name ,suppliers, MIN (supply_quantity)
FROM Products
GROUP BY product_id , product_name, suppliers
ORDER BY  suppliers;

--identify Products Where a Specific Supplier is the Sole Provider
SELECT product_id, product_name, suppliers
FROM Products
GROUP BY product_id, product_name, suppliers
HAVING COUNT(DISTINCT suppliers) = 1;

