-- =============================================
-- Description: 
-- calculates pounds from kilograms
-- =============================================
CREATE FUNCTION [dbo].[fn_ConvertKGsToLbs]
(
	@KGs float = 0

)
RETURNS float
AS
BEGIN
	RETURN @KGs * 2.20462
END;
GO
