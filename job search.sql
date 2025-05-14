-- Job Search Database Schema

-- TABLE: Company
-- Stores information about companies posting job listings.
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,         -- Unique company ID
    CompanyName VARCHAR(100) NOT NULL UNIQUE,         -- Company name (must be unique)
    Industry VARCHAR(50),                             -- Industry category
    Location VARCHAR(100)                             -- Company location
);

-- TABLE: Applicant
-- Stores job seekers’ personal information.
CREATE TABLE Applicant (
    ApplicantID INT PRIMARY KEY AUTO_INCREMENT,       -- Unique applicant ID
    FirstName VARCHAR(50) NOT NULL,                   -- First name
    LastName VARCHAR(50) NOT NULL,                    -- Last name
    Email VARCHAR(100) NOT NULL UNIQUE,               -- Unique email for contact/login
    Phone VARCHAR(20)                                 -- Contact phone number
);

-- TABLE: Job
-- Stores job listings posted by companies.
CREATE TABLE Job (
    JobID INT PRIMARY KEY AUTO_INCREMENT,             -- Unique job ID
    CompanyID INT NOT NULL,                           -- FK: Reference to the company
    JobTitle VARCHAR(100) NOT NULL,                   -- Job title
    JobDescription TEXT,                              -- Detailed job description
    Location VARCHAR(100),                            -- Job location
    PostedDate DATE DEFAULT current_timestamp,             -- Defaults to the current date
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

-- TABLE: Skill
-- Stores all available skills in the system.
CREATE TABLE Skill (
    SkillID INT PRIMARY KEY AUTO_INCREMENT,           -- Unique skill ID
    SkillName VARCHAR(50) NOT NULL UNIQUE             -- Skill name (must be unique)
);

-- TABLE: JobSkill
-- Many-to-Many relationship between Jobs and Skills.
-- Which skills are required for which jobs.
CREATE TABLE JobSkill (
    JobID INT,                                        -- FK: Job
    SkillID INT,                                      -- FK: Skill
    PRIMARY KEY (JobID, SkillID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID),
    FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

-- TABLE: ApplicantSkill
-- Many-to-Many relationship between Applicants and Skills.
-- Which skills each applicant possesses.
CREATE TABLE ApplicantSkill (
    ApplicantID INT,                                  -- FK: Applicant
    SkillID INT,                                      -- FK: Skill
    PRIMARY KEY (ApplicantID, SkillID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
    FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

-- TABLE: Application
-- Tracks applications submitted by applicants for jobs.
CREATE TABLE Application (
    ApplicationID INT PRIMARY KEY AUTO_INCREMENT,     -- PK:ApplicationID
    ApplicantID INT NOT NULL,                         -- FK: Applicant
    JobID INT NOT NULL,                               -- FK: Job
    ApplicationDate DATE DEFAULT current_timestamp,        -- When the application was submitted
    Status VARCHAR(30) DEFAULT 'Pending',             -- Application status: Pending/Accepted/Rejected
    FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID),
    UNIQUE (ApplicantID, JobID)                       -- Prevents duplicate applications to the same job
);
