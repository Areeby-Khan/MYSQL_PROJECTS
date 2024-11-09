---Create a new Database for the chai store:
CREATE DATABASE chaiStore;
USE chaiStore;
--Create a new table for the chai:
CREATE TABLE chai (
    id SERIAL PRIMARY KEY,
    chai_name VARCHAR(100) NOT NULL,
    price DECIMAL(5, 2) NOT NULL,
    chai_type VARCHAR(100) NOT NULL,
    available BOOLEAN NOT NULL
);
--Insert the initial data into the chai store table:
INSERT INTO chai (chai_name, price, chai_type, available)
VALUES ('Masala Chai', 30, 'Spiced', TRUE),
       ('Green Chai', 25, 'Herbal', TRUE),
       ('Black Chai', 20, 'Classic', TRUE),
       ('Iced Chai', 35, 'Cold', FALSE),
       ('Oolong Chai', 40, 'Specialty', TRUE);

SELECT*FROM chai;
--Display all chai names and prices, using column aliases:
SELECT chai_name AS "Chai Name", price AS "Cost in INR"
FROM chai;
--Find all chai varieties that have the word “Chai” in their name:
SELECT * FROM chai
WHERE chai_name LIKE '%Chai%';
--List all chai varieties that cost less than 30Pkr:
SELECT * FROM chai
WHERE price < 30;
--Show chai varieties sorted by price from highest to lowest:
SELECT * FROM chai
ORDER BY price DESC;
--Update the price of “Iced Chai” to 38Pkr and mark it as available:
UPDATE chai
SET price = 38, available = TRUE
WHERE chai_name = 'Iced Chai';
--Delete “Black Chai” from the database:
DELETE FROM chai
WHERE chai_name = 'Black Chai';