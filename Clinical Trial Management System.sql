CREATE DATABASE CTMS;
USE CTMS;
/*-- Patients Table */
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    ContactInformation VARCHAR(100)
);
INSERT INTO Patients VALUES 
    (1, 'Rahul', 'Kumar', '1990-05-15', 'Male', '+91 9969565212'),
    (2, 'Priya', 'Sharma', '1988-09-22', 'Female', '+91 7456128563'),
    (3, 'Amit', 'Patel', '1995-02-10', 'Male', '+91 8745631246');
    
SELECT * FROM Patients;    

/* -- Trials Table */
CREATE TABLE Trials (
    TrialID INT PRIMARY KEY,
    Title VARCHAR(100),
    Description TEXT,
    StartDate DATE,
    EndDate DATE
);

INSERT INTO Trials VALUES 
    (1233, 'Cardiovascular Study', 'Investigating heart-related issues', '2022-01-01', '2022-12-31'),
    (1234, 'Diabetes Intervention', 'Testing new diabetes treatments', '2022-03-01', '2023-02-28');
    
SELECT * FROM Trials;        

/* -- Sites Table */
CREATE TABLE Sites (
    SiteID INT PRIMARY KEY,
    SiteName VARCHAR(100),
    Location VARCHAR(100),
    PrincipalInvestigator VARCHAR(100),
    ContactInformation VARCHAR(100)
);

INSERT INTO Sites VALUES 
    (1, 'Apollo Hospitals', 'Delhi', 'Dr. Gupta', '9876543210'),
    (2, 'Fortis Hospital', 'Mumbai', 'Dr. Patel', '8765432109');
    
SELECT * FROM Sites;    

/* -- Enrollments Table */
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    TrialID INT,
    PatientID INT,
    SiteID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (TrialID) REFERENCES Trials(TrialID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (SiteID) REFERENCES Sites(SiteID)
);

INSERT INTO Enrollments VALUES 
    (1, 1, 1, 1, '2022-02-01'),
    (2, 2, 2, 2, '2022-04-01'),
    (3, 1, 3, 2, '2022-03-15');
    
SELECT * FROM Enrollments;    

/* -- Visits Table */
CREATE TABLE Visits (
    VisitID INT PRIMARY KEY,
    EnrollmentID INT,
    VisitDate DATE,
    VisitType VARCHAR(50),
    Results TEXT,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

INSERT INTO Visits VALUES 
    (1, 1, '2022-03-01', 'Regular Checkup', 'Normal'),
    (2, 2, '2022-05-01', 'Follow-up', 'Improved'),
    (3, 3, '2022-04-10', 'Diagnostic Test', 'Pending Results');
    
SELECT * FROM Visits;    

/* -- Retrieve enrolled patients in a specific trial */
SELECT Patients.FirstName, Patients.LastName
FROM Patients
JOIN Enrollments ON Patients.PatientID = Enrollments.PatientID
WHERE Enrollments.TrialID = 1;

/* -- Get details of all visits for a specific patient */
SELECT Patients.FirstName, Patients.LastName, Visits.VisitDate, Visits.VisitType, Visits.Results
FROM Patients
JOIN Enrollments ON Patients.PatientID = Enrollments.PatientID
JOIN Visits ON Enrollments.EnrollmentID = Visits.EnrollmentID
WHERE Patients.PatientID = 1;
    