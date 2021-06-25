-- // excel download files https://www.racing-bet-data.com/ // --

-- // column lable (d) from daily download file
-- // schedule daily insert: 10.00am //

-- // column lable (r) from results download file
-- // schedule daily insert: 10.10am //

-- // RaceDate, horse.Name key references // --

CREATE TABLE [dbo].[RaceCard] (
	[ID]		BIGINT   IDENTITY (1, 1) NOT NULL,
	[RaceDate]	DATETIME2 (0) NOT NULL,		
	-- marketCatalogue > marketStartTime 
	[countryID]	BIGINT	 NOT NULL,		
	-- Event details > countryCode
	[courseID]	BIGINT	 NOT NULL,		
	-- Event details > venue

	-- // marketName

	[distanceID]	BIGINT	 NOT NULL,		
	-- // marketCatalogue > marketName 
	[raceTypeID]	BIGINT	 NOT NULL,		
	-- // marketCatalogue > marketName	

	-- // marketName returns both distamce and RaceType
	-- // eg; “2m4f Hcap Hrd Chs” 
	-- // parse X’m ‘X’f = distance.Name
	-- // "Hcap Hrd Chs" = raceType.Name	

	[Class]		INT		NULL,
	-- (d) Class
	[goingID]	BIGINT	NULL,		
	-- (d) Going
	[Stall]		INT	  NULL,			
	-- marketCatalogue > metadata > STALL_DRAW
	[clothNumber]	INT	  NOT NULL,		
	-- marketCatalogue > metadata > CLOTH_NUMBER			
	[horseID]	BIGINT	  NOT NULL,		
	-- see dbo.horse
	[officialRating]INT	  NULL,			
	-- marketCatalogue > metadata > OFFICIAL_RATING
	[carriedWeight] VARCHAR NULL,		
	-- (d) Weight
	[carriedWeightKGs] REAL NULL,		
	-- #CalculatedInsert
	[carriedWeightLbs] REAL NULL,		
	-- #CalculatedInsert
	[horseWeightLbs]	INT	  NOT NULL,	
	-- marketCatalogue > metadata > WEIGHT_VALUE
	[horseWeightKGs] REAL NULL,		
	-- #CalculatedInsert
	[Age]		INT       NOT NULL,		
	-- marketCatalogue > metadata > AGE
	[Pace]		INT		NULL,
	-- (d) Pace
	[lastRun]	INT	  NULL,			
	-- marketCatalogue > metadata > DAYS_SINCE_LAST_RUN
	[jockeyID]	BIGINT	  NOT NULL,		
	-- marketCatalogue > metadata > JOCKEY_NAME 
	[jockeyClaimLbs] INT NULL,		
	-- marketCatalogue > metadata > JOCKEY_CLAIM
	[jockeyClaimKGs] INT NULL,		
	-- #CalculatedInsert
	[trainerID]	BIGINT    NOT NULL,		
	-- marketCatalogue > metadata > TRAINER_NAME
	[headGearID]	BIGINT    NULL,			
	-- marketCatalogue > metadata > WEARING
	[Runners]	INT		NOT NULL,			
	-- marketBook > numberOfRunners  
	[Status]	VARCHAR (5)   NOT NULL,		
	-- // marketBook > RunnerStatus 	
	-- // schedule RunnerStatus request 30 seconds after marketStartTime
	-- // if ACTIVE 'A', REMOVED, 'NR'

	[activeRunners]	INT	NULL,				
	-- // [window function] - count total runners with 'A' Status

	-- // schedule price request tasks
	-- // listMarketBook > EX_BEST_OFFERS 		
	-- // if 'NaN', NULL
	
	[Price09am]  REAL     NULL,											
	[Price10am]  REAL     NULL,			 
	[Price11am]  REAL     NULL,			
	[Price60Min] REAL     NULL,
	[Price30Min] REAL     NULL,            
	[Price15Min] REAL     NULL,
	[Price05Min] REAL     NULL,
	[Price04Min] REAL     NULL,
	[Price03Min] REAL     NULL,
	[Price02Min] REAL     NULL,
	[Price01Min] REAL     NULL,	

	-- //
	
	[BFSP]	REAL	NULL,	
	-- marketBook > actualSP

	[BFSPfav] INT	NULL,	
	--// [function] BFSP rank
	--// SQL: RANK() OVER (PARTITION BY RaceDate ORDER BY BFSP)

	[sortPriority]	INT      NOT NULL,		
	-- marketBook > sortPriority
	[ISP]	REAL	NULL,
	--(r) IndustrySP
	[ISPfav]	REAL	NULL,
	--(r) IndustrySPfav
	[outcomeID]	BIGINT	NOT NULL,			
	-- // marketBook > RunnerStatus 
	-- // schedule 30 mins after marketStartTime WINNER, 1, LOSER, 0
	[Place]		INT		NULL,
	-- (r) Place
	[UnPlaced]	VARCHAR(5)	NULL,
	-- (r) Place / if place return value other than INT
	[WinningDistanceL]	VARCHAR(5)	NULL,
	-- (r) Wining Distance
	[WinningDistanceM]	VARCHAR(5)	NULL,
	-- #CalculatedInsert

	-- // (r)

	[PreMax]	REAL       NULL,
	[PreMin]	REAL       NULL,			
	[IPMax]		REAL       NULL,
	[IPMin]		REAL       NULL,
	
	-- //

	[MarketId]			BIGINT		  NOT NULL,			
	-- marketCatalogue > marketId 
	--// (strip the '1.' prefix from marketId before insertion)

	[EventId]			BIGINT        NOT NULL,			
	-- Event details > id

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
