-- =============================================
-- SmileClinic Full Database Setup Script
-- Run this ONCE in SQL Server Management Studio
-- =============================================

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'clinicdb')
BEGIN
    CREATE DATABASE clinicdb;
END
GO

USE clinicdb;
GO

-- Users table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
BEGIN
    CREATE TABLE Users (
        Id       INT IDENTITY(1,1) PRIMARY KEY,
        Name     NVARCHAR(100) NOT NULL,
        Email    NVARCHAR(100) NOT NULL UNIQUE,
        Password NVARCHAR(100) NOT NULL
    );
END
GO

-- Admins table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Admins' AND xtype='U')
BEGIN
    CREATE TABLE Admins (
        Id       INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(100) NOT NULL UNIQUE,
        Password NVARCHAR(100) NOT NULL
    );
END
GO

IF NOT EXISTS (SELECT * FROM Admins WHERE Username = 'admin')
BEGIN
    INSERT INTO Admins (Username, Password) VALUES ('admin', 'admin123');
END
GO

-- Appointments table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Appointments' AND xtype='U')
BEGIN
    CREATE TABLE Appointments (
        Id     INT IDENTITY(1,1) PRIMARY KEY,
        UserId INT NOT NULL,
        Doctor NVARCHAR(100) NOT NULL,
        Phone  NVARCHAR(20)  NOT NULL,
        Date   DATE          NOT NULL,
        Time   TIME          NOT NULL,
        Status NVARCHAR(20)  NOT NULL DEFAULT 'Pending',
        FOREIGN KEY (UserId) REFERENCES Users(Id)
    );
END
GO

-- ContactUs table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ContactUs' AND xtype='U')
BEGIN
    CREATE TABLE ContactUs (
        Id        INT IDENTITY(1,1) PRIMARY KEY,
        Fullname  NVARCHAR(100) NOT NULL,
        Email     NVARCHAR(100) NOT NULL,
        Message   NVARCHAR(MAX) NOT NULL,
        CreatedAt DATETIME      NOT NULL DEFAULT GETDATE()
    );
END
GO

-- Prescriptions table (NEW)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Prescriptions' AND xtype='U')
BEGIN
    CREATE TABLE Prescriptions (
        Id             INT IDENTITY(1,1) PRIMARY KEY,
        AppointmentId  INT NOT NULL,
        MedicationName NVARCHAR(200) NOT NULL,
        Dosage         NVARCHAR(300) NOT NULL DEFAULT '',
        IsDispensed    BIT NOT NULL DEFAULT 0,
        FOREIGN KEY (AppointmentId) REFERENCES Appointments(Id)
    );
END
GO

PRINT 'Database setup completed successfully!';
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TreatmentPlans' AND xtype='U')
BEGIN
    CREATE TABLE TreatmentPlans (
        Id             INT IDENTITY(1,1) PRIMARY KEY,
        AppointmentId  INT NOT NULL,
        Diagnosis      NVARCHAR(500) NOT NULL,
        TreatmentSteps NVARCHAR(MAX) NOT NULL,
        SessionsCount  INT NOT NULL,
        EstimatedCost  DECIMAL(10,2) NOT NULL,
        CreatedAt      DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (AppointmentId) REFERENCES Appointments(Id)
    );
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Doctors' AND xtype='U')
BEGIN
    CREATE TABLE Doctors (
        Id       INT IDENTITY(1,1) PRIMARY KEY,
        Name     NVARCHAR(100) NOT NULL UNIQUE,
        Password NVARCHAR(100) NOT NULL
    );
END
GO

-- إضافة دكاترة تجريبيين
IF NOT EXISTS (SELECT * FROM Doctors WHERE Name = 'Dr. Ahmad Khaled')
    INSERT INTO Doctors (Name, Password) VALUES ('Dr. Ahmad Khaled', 'doctor123');

IF NOT EXISTS (SELECT * FROM Doctors WHERE Name = 'Dr. Lina Mahmoud')
    INSERT INTO Doctors (Name, Password) VALUES ('Dr. Lina Mahmoud', 'doctor123');

IF NOT EXISTS (SELECT * FROM Doctors WHERE Name = 'Dr. Omar Al-Hassan')
    INSERT INTO Doctors (Name, Password) VALUES ('Dr. Omar Al-Hassan', 'doctor123');
GO