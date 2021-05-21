
CREATE FUNCTION [dbo].[fn_ConvertDistanceStringToMeters](@distStr nvarchar(300)) RETURNS float
BEGIN

	/* 
		returns the equivalent in meters of a distance string expressed in miles and furlongs
		
	*/


	declare @miles float = 0
	declare @furlongs float = 0

	SET @distStr = lower(@distStr)
	
	declare @furlongStr varchar(399) = @distStr

	declare @idx int = charindex (N'm', @distStr)
	if @idx> 0
		begin
			declare @milesStr nvarchar(300) = substring(@DistStr, 1, @idx - 1)
			SET @miles = try_convert(float, @milesStr)
			SET @furlongStr =  substring(@DistStr, @idx + 1, len(@DistStr))
		end

	-- at this point @furlongStr contains an extraction of furlongs from @distStr 
	-- if @distStr also contained miles, it was removed otherwise it just has an untouched copy of @distStr

	set @idx = charindex (N'f', @distStr)
	if @idx> 0
		begin
			-- extract fraction indicator, if any
			declare @fract_idx int = charindex( N'½', lower(@furlongStr)) + charindex( N'¼', lower(@furlongStr)) + charindex( N'¾', lower(@furlongStr))
			if @fract_idx>0
				begin
					declare @fract_str varchar(300) = substring(@furlongStr,@fract_idx, 1)
					set  @furlongs = @furlongs +
						case 
							when @fract_str = N'¼' then 0.25
							when @fract_str = N'½' then 0.5
							when @fract_str = N'¾' then 0.75
							else 0
						end
					-- remove fraction from @furlongStr, leaving a string of the format '##f', where ## is an integer number
					-- of a string with only an f, meaning there's no integer part to the furloong expression
					set @furlongStr =  replace(replace(replace(@furlongStr, N'¼',''),N'½',''), N'¾', '')
				end
			if len(@furlongStr) > 1
				begin
					declare @int_furlongs float = try_convert(float, substring(@furlongStr, 1, charindex (N'f', @furlongStr)-1))
					if @int_furlongs is not null set @furlongs = @furlongs + @int_furlongs
				end
		end

	return @miles * 1609.34 + @furlongs * 201.168
    
END;
GO

