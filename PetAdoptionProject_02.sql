CREATE DATABASE Pet_Adoption_Management_System;
USE Pet_Adoption_Management_System;
CREATE TABLE Pets (
    pet_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_name VARCHAR (70),
    species VARCHAR (70),
    breed VARCHAR (70),
    age INT,
    status ENUM ('Available','Adopted') DEFAULT 'Available'
);
INSERT INTO Pets (pet_name,species,breed,age,status) VALUES 
('BUDDY','Dog','Gold Retriver',4,'Available');
INSERT INTO Pets (pet_name,species,breed,age,status)VALUES 
('Whiskers','Cat','Siamiea',3,'Available'),
('Aegean','Cat','Natural',2,'Adopted');
INSERT INTO Pets (pet_name,species,breed,age,status) VALUES
('Charlie','Dog','Beagle',3,'Available'),
('Fluffy','Rabbit','Angora',1,'Adopted'),
('Muscovy ducks','Ducks','Pekins',2,'Available');
SELECT *FROM Pets;

CREATE TABLE Adopters (
    adopter_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR (70),
    last_name VARCHAR (70),
    contact_no VARCHAR (70),
    email VARCHAR (100),
    status ENUM ('Employed','Non-Employer') DEFAULT 'Employed'
);
INSERT INTO Adopters (first_name,last_name,contact_no,email,status) VALUES 
('Fatima','Naveed','232-666-7777','fatima@gmail.com','Non-employer'),
('Ali','Ahamad','330-880-6664','ali@gmail','Employed'),
('Mahnoor','Khan','202-882-5353','mahnoor@gmail.com','Non-employer'),
('Kiran','Kasim','101-000-7909','kiram123@gmail.com','Employed'),
('Ajmal','Hassan','303-665-8999','ajmal@gmail.edu','Employed'),
('Dawood','Alam','101-891-6576','dawood330@gmail.com','Non-Employer'),
('Sana','Abid','333-111-7777','sana@gmail.com','Employed');
SELECT *FROM Adopters;

CREATE TABLE Adoptions (
    adoption_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_id INT ,
    adopter_id INT ,
    adoption_date DATE ,
    Foreign Key (pet_id) REFERENCES Pets(pet_id),
    Foreign Key (adopter_id) REFERENCES Adopters(adopter_id)
);
INSERT INTO Adoptions (pet_id,adopter_id,adoption_date)VALUES(2,1,'2024-11-13'),
(3,2,'2023-04-05'),
(1,3,'2022-03-10'),
(4,4,'2019-06-16');
SELECT*FROM Adoptions;
--------------------------------------Queries------------------------------------------

--List All Available Pets
SELECT pet_id,species,breed
FROM Pets
WHERE status ='Available';

-- Show Adopter Details Along with Their Adopted Pets
SELECT Adopters.first_name ,Adopters.last_name , Pets.pet_name, Pets.species,Adoptions.adoption_date
FROM Adoptions
JOIN Adopters ON Adoptions.adopter_id=Adopters.adopter_id
JOIN Pets ON Adoptions.pet_id=Pets.pet_id;
--Count the Total Number of Adopted Pets
SELECT COUNT(*) As total_adopted_pet
FROM Pets
WHERE status = 'Adopted';

-- Display All Adopters Who Haven’t Adopted Any Pet
SELECT Adopters.adopter_id ,Adopters.last_name, Adopters.contact_no
FROM Adopters
LEFT JOIN Adoptions ON Adopters.adopter_id=Adoptions.adopter_id
WHERE Adoptions.adoption_id IS NULL;

--Update the Status of a Pet After Adoption
UPDATE Pets
SET status ='Adopted'
WHERE pet_id=1;

--List All Pets Older Than 2 Years
SELECT pet_id, pet_name, species
FROM Pets
WHERE age > 3;

-- Find Pets Adopted in October 2024
SELECT Pets.pet_id, Pets.pet_name, Pets.species
FROM Adoptions
JOIN Pets ON Adoptions.pet_id=Pets.pet_id
WHERE MONTH(Adoptions.adoption_date) = 10 AND YEAR (Adoptions.adoption_date)= 2024;

--List Species and Count of Pets for Each Species
SELECT species, COUNT (*) AS pet_count
FROM Pets
GROUP BY species;

--Find the Latest Adoption
SELECT Pets.pet_name , Pets.species , Adoptions.adoption_date
FROM Adoptions
JOIN Pets ON Adoptions.pet_id = Pets.pet_id
ORDER BY Adoptions.adoption_date DESC 
LIMIT 3;
--Project 02