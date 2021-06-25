-- =============================================
-- Description:	
-- counts number of jockey races
-- Query:
-- dbo.fn_JockeyRuns(rc.jockeyID, rc.RaceDate) AS JockeyRuns 
-- =============================================

CREATE FUNCTION [dbo].[fn_JockeyRuns](@JId BIGINT, @RDate date) RETURNS float
BEGIN

	DECLARE @retVal float;
	SELECT @retVal = COUNT(JockeyRuns) FROM (SELECT
	(SELECT COUNT(*) FROM RaceCard rc WHERE @JId = rc.jockeyID AND @RDate < @RDate)  AS JockeyRuns
	FROM RaceCard rc
	WHERE rc.jockeyID = @JId AND RaceDate < @RDate) B;
RETURN @retVal;
END

GO;
