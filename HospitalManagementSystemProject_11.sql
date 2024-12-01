DROP DATABASE Hospital_Management_System;

CREATE DATABASE IF NOT EXISTS hospital_management_system;
USE hospital_management_system;
-----------------------------PATIENT TABLE ---------------------------------------
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(80),
    last_name VARCHAR (80),
    contact_no VARCHAR(80),
    DOB DATE NOT NULL
);
INSERT INTO Patient (first_name,last_name,contact_no,DOB) VALUES
('Ali','Waseem','0310-7878077','2000-10-02'),
('Kiran','Fatima','0311-2022520','2002-11-03'),
('Farhan','Malik','0312-222-9090','1998-01-01'),
('Ahmad','Arham','0322-9085555','1999-08-04'),
('Sana','Maham','0333-7678080','2001-09-10'),
('Irum','Maryam','0342-9084040','2005-09-06'),
('Ahsan','Majeed','0321-9080444','2004-09-05'),
('Arina','Khan','0323-80844220','2005-08-10'),
('Momina','Majeed','0321-0558321','1990-05-16');
SELECT *FROM Patient;
-----------------------------DOCTOR TABLE ---------------------------------------
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(80) NOT NULL,
    description VARCHAR (80),
    contact_no VARCHAR(80)
);
INSERT INTO Doctors (doctor_name,description,contact_no)VALUES
('Dr Ahmar','Dermacologist','0310-9094041'),
('Dr Kazmi','Therapist','0322-6766032'),
('Dr Walid','Cardiologist','0333-8074047'),
('Dr Maria','Dental Surgen','03276472732'),
('Dr Mahnoor','Ginacologist','03256756279'),
('Dr Shazia','Alergyist','03028786032'),
('Dr Eman','Eye Specialist','03216769034'),
('Dr Qasim','ENT Specialist','03216805527');
SELECT *FROM Doctors;
-----------------------------APPOINTMENTS TABLE ---------------------------------------
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    reason VARCHAR(255),
    Foreign Key (patient_id) REFERENCES Patient(patient_id),
    Foreign Key (doctor_id) REFERENCES Doctors(doctor_id)
);
INSERT INTO Appointments (patient_id,doctor_id,appointment_date,reason)VALUES
(1,1,'2024-10-11','Routine Checkup'),
(2,2,'2024-12-10','Headache'),
(3,3,'2024-10-16','Eyesight Checkup'),
(4,4,'2024-08-12','Skin Checkup'),
(5,5,'2024-02-16','Heart Checkup');
SELECT*FROM Appointments;
-----------------------------Bills TABLE ---------------------------------------
CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT ,
    amount DECIMAL (10,4),
    bill_date DATE NOT NULL,
    Foreign Key (appointment_id) REFERENCES Appointments(appointment_id)
);
INSERT INTO Bills (appointment_id,amount,bill_date)VALUES
(1,380.00,'2024-10-10'),
(2,292.90,'2024-04-06'),
(3,980.50,'2024-09-16'),
(4,560.90,'2024-08-04'),
(5,704.60,'2024-09-24');
SELECT*FROM Bills;
-----------------------------PRACTICING QUERIES ---------------------------------------

--Fetch All Appointments with Patient and Doctor Details
SELECT Appointments.appointment_id ,
       Patient.first_name,
       Patient.last_name,
       Patient.contact_no,
       Doctors.doctor_name,
       Doctors.description,
       Appointments.appointment_date,
       Appointments.reason
         FROM Appointments
         JOIN Patient ON Appointments.patient_id = Patient.patient_id
         JOIN Doctors ON Appointments.doctor_id = Doctors.doctor_id;

--Generate Billing Details
SELECT 
    Bills.bill_id,
    Patient.first_name,
    Patient.last_name,
    Doctors.doctor_name,
    Bills.amount,
    Bills.bill_date
FROM 
    Bills
JOIN 
    Appointments ON Bills.appointment_id = Appointments.appointment_id
JOIN 
    Patient ON Appointments.patient_id = Patient.patient_id
JOIN 
    Doctors ON Appointments.doctor_id = Doctors.doctor_id;

--. List All Doctors with Number of Patients
SELECT Doctors.doctor_name ,
Doctors.description ,
COUNT(Appointments.patient_id) AS total_Patient
FROM Doctors
LEFT JOIN Appointments ON Appointments.doctor_id =Doctors.doctor_id 
GROUP BY Doctors.doctor_name , Doctors.description;

--Find All Appointments for a Specific Date

SELECT Patient.first_name, 
       Patient.last_name ,
       Appointments.appointment_id,
       Doctors.doctor_name,
       Appointments.reason
       FROM Appointments
       JOIN Patient ON Appointments.patient_id =Patient.patient_id
       JOIN Doctors ON Appointments.doctor_id = Doctors.doctor_id
       WHERE Appointments.appointment_date = '2024-10-16';

--Count the number of appointments for each doctor
SELECT 
      Doctors.doctor_name ,
      Doctors.description , 
      COUNT (Appointments.appointment_id) As total_appointment
 FROM Doctors 
 JOIN Appointments ON Appointments.doctor_id=Doctors.doctor_id
 GROUP BY Doctors.doctor_id;

--Get bills for a specific patient (e.g., patient_id = 1) 
SELECT  Bills.*
FROM Bills
JOIN Appointments ON Bills.appointment_id=Appointments.appointment_id
WHERE Appointments.patient_id=1;

--Get unpaid bills (appointments without bills)
SELECT Patient.first_name , 
       Patient.last_name , 
       Appointments.appointment_date
       FROM Patient
       JOIN Appointments ON Appointments.patient_id = Patient.patient_id
       LEFT JOIN Bills ON Appointments.appointment_id = Bills.appointment_id
       WHERE Bills.bill_id IS NULL;


