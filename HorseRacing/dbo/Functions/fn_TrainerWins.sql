-- =============================================
-- Description:	
-- counts number of races a trainer has won
-- Query:
-- dbo.fn_TrainerWins(rc.outcomID, rc.trainerID, rc.RaceDate) AS TrainerWins 
-- =============================================

CREATE FUNCTION [dbo].[fn_TrainerWins](@OId INT, @TId BIGINT, @RDate date) RETURNS float
BEGIN
	DECLARE @retVal float;
	SELECT @retVal = COUNT(TrainerWins) FROM (SELECT
	(SELECT COUNT(*) FROM RaceCard rc WHERE rc.outcomeID = 1 AND @TId = rc.trainerID AND @RDate <= @RDate)  AS TrainerWins
	FROM RaceCard rc
	WHERE rc.outcomeID = 1 AND rc.trainerID = @TId AND rc.RaceDate <= @RDate) B;
RETURN @retVal;
END;
