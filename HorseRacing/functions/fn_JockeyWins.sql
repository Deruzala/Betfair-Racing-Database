-- =============================================
-- Description:	
-- counts number of races a jockey has won
-- Query:
-- dbo.fn_JockeyWins(rc.outcomID, rc.jockeyID, rc.RaceDate) AS JockeyWins 
-- =============================================

CREATE FUNCTION [dbo].[fn_JockeyWins](@OId INT, @JId BIGINT, @RDate date) RETURNS float
BEGIN
	DECLARE @retVal float;
	SELECT @retVal = COUNT(JockeyWins) FROM (SELECT
	(SELECT COUNT(*) FROM RaceCard rc WHERE rc.outcomeID = 1 AND @JId = rc.jockeyID AND @RDate <= @RDate)  AS JockeyWins
	FROM RaceCard rc
	WHERE rc.outcomeID = 1 AND rc.jockeyID = @JId AND rc.RaceDate <= @RDate) B;
RETURN @retVal;
END;
