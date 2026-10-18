
-- Create the CRM database
CREATE DATABASE CRM_Database;
GO

USE CRM_Database;
GO

-- 1. Customers
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(150) NOT NULL,
    CustomerType VARCHAR(50) DEFAULT 'Individual',
    Phone VARCHAR(20),
    Email VARCHAR(150),
    Address VARCHAR(255),
    CreatedAt DATETIME2 DEFAULT SYSDATETIME()
);

-- 2. Contacts
CREATE TABLE Contacts (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    FirstName VARCHAR(75) NOT NULL,
    LastName VARCHAR(75) NOT NULL,
    JobTitle VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(150),
    CreatedAt DATETIME2 DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Contacts_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- 3. Leads
CREATE TABLE Leads (
    LeadID INT IDENTITY(1,1) PRIMARY KEY,
    ContactID INT NULL,
    LeadName VARCHAR(150) NOT NULL,
    CompanyName VARCHAR(150),
    Email VARCHAR(150),
    Phone VARCHAR(20),
    LeadSource VARCHAR(100),
    LeadStatus VARCHAR(30) NOT NULL DEFAULT 'New',
    CreatedAt DATETIME2 DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Leads_Contacts
        FOREIGN KEY (ContactID)
        REFERENCES Contacts(ContactID),

    CONSTRAINT CK_Leads_Status
        CHECK (LeadStatus IN (
            'New', 'Contacted', 'Qualified',
            'Unqualified', 'Converted'
        ))
);

-- 4. Opportunities
CREATE TABLE Opportunities (
    OpportunityID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ContactID INT NULL,
    OpportunityName VARCHAR(150) NOT NULL,
    Amount DECIMAL(12,2) DEFAULT 0,
    SalesStage VARCHAR(30) NOT NULL DEFAULT 'Prospecting',
    ExpectedCloseDate DATE,
    CreatedAt DATETIME2 DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Opportunities_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Opportunities_Contacts
        FOREIGN KEY (ContactID)
        REFERENCES Contacts(ContactID),

    CONSTRAINT CK_Opportunities_Amount
        CHECK (Amount >= 0),

    CONSTRAINT CK_Opportunities_Stage
        CHECK (SalesStage IN (
            'Prospecting', 'Qualification',
            'Proposal', 'Negotiation',
            'Won', 'Lost'
        ))
);

-- Indexes for common relationship lookups
CREATE INDEX IX_Contacts_CustomerID
    ON Contacts(CustomerID);

CREATE INDEX IX_Leads_ContactID
    ON Leads(ContactID);

CREATE INDEX IX_Opportunities_CustomerID
    ON Opportunities(CustomerID);

CREATE INDEX IX_Opportunities_ContactID
    ON Opportunities(ContactID);
