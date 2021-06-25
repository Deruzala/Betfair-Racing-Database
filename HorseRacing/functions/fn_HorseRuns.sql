-- =============================================
-- Description:	
-- counts number of races a horse has run
-- Query:
-- dbo.fn_HorseRuns(rc.HorseID, rc.RaceDate) AS HorseRuns 
-- =============================================

CREATE FUNCTION [dbo].[fn_HorseRuns](@HId BIGINT, @RDate date) RETURNS float
BEGIN

	DECLARE @retVal float;
	SELECT @retVal = COUNT(HorseRuns) FROM (SELECT
	(SELECT COUNT(*) FROM RaceCard rc WHERE @HId = rc.horseID AND @RDate < @RDate)  AS HorseRuns
	FROM RaceCard rc
	WHERE rc.horseID = @HId AND RaceDate < @RDate) B;
RETURN @retVal;
END

GO;
