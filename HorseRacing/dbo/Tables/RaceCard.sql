-- // columns marked with ## are not available via the betfair api //

CREATE TABLE [dbo].[RaceCard] (
	[ID]				BIGINT   IDENTITY (1, 1) NOT NULL,
	[RaceDate]			DATETIME2 (0) NOT NULL,		-- marketCatalogue > marketStartTime 
	[countryID]			BIGINT		NOT NULL,		-- Event details > countryCode
	[courseID]			BIGINT		NOT NULL,		-- Event details > venue
	[distanceID]		BIGINT		NOT NULL,		-- marketCatalogue > marketName 
													-- returns “2m4f Hcap Hrd Chs” 
													-- parse X’m ‘X’f (number of miles and furlongs) from the string
	[raceTypeID]		BIGINT		NOT NULL,		-- marketCatalogue > marketName	
													-- returns “2m4f Hcap Hrd Chs” 
													-- "Hcap Hrd Chs" is the race type	
	[goingID]			BIGINT        NOT NULL,		-- ##
	[Stall]				INT			  NULL,			-- marketCatalogue > metadata > STALL_DRAW
	[clothNumber]		INT			  NOT NULL,		-- marketCatalogue > metadata > CLOTH_NUMBER			
	[horseID]			BIGINT		  NOT NULL,		-- SEE dbo.horse
	[officialRating]	INT			  NULL,			-- marketCatalogue > metadata > OFFICIAL_RATING
	[Age]				INT           NOT NULL,		-- marketCatalogue > metadata > AGE
	[horseWeightPounds] INT		      NOT NULL,		-- marketCatalogue > metadata > WEIGHT_VALUE
	[lastRun]			INT		      NULL,			-- marketCatalogue > metadata > DAYS_SINCE_LAST_RUN
	[jockeyID]			BIGINT		  NOT NULL,		-- marketCatalogue > metadata > JOCKEY_NAME 
	[jockeyClaimPounds] INT			  NULL,			-- marketCatalogue > metadata > JOCKEY_CLAIM
	[trainerID]			BIGINT        NOT NULL,		-- marketCatalogue > metadata > TRAINER_NAME
	[headGearID]		BIGINT        NULL,			-- marketCatalogue > metadata > WEARING
	[Price09am]			REAL          NULL,			-- marketBook > EX_BEST_OFFERS 										
	[Price10am]			REAL          NULL,			-- // Scheduled price request tasks from listMarketBook 
	[Price11am]			REAL          NULL,			-- // If request returns 'NaN' value, leave NULL
	[Price60Min]		REAL          NULL,
	[Price30Min]		REAL          NULL,            
	[Price15Min]		REAL          NULL,
	[Price05Min]		REAL          NULL,
	[Price04Min]		REAL          NULL,
	[Price03Min]		REAL          NULL,
	[Price02Min]		REAL          NULL,
	[Price01Min]		REAL          NULL,			
	[BFSP]				REAL          NULL,			-- marketBook > actualSP
	[BFSPfav]			INT			  NULL,			-- [insert function] rank horses by BFSP for each race - SQL: RANK() OVER (PARTITION BY RaceDate ORDER BY BFSP)
	[sortPriority]		INT           NOT NULL,		-- marketBook > sortPriority
	[Place]				INT           NOT NULL,		-- ##
	[backReturn]		AS IIF(Place = 1, (BFSP - 1.0), -1.0),       
	[backCommission]	AS IIF(Place = 1, (BFSP - 1.0) * .02, 0.00),     
	[netBackReturn]		AS IIF(Place = 1, (BFSP - 1.0) - ((BFSP - 1.0) * .02), -1.0),
	[layLiability]		AS 1.0 * (BFSP-1.0),				                         
	[layReturn]			AS IIF(Place = 1, (1.0 * (BFSP-1.0) * -1.0), 1.0),
	[layCommission]		AS IIF(Place = 1, 0.00, 0.20),
	[netLayReturn]		AS IIF(Place = 1, (1.0 * (BFSP-1.0) * -1.0), 0.98),			  
	[Runners]			INT           NOT NULL,			-- marketBook > numberOfRunners  
	[Status]			VARCHAR (5)   NOT NULL,			-- marketBook > RunnerStatus // schedule 5 seconds before marketStartTime ACTIVE, REMOVED. If ACTIVE insert 'A', if REMOVED insert 'NR'
	[activeRunners]		INT			  NULL,				-- [window function] - count total runners with ACTIVE ('A') status in each race
	[outcomeID]			BIGINT		  NOT NULL,			-- marketBook > RunnerStatus // schedule 30 mins after marketStartTime WINNER, LOSER
	[PreMin]			REAL          NOT NULL,
	[PreMax]			REAL          NOT NULL,
	[IPMin]				REAL          NOT NULL,
	[IPMax]				REAL          NOT NULL,
	[PPvol]				FLOAT (50)    NOT NULL,
	[IPvol]				FLOAT (50)    NOT NULL,
	[MarketId]			BIGINT		  NOT NULL,			-- marketCatalogue > marketId
	[EventId]			BIGINT        NOT NULL,			-- Event details > id

	CONSTRAINT [PK_RaceCard_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
	CONSTRAINT [FK_RaceCard_country] FOREIGN KEY ([countryID]) REFERENCES [dbo].[country] ([ID]),
	CONSTRAINT [FK_RaceCard_course] FOREIGN KEY ([courseID]) REFERENCES [dbo].[course] ([ID]),
	CONSTRAINT [FK_RaceCard_distance] FOREIGN KEY ([distanceID]) REFERENCES [dbo].[distance] ([ID]),
	CONSTRAINT [FK_RaceCard_going] FOREIGN KEY ([goingID]) REFERENCES [dbo].[going] ([ID]),
	CONSTRAINT [FK_RaceCard_headgear] FOREIGN KEY ([headGearID]) REFERENCES [dbo].[headgear] ([ID]),
	CONSTRAINT [FK_RaceCard_horse] FOREIGN KEY ([horseID]) REFERENCES [dbo].[horse] ([ID]),
	CONSTRAINT [FK_RaceCard_jockey] FOREIGN KEY ([jockeyID]) REFERENCES [dbo].[jockey] ([ID]),
	CONSTRAINT [FK_RaceCard_trainer] FOREIGN KEY ([trainerID]) REFERENCES [dbo].[trainer] ([ID]),
	CONSTRAINT [FK_RaceCard_raceType] FOREIGN KEY ([raceTypeID]) REFERENCES [dbo].[raceType] ([ID]),
	CONSTRAINT [FK_RaceCard_outcome] FOREIGN KEY ([outcomeID]) REFERENCES [dbo].[outcome] ([ID])
);

-- Joining main tables
-- EventId and horseID are unique references across
-- dbo.RaceCard, dbo.PlacePrice, dbo.OtherPlace, dbo.Records 