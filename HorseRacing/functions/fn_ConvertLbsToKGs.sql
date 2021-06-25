-- =============================================
-- Description: 
-- calculates kilograms from pounds
-- =============================================
CREATE FUNCTION [dbo].[fn_ConvertLbsToKGs]
(
	@Lbs float = 0

)
RETURNS float
AS
BEGIN
	RETURN @Lbs * 0.453592
END;
GO
