CREATE TABLE dbo.Teams
(
 TeamId INTEGER PRIMARY KEY NOT NULL
,Team_Location varchar(100) NOT NULL
,Team_Name varchar(100) NOT NULL
,Team_Abbreviation varchar(10) NOT NULL
,OwnerId INTEGER
,FOREIGN KEY (OwnerId) REFERENCES dbo.Owners(OwnerId)
);

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

CREATE TABLE dbo.Owners
(
 OwnerId INTEGER PRIMARY KEY NOT NULL
,Owner_FirstName varchar(100) NOT NULL
,Owner_LastName varchar(100) NOT NULL
,Owner_Email varchar(1000) NOT NULL
,CONSTRAINT EmailAddress CHECK Owner_Email LIKE '%@%.%'
);

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

CREATE TABLE ContractType 
(
ContractTypeId INTEGER PRIMARY KEY NOT NULL
,Title varchar(100) NOT NULL
,Description varchar(1000) NOT NULL
,ActiveFlg bit DEFAULT 0 NOT NULL
);

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

CREATE TABLE dbo.Player 
(
 PlayerId INTEGER PRIMARY KEY NOT NULL
,FirstName varchar(100) NOT NULL
,LastName varchar(100) NOT NULL
,Suffix varchar(10)
,Position varchar(3) NOT NULL
,NFLTeam varchar(100)
);
