-- =============================================
-- Description:	

	/* 		returns the equivalent in Kilograms of a weight expressed as string of the form SS-PP
			where SS is stones and pp is pounds
	*/

-- Author:
-- developed by garciaRmarco@gmail.com
-- =============================================

CREATE FUNCTION [dbo].[fn_ConvertStringStonesAndPoundsToKGs](@intStr nvarchar(300)) RETURNS float
BEGIN



	declare @stones float = 0
	declare @pounds float = 0

	SET @intStr = rtrim(ltrim(lower(@intStr)))

	declare @dashIdx int = charindex('-',@intStr)
	if @dashIdx=0
		begin
			-- no - separating stones and pounds, assume the string only contains stones and no pounds at all
			set @stones = try_convert(float,@intStr)
			if @stones is null set @stones = 0;
		end
	else
		begin
			set @stones =  try_convert(float,substring(@intStr, 1, @dashIdx-1))
			if @stones is null set @stones = 0;
			set @pounds =  try_convert(float,substring(@intStr, @dashIdx+1, len(@intStr)))
			if @pounds is null set @pounds = 0;
		end

	return @stones *  6.35029 + @pounds * 0.4536
    
END;
GO

