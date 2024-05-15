-- Create teams table. 
-- Each team is required to have a location, name, and abbreviation. 
-- The owner of the team has a foreign key relationship to the owners table.

CREATE TABLE dbo.Teams
(
 TeamId INTEGER PRIMARY KEY NOT NULL
,Team_Location varchar(100) NOT NULL
,Team_Name varchar(100) NOT NULL
,Team_Abbreviation varchar(10) NOT NULL
,OwnerId INTEGER
,FOREIGN KEY (OwnerId) REFERENCES dbo.Owners(OwnerId)
);

-- Create team history table
-- This will store all actions on the teams table. 
-- Each action is accompanied with an ActionDate and ValidUntilDate
-- This is to allow the user to view what the table looked like at any given point in time. 
-- This is recurring pattern for each history table and will not be mentioned again. 

CREATE TABLE dbo.TeamsHist
(
 TeamHistId INTEGER PRIMARY KEY NOT NULL
 ,TeamId INTEGER NOT NULL
 ,Team_Location varchar(100) NOT NULL
 ,Team_Name varchar(100) NOT NULL
 ,Team_Abbreviation varchar(10) NOT NULL
 ,OwnerId INTEGER
 ,ActionCode varchar(1) NOT NULL
 ,ActionDate datetime NOT NULL
 ,ValidUntilDate datetime
);

-- Create owners table. 
-- Each owner is required to have a first name, last name, and email address. 
-- There is a constraint on the email address to force the value to at least appear to be an email address.

CREATE TABLE dbo.Owners
(
 OwnerId INTEGER PRIMARY KEY NOT NULL
,Owner_FirstName varchar(100) NOT NULL
,Owner_LastName varchar(100) NOT NULL
,Owner_Email varchar(1000) NOT NULL
,CONSTRAINT EmailAddress CHECK Owner_Email LIKE '%@%.%'
);

-- Create owner history table

CREATE TABLE dbo.OwnersHist
(
 OwnersHistId INTEGER PRIMARY KEY NOT NULL
,OwnerId INTEGER NOT NULL
,Owner_FirstName varchar(100) NOT NULL
,Owner_LastName varchar(100) NOT NULL
,Owner_Email varchar(100) NOT NULL
,ActionCode VARCHAR(1) NOT NULL
,ActionDate DATETIME NOT NULL
,ValidUntilDate DATETIME
);

-- Create contract type table
-- This will be a relatively static table unless new contract types are introduced by the league.
-- Each contract type needs a title, description, and will default to inactive unless otherwise marked. 

CREATE TABLE ContractType 
(
ContractTypeId INTEGER PRIMARY KEY NOT NULL
,Title varchar(100) NOT NULL
,Description varchar(1000) NOT NULL
,ActiveFlg bit DEFAULT 0 NOT NULL
);

-- Create contract type history table

CREATE TABLE ContractTypeHist
(
ContractTypeHistId INTEGER PRIMARY KEY NOT NULL
,ContractTypeId INTEGER NOT NULL
,Title varchar(100) NOT NULL
,Description varchar(1000) NOT NULL
,ActiveFlg bit DEFAULT 0 NOT NULL
,ActionCode VARCHAR(1) NOT NULL
,ActionDate DATETIME NOT NULL
,ValidUntilDate DATETIME
);

-- Create contract table
-- This table houses all the contracts for the league.
-- Each contract needs a contract type, the team that owns it, the player who is the target of the contract, and at least a year 1 value.
-- Contracts are limited to 0.5 increments for the values in a given year.
-- Contracts have foreign key relationships to the teams, contract type, and player tables. 

CREATE TABLE dbo.Contract
(
ContractId INTEGER PRIMARY KEY NOT NULL
,ContractTypeId INTEGER NOT NULL
,TeamId INTEGER NOT NULL
,PlayerId INTEGER NOT NULL 
,Year1Value DECIMAL(4,1) NOT NULL
,Year2Value DECIMAL(4,1)
,Year3Value DECIMAL(4,1)
,Year4Value DECIMAL(4,1)
,FOREIGN KEY (TeamId) REFERENCES dbo.Teams(TeamId)
,FOREIGN KEY (ContractTypeId) REFERENCES dbo.ContractType(ContractTypeId)
,FOREIGN KEY (PlayerId) REFERENCES dbo.Players(PlayerId)
,CONSTRAINT Year1Value CHECK (Year1Value - ROUND(Year1Value) = 0.5 OR Year1Value - ROUND(Year1Value) = 0)
,CONSTRAINT Year2Value CHECK (Year2Value - ROUND(Year2Value) = 0.5 OR Year2Value - ROUND(Year2Value) = 0)
,CONSTRAINT Year3Value CHECK (Year3Value - ROUND(Year3Value) = 0.5 OR Year3Value - ROUND(Year3Value) = 0)
,CONSTRAINT Year4Value CHECK (Year4Value - ROUND(Year4Value) = 0.5 OR Year4Value - ROUND(Year4Value) = 0)
)

-- Create contract history table.
-- This table is especially important because it allows us to view what teams look like week to week. 
 
CREATE TABLE dbo.ContractHist 
(
ContractHistId INTEGER PRIMARY KEY NOT NULL
,ContractId INTEGER NOT NULL
,ContractTypeId INTEGER NOT NULL
,TeamId INTEGER NOT NULL
,PlayerId INTEGER NOT NULL
,Year1Value DECIMAL(4,1) NOT NULL
,Year2Value DECIMAL(4,1)
,Year3Value DECIMAL(4,1)
,Year4Value DECIMAL(4,1)
,ActionCode varchar(1) NOT NULL
,ActionDate DATETIME NOT NULL
,ValidUntilDate DATETIME
);

-- Create draft picks table.
-- This table houses the rookie draft picks. 
-- Draft picks are required to have a team, a year, and a round.
-- To allow picks to exist for the future, exact overall draft numbers are not required.
-- In addition, players are not required for the same reason. 
-- Draft picks have foreign key relationships to the teams and player tables. 

CREATE TABLE dbo.DraftPicks
(
DraftPickId INTEGER PRIMARY KEY NOT NULL
,TeamId INTEGER NOT NULL
,Year INTEGER NOT NULL
,Round INTEGER NOT NULL
,Selection INTEGER
,PlayerId INTEGER
,FOREIGN KEY (TeamId) REFERENCES dbo.Teams(TeamId)
,FOREIGN KEY (PlayerId) REFERENCES dbo.Player(PlayerId)
,CONSTRAINT Round CHECK (Round <= 3 AND Round >= 1)
,CONSTRAINT Selection CHECK (Selection <= 12 AND Selection >= 1)
);

-- Create draft pick history table.
-- This table allows us to view who owned what draft picks over time. 

CREATE TABLE dbo.DraftPicksHist
(
 DraftPicksHistId INTEGER PRIMARY KEY NOT NULL
,DraftPickId INTEGER NOT NULL
,TeamId INTEGER NOT NULL
,Year INTEGER NOT NULL
,Round INTEGER NOT NULL
,Selection INTEGER
,PlayerId INTEGER
,ActionCode	VARCHAR(1) NOT NULL
,ActionDate DATETIME NOT NULL
,ValidUntilDate DATETIME 
);

-- Create Player table. 
-- This table houses the players themselves. 
-- In the future, columns will be added for ID numbers from various data sources, such as ESPN and Sleeper. 

CREATE TABLE dbo.Player 
(
 PlayerId INTEGER PRIMARY KEY NOT NULL
,FirstName varchar(100) NOT NULL
,LastName varchar(100) NOT NULL
,Suffix varchar(10)
,Position varchar(3) NOT NULL
,NFLTeam varchar(100)
);

-- Create player staging table 
-- When a list of players is imported, it sits in this table before being imported to the main table
-- De-duplication will occur before players are inserted into the main table.
CREATE TABLE dbo.Player_Stage
(
 FirstName varchar(100) NOT NULL
,LastName varchar(100) NOT NULL
,Suffix varchar(10) 
,Position varchar(3) NOT NULL
,NFLTeam varchar(100)
 );
