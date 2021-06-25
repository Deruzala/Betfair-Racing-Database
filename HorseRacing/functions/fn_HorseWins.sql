-- =============================================
-- Description:	
-- counts number of races a horse has won
-- Query:
-- dbo.fn_HorseWins(rc.outcomID, rc.horseID, rc.RaceDate) AS HorseWins 
-- =============================================

CREATE FUNCTION [dbo].[fn_HorseWins](@OId INT, @HId BIGINT, @RDate date) RETURNS float
BEGIN
	DECLARE @retVal float;
	SELECT @retVal = COUNT(HorseWins) FROM (SELECT
	(SELECT COUNT(*) FROM RaceCard rc WHERE rc.outcomeID = 1 AND @HId = rc.horseID AND @RDate <= @RDate)  AS HorseWins
	FROM RaceCard rc
	WHERE rc.outcomeID = 1 AND rc.horseID = @HId AND rc.RaceDate <= @RDate) B;
RETURN @retVal;
END;
