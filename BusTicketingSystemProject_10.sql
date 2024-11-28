CREATE DATABASE  Local_Bus_Ticketing_System;
USE Local_Bus_Ticketing_System;
CREATE TABLE Bus(
    bus_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_number VARCHAR (40),
    bus_type VARCHAR (60),
    bus_capacity INT NOT NULL
);
INSERT INTO Bus (bus_number,bus_type,bus_capacity)VALUES 
('ABC123','AC',60),
('AEC123','NON-AC',30),
('LMN230','AC',50),
('AOP129','Non-AC',60),
('HGF606','AC',55);
SELECT *FROM Bus;

CREATE TABLE Routes (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    route_origin VARCHAR (80) NOT NULL,
    route_description VARCHAR (80) NOT NULL,
    distance_km DECIMAL (5, 2) NOT NULL,
    route_direction ENUM ('Moter way','Down sider') DEFAULT'Moter way'
);
INSERT INTO Routes(route_origin,route_description,distance_km,route_direction) VALUES
('City A','City B',120.50,'Down sider'),
('City C','City D',340.70,'Moter way'),
('City X','City Y',568.00,'Down sider'),
('City U','City A',403.45,'Moter way');
SELECT *FROM Routes;
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(80)
);
INSERT INTO Passengers (first_name, last_name, contact_number,email)
VALUES 
('Ali', 'Danish', '1234567890','ali@gmail.com'),
('Sana', 'Shamir', '0987654321','sana@gmail.com'),
('Maria', 'Hassan', '5555555555','Maria@gmail.com'),
('Mahnoor','Khan','4545454545','mahnoor@gmail.com');

INSERT INTO Passengers (first_name, last_name, contact_number)
VALUES ('New', 'Passenger', '1112223333');

SELECT *FROM Passengers;

CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    bus_id INT NOT NULL,
    route_id INT NOT NULL,
    booking_date DATE NOT NULL,
    journey_date DATE NOT NULL,
    ticket_price DECIMAL(8, 2) NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    FOREIGN KEY (route_id) REFERENCES Routes(route_id)
);
INSERT INTO Tickets (passenger_id, bus_id, route_id, booking_date, journey_date, ticket_price)
VALUES (4, 1, 1, '2024-10-29', '2024-10-30', 450.00);
INSERT INTO Tickets (passenger_id, bus_id, route_id, booking_date, journey_date, ticket_price)
VALUES (2, 2, 1, '2024-06-19', '2024-10-30', 680.00);
INSERT INTO Tickets (passenger_id, bus_id, route_id, booking_date, journey_date, ticket_price)
VALUES (4, 1, 1, '2024-10-29', '2024-10-30', 450.00);
INSERT INTO Tickets (passenger_id, bus_id, route_id, booking_date, journey_date, ticket_price)
VALUES (3, 1, 1, '2024-04-04', '2024-06-10', 450.00);
SELECT*FROM Tickets;

------------------------------QUERIES------------------------------

--List All Ticket Bookings
SELECT Tickets.ticket_id,
CONCAT(Passengers.first_name,' ', Passengers.last_name) AS Passenger_Name,
Bus.bus_number,
Routes.route_origin,
Routes.route_description,
Tickets.journey_date,
Tickets.ticket_price
FROM Tickets
JOIN Passengers ON Tickets.passenger_id=Passengers.passenger_id
JOIN Bus ON Tickets.bus_id=Bus.bus_id
JOIN Routes ON Tickets.route_id=Routes.route_id;

-- Find Total Tickets Sold for Each Bus
SELECT Bus.bus_number,
COUNT (Tickets.ticket_id)
AS ticket_Sold
FROM Tickets
JOIN Bus ON Tickets.bus_id=Bus.bus_id
GROUP BY Bus.bus_id;

-- Find Passengers Who Have Booked Tickets for City C
SELECT 
CONCAT (Passengers.first_name, ' ', Passengers.last_name) AS passenger_Name,
Routes.route_description
FROM Tickets
JOIN Passengers ON Tickets.passenger_id=Passengers.passenger_id
JOIN Routes ON Tickets.route_id=Routes.route_id
WHERE Routes.route_description='City C';

--Find Routes With the Most Ticket Sales
SELECT 
    Routes.route_origin,
    Routes.route_description,
    COUNT (Tickets.ticket_id) AS tickets_sold
    FROM Routes
    JOIN Tickets ON Routes.route_id=Tickets.route_id
    GROUP BY Routes.route_id,Routes.route_origin, Routes.route_description
    ORDER BY Tickets_sold DESC;
--Find Passengers Who Traveled on a Specific Date
SELECT
 CONCAT (Passengers.first_name,' ',Passengers.last_name) AS Passenger_name,
 Tickets.journey_date
 FROM Passengers
 JOIN Tickets ON Passengers.passenger_id=Tickets.ticket_id
 WHERE Tickets.journey_date='2024-10-30';

 --Check Seats Remaining for Each Bus
 SELECT 
    Bus.bus_number, 
    Bus.bus_capacity, 
    COUNT(Tickets.ticket_id) AS tickets_booked, 
    Bus.bus_capacity - COUNT(t.ticket_id) AS seats_remaining
FROM Bus b
LEFT JOIN Tickets t ON Bus.bus_id = Tickets.bus_id
GROUP BY Bus.bus_id, Bus.bus_capacity;

--Find the Most Frequently Traveled Passenger
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name, 
    COUNT(t.ticket_id) AS tickets_booked
FROM Passengers p
JOIN Tickets t ON p.passenger_id = t.passenger_id
GROUP BY p.passenger_id, p.first_name, p.last_name
ORDER BY tickets_booked DESC
LIMIT 1;

-- Find Routes Longer Than 150 km
SELECT 
    route_origin, 
    route_description,
    distance_km
FROM Routes
WHERE distance_km > 150;

-- List All Tickets That Have Not Been Booked
SELECT 
     Passengers.passenger_id,
     CONCAT(Passengers.first_name,' ', Passengers.last_name) AS Pasenger_Name
     FROM Passengers
     LEFT JOIN Tickets ON Passengers.passenger_id=Tickets.passenger_id
     WHERE Tickets.ticket_id IS NULL;
     
--Check Seats Remaining for Each Bus
SELECT 
    Bus.bus_number, 
    Bus.bus_capacity, 
    COUNT(Tickets.ticket_id) AS tickets_booked, 
    Bus.bus_capacity - COUNT(t.ticket_id) AS seats_remaining
FROM Bus b
LEFT JOIN Tickets t ON Bus.bus_id = Tickets.bus_id
GROUP BY Bus.bus_id, Bus_bus.capacity;
SELECT Bus.bus_number 
FROM Bus;
