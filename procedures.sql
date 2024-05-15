-- Create procedure for adding a new team
-- Will need the following: location, name, and abbreviation
CREATE OR ALTER PROCEDURE dbo.AddTeam
 @Team_Location varchar(100)
,@Team_Name varchar(100)
,@Team_Abbreviation varchar(10)
,@OwnerId INTEGER
AS
BEGIN
INSERT INTO dbo.Teams (Team_Location, Team_Name, Team_Abbreviation, OwnerId)
VALUES (@Team_Location, @Team_Name, @Team_Abbreviation, @OwnerId)
END;

-- Create procedure for adding a new owner
-- Will need the following: first name, last name, and email
CREATE OR ALTER PROCEDURE dbo.AddOwner
 @Owner_FirstName varchar(100)
,@Owner_LastName varchar(100)
,@Owner_Email varchar(1000)
AS
BEGIN
INSERT INTO dbo.Owners (Owner_FirstName, Owner_LastName, Owner_Email)
VALUES (@Owner_FirstName, @Owner_LastName, @Owner_Email)
END;

-- Create procedure for adding a new contract
-- Will need the following: contract type, team that owns the contract, player who is the target of the contract, and the contract values for each year
CREATE OR ALTER PROCEDURE dbo.NewContract
 @ContractTypeId INTEGER
,@TeamId INTEGER
,@PlayerId INTEGER 
,@Year1Value DECIMAL(4,1)
,@Year2Value DECIMAL(4,1) = NULL
,@Year3Value DECIMAL(4,1) = NULL
,@Year4Value DECIMAL(4,1) = NULL
AS
BEGIN
INSERT INTO dbo.Contract (ContractTypeId, TeamId, PlayerId, Year1Value, Year2Value, Year3Value, Year4Value)
VALUES (@ContractTypeId, @TeamId, @PlayerId, @Year1Value, @Year2Value, @Year3Value, @Year4Value)
END;

-- Create procedure to import players from the stage table
CREATE OR ALTER PROCEDURE dbo.Import_Players
AS BEGIN
INSERT INTO dbo.Player (FirstName, LastName, Suffix, Position, NFLTeam)
SELECT
 x.FirstName
,x.LastName
,x.Suffix
,x.Position
,x.NFLTeam
FROM dbo.Player_Stage as x
WHERE NOT EXISTS (select 1 from dbo.Player as p
                 WHERE x.FirstName = p.FirstName
                 AND x.LastName = p.LastName
                 AND ISNULL(x.Suffix,'') = ISNULL(p.Suffix,'')
                 AND ISNULL(x.Position,'') = ISNULL(p.Position,'')
                 AND ISNULL(x.NFLTeam,'') = ISNULL(p.NFLTeam,'')
                 );
TRUNCATE TABLE dbo.Player_Stage;
END;
