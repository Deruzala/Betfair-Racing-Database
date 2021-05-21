
CREATE FUNCTION [dbo].[fn_GetAvgTickDrop](@HId BIGINT, @RDate date) RETURNS float
BEGIN

	DECLARE @retVal float;
	SELECT @retVal = AVG(TickDrop) FROM (SELECT 
	(SELECT Tick FROM odds WHERE Price = (SELECT MAX(Price) FROM odds WHERE Price<=BFSP)) - 
	(SELECT Tick FROM odds WHERE Price = (SELECT MAX(Price) FROM odds WHERE Price<=IPMin))  AS TickDrop
	FROM RaceCard 
	WHERE horseID = @HId AND RaceDate < @RDate) B;
RETURN @retVal;
END;

GO
