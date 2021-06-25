-- =============================================
-- Description:	
-- counts number of trainer races
-- Query:
-- dbo.fn_TrainerRuns(rc.trainerID, rc.RaceDate) AS TrainerRuns 
-- =============================================

CREATE FUNCTION [dbo].[fn_TrainerRuns](@TId BIGINT, @RDate date) RETURNS float
BEGIN

	DECLARE @retVal float;
	SELECT @retVal = COUNT(TrainerRuns) FROM (SELECT
	(SELECT COUNT(*) FROM RaceCard rc WHERE @TId = rc.trainerID AND @RDate < @RDate)  AS TrainerRuns
	FROM RaceCard rc
	WHERE rc.trainerID = @TId AND RaceDate < @RDate) B;
RETURN @retVal;
END

GO;
