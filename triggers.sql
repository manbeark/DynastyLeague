CREATE TRIGGER Teams_Update AFTER UPDATE ON dbo.Teams
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	
	UPDATE dbo.TeamsHist x
	SET x.ValidUntilDate = @UPDATETIME
	WHERE x.TeamId = OLD.TeamID
	AND x.ValidUntilDate IS NULL
	
	INSERT INTO dbo.TeamsHist (TeamId, Team_Location, Team_Name, Team_Abbreviation, OwnerId, ActionCode, ActionDate)
	SELECT
	NEW.TeamId
	,NEW.Team_Location
	,NEW.Team_Name
	,NEW.Team_Abbreviation
	,NEW.OwnerId
	,'u'
	,@UPDATETIME
END;
CREATE TRIGGER Teams_Insert AFTER INSERT ON dbo.Teams
FOR EACH ROW BEGIN
	INSERT INTO dbo.TeamsHist (TeamId, Team_Location, Team_Name, Team_Abbreviation, OwnerId, ActionCode, ActionDate)
	SELECT 
	NEW.TeamId
	,NEW.Team_Location
	,NEW.Team_Name
	,NEW.Team_Abbreviation
	,NEW.OwnerId
	,'i'
	,NOW()
END;
CREATE TRIGGER Teams_Delete AFTER DELETE ON dbo.Teams
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	
	UPDATE dbo.TeamsHist
	SET ValidUntilDate = @UPDATETIME
	WHERE TeamId = OLD.TeamId
	AND ValidUntilDate IS NULL

	INSERT INTO dbo.TeamsHist (TeamId, Team_Location, Team_Name, Team_Abbreviation, OwnerId, ActionCode, ActionDate)
	SELECT
	OLD.TeamId
	,OLD.Team_Location
	,OLD.Team_Name	
	,OLD.Team_Abbreviation
	,OLD.OwnerId
	,'d'
	,NOW()
END;

CREATE TRIGGER Owners_Update AFTER UPDATE ON dbo.Owners
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	
	UPDATE dbo.OwnersHist x
	SET x.ValidUntilDate = @UPDATETIME
	WHERE x.OwnerId = OLD.OwnerId
	AND x.ValidUntilDate IS NULL
	
	INSERT INTO dbo.OwnersHist (OwnerId, Owner_FirstName, Owner_LastName, Owner_Email, ActionCode, ActionDate)
	SELECT 
	NEW.OwnerId
	,NEW.Owner_FirstName
	,NEW.Owner_LastName
	,NEW.Owner_Email
	,'u'
	,@UPDATETIME
	
END;
CREATE TRIGGER Owners_Insert AFTER UPDATE ON dbo.Owners
FOR EACH ROW BEGIN
	INSERT INTO dbo.OwnersHist (OwnerId, Owner_FirstName, Owner_LastName, Owner_Email, ActionCode, ActionDate)
	SELECT 
	NEW.OwnerId
	,NEW.Owner_FirstName
	,NEW.Owner_LastName
	,NEW.Owner_Email
	,'i'
	,NOW()
END;

CREATE TRIGGER Owners_Delete AFTER DELETE ON dbo.Owners
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME datetime = NOW()
	
	UPDATE dbo.OwnersHist
	SET ValidUntilDate = @UPDATETIME
	WHERE OwnerId = OLD.OwnerId
	AND ValidUntilDate IS NULL

	INSERT INTO dbo.OwnersHist (OwnerId, Owner_FirstName, Owner_LastName, Owner_Email, ActionCode, ActionDate)
	SELECT
	OLD.OwnerId
	,OLD.Owner_FirstName
	,OLD.Owner_LastName
	,OLD.Owner_Email
	,'d'
	,@UPDATETIME
END;

CREATE TRIGGER ContractType_Insert AFTER INSERT ON dbo.ContractType
FOR EACH ROW BEGIN
	INSERT INTO ContractTypeHist (ContractTypeId, Title, Description, ActiveFlg, ActionCode, ActionDate)
	SELECT
	NEW.ContractTypeId
	,NEW.Title
	,NEW.Description
	,NEW.ActiveFlg
	,'i'
	,NOW()
END;

CREATE TRIGGER ContractType_Update AFTER UPDATE ON dbo.ContractType
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	
	UPDATE dbo.ContractTypeHist
	SET ValidUntilDate = @UPDATETIME
	WHERE ContractTypeId = OLD.ContractTypeId
	AND ValidUntilDate IS NULL
	
	INSERT INTO ContractTypeHist (ContractTypeId, Title, Description, ActiveFlg, ActionCode, ActionDate)
	SELECT
	NEW.ContractTypeId
	,NEW.Title
	,NEW.Description
	,NEW.ActiveFlg
	,'u'
	,@UPDATETIME
END;

CREATE TRIGGER ContractType_Delete AFTER DELETE ON dbo.ContractType
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	
	UPDATE dbo.ContractTypeHist
	SET ValidUntilDate = @UPDATETIME
	WHERE ContractTypeId = OLD.ContractTypeId
	AND ValidUntilDate IS NULL
	
	INSERT INTO ContractTypeHist (ContractTypeId, Title, Description, ActiveFlg, ActionCode, ActionDate)
	SELECT 
	OLD.ContractTypeId
	,OLD.Title
	,OLD.Description
	,OLD.ActiveFlg
	,'d'
	,@UPDATETIME
END;

CREATE TRIGGER Contract_Insert AFTER INSERT ON dbo.Contract
FOR EACH ROW BEGIN
	INSERT INTO dbo.ContractHist (ContractId, ContractTypeId, TeamId, PlayerId, Year1Value, Year2Value, Year3Value, Year4Value, ActionCode, ActionDate)
	SELECT
	NEW.ContractId
	,NEW.ContractTypeId
	,NEW.TeamId
	,NEW.PlayerId
	,NEW.Year1Value
	,NEW.Year2Value
	,NEW.Year3Value
	,NEW.Year4Value
	,'i'
	,NOW()
END;

CREATE TRIGGER Contract_Update AFTER UPDATE ON dbo.Contract
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	UPDATE dbo.ContractHist
	SET ValidUntilDate = @UPDATETIME
	WHERE ContractId = OLD.ContractId
	AND ValidUntilDate IS NULL
	
	INSERT INTO dbo.ContractHist (ContractId, ContractTypeId, TeamId, PlayerId, Year1Value, Year2Value, Year3Value, Year4Value, ActionCode, ActionDate)
	SELECT 
	NEW.ContractId
	,NEW.ContractTypeId
	,NEW.TeamId
	,NEW.PlayerId
	,NEW.Year1Value
	,NEW.Year2Value
	,NEW.Year3Value
	,NEW.Year4Value
	,'u'
	,@UPDATETIME
END;

CREATE TRIGGER Contract_Delete AFTER DELETE ON dbo.Contract
FOR EACH ROW BEGIN 
	DECLARE @UPDATETIME DATETIME = NOW()
	UPDATE dbo.ContractHist
	SET ValidUntilDate = @UPDATETIME
	WHERE ContractId = OLD.ContractId
	
	INSERT INTO dbo.ContractHist (ContractId, ContractTypeId, TeamId, PlayerId, Year1Value, Year2Value, Year3Value, Year4Value, ActionCode, ActionDate)
	SELECT 
	OLD.ContractId
	,OLD.ContractTypeId
	,OLD.TeamId
	,OLD.PlayerId
	,OLD.Year1Value
	,OLD.Year2Value
	,OLD.Year3Value
	,OLD.Year4Value
	,'d'
	,@UPDATETIME
END;

CREATE TRIGGER DraftPicks_Insert AFTER INSERT ON dbo.DraftPicks
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	INSERT INTO dbo.DraftPicksHist (DraftPickId, TeamId, Year, Round, Selection, PlayerId, ActionCode, ActionDate)
	SELECT
	 NEW.DraftPickId
	,NEW.TeamId
	,NEW.Year
	,NEW.Round
	,NEW.Selection
	,NEW.PlayerId
	,'i'
	,@UPDATETIME
END;

CREATE TRIGGER DraftPicks_Update AFTER UPDATE ON dbo.DraftPicks
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	UPDATE dbo.DraftPicksHist
	SET ValidUntilDate = @UPDATETIME
	WHERE DraftPickId = OLD.DraftPickId
	AND ValidUntilDate IS NULL
	
	INSERT INTO dbo.DraftPickHist (DraftPickId, TeamId, Year, Round, Selection, PlayerId, ActionCode, ActionDate)
	SELECT
	 NEW.DraftPickId
	,NEW.TeamId
	,NEW.Year
	,NEW.Round
	,NEW.Selection
	,NEW.PlayerId
	,'u'
	,@UPDATETIME
END;

CREATE TRIGGER DraftPicks_Delete AFTER DELETE ON dbo.DraftPicks
FOR EACH ROW BEGIN
	DECLARE @UPDATETIME DATETIME = NOW()
	UPDATE dbo.DraftPicksHist
	SET ValidUntilDate = @UPDATETIME
	WHERE DraftPickId = OLD.DraftPickId
	AND ValidUntilDate IS NULL
	
	INSERT INTO dbo.DraftPicksHist (DraftPickId, TeamId, Year, Round, Selection, PlayerId, ActionCode, ActionDate)
	SELECT
	 OLD.DraftPickId
	,OLD.TeamId
	,OLD.Year
	,OLD.Round
	,OLD.Selection
	,OLD.PlayerId
	,'d'
	,@UPDATETIME
END;
