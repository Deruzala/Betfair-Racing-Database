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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE Latin1_General_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

SET IDENTITY_INSERT [dbo].[bid] ON
INSERT INTO [dbo].[bid] ([ID], [Name]) VALUES (1, N'back')
INSERT INTO [dbo].[bid] ([ID], [Name]) VALUES (2, N'lay')
SET IDENTITY_INSERT [dbo].[bid] OFF
GO

GO
PRINT N'Creating [dbo].[bid]...';


GO
CREATE TABLE [dbo].[bid] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_bid_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_bid_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[country]...';


GO
CREATE TABLE [dbo].[country] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_country_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_country_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[course]...';


GO
CREATE TABLE [dbo].[course] (
    [ID]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name]          VARCHAR (200) NOT NULL,
    [BFEquivalence] VARCHAR (200) NULL,
    CONSTRAINT [PK_course_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_course_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[distance]...';


GO
CREATE TABLE [dbo].[distance] (
    [ID]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (200) NOT NULL,
    [Meters]   REAL          NULL,
    [Furlongs] REAL          NULL,
    CONSTRAINT [PK_distance_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_distance_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[going]...';


GO
CREATE TABLE [dbo].[going] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_going_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_going_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[headgear]...';


GO
CREATE TABLE [dbo].[headgear] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_headgear_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_headgear_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[horse]...';


GO
CREATE TABLE [dbo].[horse] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (200) NOT NULL,
    [SelectionID] BIGINT        NULL,
    CONSTRAINT [PK_horse_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_Horse_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[jockey]...';


GO
CREATE TABLE [dbo].[jockey] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_jockey_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_Jockey_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[OtherPlace]...';


GO
CREATE TABLE [dbo].[OtherPlace] (
    [ID]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [RaceDate]     DATETIME2 (0) NOT NULL,
    [horseID]      BIGINT        NOT NULL,
    [OPPrice05Min] REAL          NOT NULL,
    [OPPrice04Min] REAL          NOT NULL,
    [OPPrice03Min] REAL          NOT NULL,
    [OPPrice02Min] REAL          NOT NULL,
    [OPPrice01Min] REAL          NOT NULL,
    [OPBFSP]       REAL          NOT NULL,
    [OPlaces]      INT           NOT NULL,
    [OPResult]     INT           NOT NULL,
    [OPMarketId]   VARCHAR (50)  NOT NULL,
    [OPEventId]    BIGINT        NOT NULL,
    [OPRaceCardId] BIGINT        NOT NULL,
    CONSTRAINT [PK_OtherPlace_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_OtherPlace] UNIQUE NONCLUSTERED ([RaceDate] ASC, [horseID] ASC)
);


GO
PRINT N'Creating [dbo].[outcome]...';


GO
CREATE TABLE [dbo].[outcome] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_outcome_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_outcome_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[PlacePrice]...';


GO
CREATE TABLE [dbo].[PlacePrice] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [RaceDate]    DATETIME2 (0) NOT NULL,
    [horseID]     BIGINT        NOT NULL,
    [PPrice05Min] REAL          NOT NULL,
    [PPrice04Min] REAL          NOT NULL,
    [PPrice03Min] REAL          NOT NULL,
    [PPrice02Min] REAL          NOT NULL,
    [PPrice01Min] REAL          NOT NULL,
    [PBFSP]       REAL          NOT NULL,
    [Places]      INT           NOT NULL,
    [PResult]     INT           NOT NULL,
    [PMarketId]   VARCHAR (50)  NOT NULL,
    [PEventId]    BIGINT        NOT NULL,
    [PRaceCardId] BIGINT        NOT NULL,
    CONSTRAINT [PK_PlacePrice_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_PlacePrice] UNIQUE NONCLUSTERED ([RaceDate] ASC, [horseID] ASC)
);


GO
PRINT N'Creating [dbo].[RaceCard]...';


GO
CREATE TABLE [dbo].[RaceCard] (
    [ID]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [RaceDate]     DATETIME2 (0) NOT NULL,
    [countryID]    BIGINT        NOT NULL,
    [courseID]     BIGINT        NOT NULL,
    [goingID]      BIGINT        NOT NULL,
    [distanceID]   BIGINT        NOT NULL,
    [racetypeID]   BIGINT        NOT NULL,
    [horseID]      BIGINT        NOT NULL,
    [jockeyID]     BIGINT        NOT NULL,
    [trainerID]    BIGINT        NOT NULL,
    [headGearID]   BIGINT        NULL,
    [Price09am]    REAL          NULL,
    [Price10am]    REAL          NULL,
    [Price11am]    REAL          NULL,
    [Price60Min]   REAL          NULL,
    [Price30Min]   REAL          NULL,
    [Price15Min]   REAL          NULL,
    [Price05Min]   REAL          NULL,
    [Price04Min]   REAL          NULL,
    [Price03Min]   REAL          NULL,
    [Price02Min]   REAL          NULL,
    [Price01Min]   REAL          NULL,
    [BFSP]         REAL          NULL,
    [runners]      INT           NOT NULL,
    [active]       INT           NOT NULL,
    [activeStatus] INT           NOT NULL,
    [sortPriority] INT           NOT NULL,
    [PreMin]       REAL          NOT NULL,
    [PreMax]       REAL          NOT NULL,
    [IPMin]        REAL          NOT NULL,
    [IPMax]        REAL          NOT NULL,
    [PPvol]        FLOAT (50)    NOT NULL,
    [IPvol]        FLOAT (50)    NOT NULL,
    [MarketId]     VARCHAR (50)  NOT NULL,
    [EventId]      BIGINT        NOT NULL,
    CONSTRAINT [PK_RaceCard_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[racetype]...';


GO
CREATE TABLE [dbo].[racetype] (
    [ID]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name]          VARCHAR (200) NOT NULL,
    [BFequivelance] VARCHAR (200) NULL,
    CONSTRAINT [PK_racetype_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_racetype_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[Records]...';


GO
CREATE TABLE [dbo].[Records] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [systemID]    BIGINT        NOT NULL,
    [RaceDate]    DATETIME2 (0) NOT NULL,
    [marketOpen]  DATETIME2 (3) NOT NULL,
    [selectionID] BIGINT        NOT NULL,
    [bidPlaced]   DATETIME2 (3) NOT NULL,
    [BetId]       BIGINT        NOT NULL,
    [bidID]       BIGINT        NOT NULL,
    [stake]       REAL          NOT NULL,
    [price]       REAL          NOT NULL,
    [outcomeID]   BIGINT        NOT NULL,
    [pnl]         REAL          NOT NULL,
    [netpnl]      REAL          NOT NULL,
    [EventId]     BIGINT        NOT NULL,
    [MarketId]    BIGINT        NOT NULL,
    [RRaceCardId] BIGINT        NOT NULL,
    CONSTRAINT [PK_Records_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_Records] UNIQUE NONCLUSTERED ([systemID] ASC, [MarketId] ASC, [selectionID] ASC)
);


GO
PRINT N'Creating [dbo].[system]...';


GO
CREATE TABLE [dbo].[system] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_system_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_system_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[tick_equivalence]...';


GO
CREATE TABLE [dbo].[tick_equivalence] (
    [ID]      BIGINT IDENTITY (1, 1) NOT NULL,
    [Price]   REAL   NOT NULL,
    [Tick]    INT    NOT NULL,
    [Percent] REAL   NOT NULL,
    CONSTRAINT [PK_tick_equivalence_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[trainer]...';


GO
CREATE TABLE [dbo].[trainer] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [ix_trainer_Name] UNIQUE NONCLUSTERED ([Name] ASC),
    CONSTRAINT [trainerID] UNIQUE NONCLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[DF__distance__Meters__25869641]...';


GO
ALTER TABLE [dbo].[distance]
    ADD CONSTRAINT [DF__distance__Meters__25869641] DEFAULT (NULL) FOR [Meters];


GO
PRINT N'Creating [dbo].[DF__distance__Furlon__267ABA7A]...';


GO
ALTER TABLE [dbo].[distance]
    ADD CONSTRAINT [DF__distance__Furlon__267ABA7A] DEFAULT (NULL) FOR [Furlongs];


GO
PRINT N'Creating [dbo].[FK_OtherPlace_Racecard]...';


GO
ALTER TABLE [dbo].[OtherPlace]
    ADD CONSTRAINT [FK_OtherPlace_Racecard] FOREIGN KEY ([OPRaceCardId]) REFERENCES [dbo].[RaceCard] ([ID]);


GO
PRINT N'Creating [dbo].[FK_PlacePrice_RaceCard]...';


GO
ALTER TABLE [dbo].[PlacePrice]
    ADD CONSTRAINT [FK_PlacePrice_RaceCard] FOREIGN KEY ([PRaceCardId]) REFERENCES [dbo].[RaceCard] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_country]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_country] FOREIGN KEY ([countryID]) REFERENCES [dbo].[country] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_course]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_course] FOREIGN KEY ([courseID]) REFERENCES [dbo].[course] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_distance]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_distance] FOREIGN KEY ([distanceID]) REFERENCES [dbo].[distance] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_going]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_going] FOREIGN KEY ([goingID]) REFERENCES [dbo].[going] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_headgear]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_headgear] FOREIGN KEY ([headGearID]) REFERENCES [dbo].[headgear] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_horse]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_horse] FOREIGN KEY ([horseID]) REFERENCES [dbo].[horse] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_jockey]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_jockey] FOREIGN KEY ([jockeyID]) REFERENCES [dbo].[jockey] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_trainer]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_trainer] FOREIGN KEY ([trainerID]) REFERENCES [dbo].[trainer] ([ID]);


GO
PRINT N'Creating [dbo].[FK_RaceCard_racetype]...';


GO
ALTER TABLE [dbo].[RaceCard]
    ADD CONSTRAINT [FK_RaceCard_racetype] FOREIGN KEY ([racetypeID]) REFERENCES [dbo].[racetype] ([ID]);


GO
PRINT N'Creating [dbo].[FK_Records_bid]...';


GO
ALTER TABLE [dbo].[Records]
    ADD CONSTRAINT [FK_Records_bid] FOREIGN KEY ([bidID]) REFERENCES [dbo].[bid] ([ID]);


GO
PRINT N'Creating [dbo].[FK_Records_outcome]...';


GO
ALTER TABLE [dbo].[Records]
    ADD CONSTRAINT [FK_Records_outcome] FOREIGN KEY ([outcomeID]) REFERENCES [dbo].[outcome] ([ID]);


GO
PRINT N'Creating [dbo].[FK_Records_Racecard]...';


GO
ALTER TABLE [dbo].[Records]
    ADD CONSTRAINT [FK_Records_Racecard] FOREIGN KEY ([RRaceCardId]) REFERENCES [dbo].[RaceCard] ([ID]);


GO
PRINT N'Creating [dbo].[FK_Records_system]...';


GO
ALTER TABLE [dbo].[Records]
    ADD CONSTRAINT [FK_Records_system] FOREIGN KEY ([systemID]) REFERENCES [dbo].[system] ([ID]);


GO
PRINT N'Creating [dbo].[Place-view]...';


GO
CREATE VIEW [dbo].[Place-view]
AS 

SELECT 

    rc.RaceDate, 
    c.name AS course,
    h.name AS horse,
    p.PPrice05Min

FROM RaceCard rc 
JOIN PlacePrice p
ON rc.ID=p.ID

LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID
GO
PRINT N'Creating [dbo].[fn_ConvertDistanceStringToMeters]...';


GO

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
PRINT N'Creating [dbo].[fn_ConvertStonesAndPoundsStringToKgs]...';


GO
CREATE FUNCTION [dbo].[fn_ConvertStonesAndPoundsStringToKgs](@intStr nvarchar(300)) RETURNS float
BEGIN

	/* 
		returns the equivalent in Kilograms of a weight expressed as string of the form SS-PP
		where SS is stones and pp is pounds
	
	*/


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
PRINT N'Creating [dbo].[fn_GetAvgTickDrop]...';


GO

CREATE FUNCTION [dbo].[fn_GetAvgTickDrop](@HId BIGINT, @RDate date) RETURNS float
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
PRINT N'Creating [dbo].[fn_WinningDistanceStringToMeters]...';


GO
CREATE FUNCTION [dbo].[fn_WinningDistanceStringToMeters](@intStr varchar(10)) 
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
PRINT N'Creating [dbo].[TR_INSTEADOFINSERT_distance]...';


GO
CREATE TRIGGER [dbo].[TR_INSTEADOFINSERT_distance]
   ON [dbo].[distance]
    INSTEAD OF INSERT
   AS 
      BEGIN

         SET  NOCOUNT  ON

		-- do some basic error checking
		 if (SELECT COUNT(*) FROM Inserted WHERE Name='' OR Name IS NULL)>0
			begin
				raiserror('Name cannot be empty or null', 16, 1)
				return
			end
		
		 -- create a temporary table to hold values that do not have meters and furlongs
		 select * into #CalculatedInserts
		 from inserted

		 -- if Meters is not provided in the insertion, we calculate the value
		 UPDATE #CalculatedInserts
			SET Meters = dbo.fn_ConvertDistanceStringToMeters(Name)
		 WHERE Meters IS NULL

		 -- if Furlongs is not provided in the insertion, we calculate the value
		 UPDATE #CalculatedInserts
			SET Furlongs = Meters * 0.00497096
		 WHERE Furlongs IS NULL
		 
		 -- request the insertion 
		 INSERT INTO dbo.distance
			SELECT  Name, Meters, Furlongs FROM #CalculatedInserts

      END
GO
PRINT N'Creating [dbo].[TR_INSTEADOFUPDATE_distance]...';


GO
CREATE TRIGGER [dbo].[TR_INSTEADOFUPDATE_distance]
   ON [dbo].[distance]
    INSTEAD OF UPDATE
   AS 
      BEGIN
		
        SET  NOCOUNT  ON

	    -- do some basic error checking
		if (SELECT COUNT(*) FROM Inserted WHERE Name='' OR Name IS NULL)>0
		begin
			raiserror('Name cannot be empty or null', 16, 1)
			return
		end

		-- create a temporary table to hold values, we may modify this table
		-- with calculated meters and furlongs and it'll be the tables inserts come from
		select * into #CalculatedInserts
		from inserted

		--select * from #CalculatedInserts
		--select * from deleted


		if update(Name)
			begin

					-- if Meters is not provided in the insertion, we calculate the value
					UPDATE #CalculatedInserts
						SET #CalculatedInserts.Meters = dbo.fn_ConvertDistanceStringToMeters(#CalculatedInserts.Name)
					FROM #CalculatedInserts INNER JOIN Deleted ON #CalculatedInserts.Id = Deleted.Id
					WHERE #CalculatedInserts.Name <> Deleted.Name

					-- select * from #CalculatedInserts

					-- if Furlongs is not provided in the insertion, we calculate the value
					UPDATE #CalculatedInserts
						SET #CalculatedInserts.Furlongs = #CalculatedInserts.Meters * 0.00497096
					FROM #CalculatedInserts INNER JOIN Deleted ON #CalculatedInserts.Id = Deleted.Id
					WHERE #CalculatedInserts.Name <> Deleted.Name

					-- select * from #CalculatedInserts

			end
		
		-- request the update 
		update dbo.distance SET 
			Name = I.Name,
			Meters = I.Meters,
			Furlongs = I.Furlongs
		from dbo.distance M
			inner join #CalculatedInserts I on I.Id = M.Id

      END
GO
PRINT N'Creating [dbo].[RaceCard-view]...';


GO
CREATE VIEW [dbo].[RaceCard-view]
AS
SELECT 

    rc.RaceDate, 
    c.name AS course,
    h.name AS horse,
    FORMAT(dbo.fn_GetAvgTickDrop(rc.horseID, rc.RaceDate),'0.00') AS AvgTickDrop

FROM RaceCard rc 
LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID
GO
PRINT N'Creating [dbo].[distance].[MS_SSMA_SOURCE]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'HorseRacing.`distance`', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'distance';


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

SET IDENTITY_INSERT [dbo].[country] ON
INSERT INTO [dbo].[country] ([ID], [Name]) VALUES (1, N'GB')
INSERT INTO [dbo].[country] ([ID], [Name]) VALUES (2, N'IE')
SET IDENTITY_INSERT [dbo].[country] OFF



GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
