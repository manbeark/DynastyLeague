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

CREATE OR ALTER PROCEDURE dbo.AddOwner
 @Owner_FirstName varchar(100)
,@Owner_LastName varchar(100)
,@Owner_Email varchar(1000)
AS
BEGIN
INSERT INTO dbo.Owners (Owner_FirstName, Owner_LastName, Owner_Email)
VALUES (@Owner_FirstName, @Owner_LastName, @Owner_Email)
END;

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
