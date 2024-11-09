-- Active: 1729927262263@@127.0.0.1@3306
CREATE DATABASE Project;
USE Project;
CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR (60),
  product_price DECIMAL(10,2) ,
  product_category VARCHAR(70) ,
  product_stock INT
);
SELECT*FROM products;
INSERT INTO products (product_name, product_price,product_category, product_stock )
VALUES 
('Laptop',1200.00,'Electonics',30),
('headphones',150.00,'Assceries',100),
('Book',200.00,'Stationary',200),
('SmartPhone',700.00,'Electonics',50),
('Gaming Watch',450.00,'Assceries',60),
('Socks',100.00,'Assceries',130),
('Water Bottle', 340.00,'Assceries',90),
('Bag',400.00,'Stationary',100),
('Mirror',120.00,'Assceries',80);
 --I run the query again and agian that result into data dublicate , So i drop the table and created again (COMMENT)
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
  customer_id INT  PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR (70) ,
  last_name VARCHAR (70),
  customer_email VARCHAR (100),
  customer_address VARCHAR (100)
);
SELECT*FROM customers;
INSERT INTO customers (first_name,last_name,customer_email,customer_address)
VALUES
('Maheen','Ali','maheen@gmail.com','Model Town A , Bahwalpur'),
('Gulshan','Amin','gulshan@gmail.com','Model Town B , Lahore'),
('Maria', 'Hassan', 'maria@gmail.com','Haroon Town Multan'),
('Sehr','Basher','sehr@gmail.com','123 Main St, Springfield'),
('Maryam','Noor','maryam@gmail.com','789 Oak St, Springfield'),
('Yumna','Ahmar','yumna123@gmail.com','123 Commerical Area, Okara')
;

INSERT INTO customers (first_name,last_name,customer_email,customer_address)
VALUES 
('Kiran','Khan','kiran190@gmail.com','Sadiq colony , Yazman'),
('Arina','Khan','arina@gmail.com','Sadiq colony , yazman');
SELECT*FROM customers;

CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT , 
  customer_id INT ,
  product_id INT ,
  quantity INT,
  order_date DATE,
  FOREIGN KEY (customer_id)REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
SELECT*FROM orders ;
INSERT INTO orders (customer_id,product_id,quantity,order_date)VALUES 
(1, 1, 1, '2023-10-01'),
(1, 2, 2, '2023-10-02'),
(2, 3, 1, '2023-10-03'),
(3, 4, 3, '2023-10-04'),
(2, 5, 1, '2023-10-05');

--view orders with customer and product details COMMENT
SELECT  customers.first_name , customers.last_name, products.product_name , orders.quantity , orders.order_date
FROM orders 
JOIN customers ON orders.customer_id=customers.customer_id
JOIN products ON orders.product_id=products.product_id;
-- total orders placed by customers COMMENT
SELECT customers.first_name , customers.last_name , COUNT (orders.order_id)
FROM orders 
JOIN customers ON orders.customer_id=customers.customer_id
GROUP BY customers.customer_id;

 --products that are low in stock <50
 SELECT product_name , product_stock
 FROM products 
 WHERE product_stock < 50;

 --Total quantity of each product sold
 SELECT products.product_name , SUM (orders.quantity) As Sold_Items
 FROM orders 
 JOin products ON orders.product_id = products.product_id
 GROUP BY products.product_id;

 --Customers Who Purchased Electronics Products
 SELECT customers.first_name, customers.last_name , customers.customer_address
 FROM orders 
 Join customers ON orders.customer_id=customers.customer_id
 Join products ON orders.product_id = products.product_id
 WHERE products.product_category='Electonics';

 --Total Revenue Generated per Product Category
 SELECT products.product_category , SUM (products.product_price * orders.quantity) As revenue_total
 FROM orders 
 JOIN products ON orders.product_id=products.product_id 
 GROUP BY products.product_id;

-- List All Orders Placed in October 2023
 SELECT  customers.first_name , customers.last_name, products.product_name , orders.quantity , orders.order_date
FROM orders 
JOIN customers ON orders.customer_id=customers.customer_id
JOIN products ON orders.product_id=products.product_id
WHERE orders.order_date BETWEEN '2023-10-01' AND '2023-10-31';

--Find Customers Who Have total_spent
SELECT customers.first_name, customers.last_name ,
SUM (products.product_price * orders.quantity) As total_Spent
 FROM orders 
 JOIN customers ON orders.customer_id=customers.customer_id
 JOIN products ON orders.product_id=products.product_id 
 GROUP BY customers.customer_id
 Having total_spent >600;

 CREATE VIEW E_commerence AS  
 SELECT customers.first_name,customers.last_name , SUM(products.product_price*orders.quantity)
 FROM orders
 JOIN customers ON orders.customer_id=customers.customer_id
 JOIN products ON orders.product_id=products.product_id ;
 DROP VIEW E_commerence;
 CREATE VIEW OnlineStore AS  
 SELECT customers.first_name,customers.last_name , products.product_name 
 , orders.order_date , orders.quantity
 FROM orders
 JOIN customers ON orders.customer_id=customers.customer_id
 JOIN products ON orders.product_id=products.product_id 
 GROUP BY customers.customer_id
 ;
 SELECT*FROM OnlineStore;
 SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

USE Project;
SHOW TABLES ;
DESCRIBE orders;