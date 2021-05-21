﻿/*
Deployment script for HorseRacing

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "HorseRacing"
:setvar DefaultFilePrefix "HorseRacing"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Altering [dbo].[fn_GetAvgTickDrop]...';


GO

ALTER FUNCTION [dbo].[fn_GetAvgTickDrop](@HId BIGINT, @RDate date) RETURNS float
BEGIN

	DECLARE @retVal float;
	SELECT @retVal = AVG(TickDrop) FROM (SELECT 
	(SELECT Tick FROM tick_equivalence WHERE Price = (SELECT MAX(Price) FROM tick_equivalence WHERE Price<=BFSP)) - 
	(SELECT Tick FROM tick_equivalence WHERE Price = (SELECT MAX(Price) FROM tick_equivalence WHERE Price<=IPMin))  AS TickDrop
	FROM RaceCard 
	WHERE horseID = @HId AND RaceDate < @RDate) B;
RETURN @retVal;
END;
GO
PRINT N'Altering [dbo].[fn_WinningDistanceStringToMeters]...';


GO
ALTER FUNCTION [dbo].[fn_WinningDistanceStringToMeters](@intStr varchar(10)) 
RETURNS float
BEGIN

	/* 
		returns the equivalent in meters of a winning distance expressed in heads, body lengths, etc.
		
	*/

	if @intStr is null
		return null

	declare @meters float = null
	declare @winDistStr varchar(19) = rtrim(ltrim(lower(@intStr)))

	-- remove any values values in parenthesis - they are notes
	declare @openParenthesis int = charindex('(',@winDistStr)
	declare @closeParenthesis int = charindex(')',@winDistStr)
	if @openParenthesis>0 and @closeParenthesis>0
	set @winDistStr = left(@winDistStr, @openParenthesis-1) + substring(@winDistStr, @closeParenthesis+1, len(@winDistStr))
	if @winDistStr in ('dht', 'hd', 'nk', 'nse', 'shd', 'sht-hd', 'snk' )
		-- distance in expressed as horse length 
		set @meters = case @winDistStr
							when 'dht' then 0           -- dead heat
							when'hd'then  0.40			-- head
							when 'nk'then 0.72			-- neck
							when 'nse' then 0.12		-- nose
							when 'shd'then  0.24		-- short head
							when 'sht-hd' then 0.24		-- short head
							when 'snk' then 0.54		-- short neck
						end		
	else
		begin
			-- distance expressed in horse-length (a horse length=2.4 m). May have fractional parts to it (such as ½, etc)
			declare @fract_idx int = charindex(N'½', @winDistStr) + charindex(N'¼', @winDistStr) + charindex(N'¾', @winDistStr)
			if @fract_idx=0
				set @meters = 0
			else
				begin
					set @meters =  case 
										when substring(@winDistStr,@fract_idx, 1)= N'½' then 0.5
										when substring(@winDistStr,@fract_idx, 1)= N'¼' then 0.25
										when substring(@winDistStr,@fract_idx, 1)= N'¾' then 0.75
										else 0
									end
					set @winDistStr = left(@winDistStr,@fract_idx-1) 
				end
			declare @horses int = try_convert(int,@winDistStr)
			if @horses is not null
					set @meters = (@meters + abs(@horses)) * 2.4
		end	
			
	return @meters
	
END
GO
PRINT N'Update complete.';


GO