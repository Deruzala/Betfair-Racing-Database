-- replicates dbo.PlacePrice

CREATE TABLE [dbo].[OtherPlace] (
	[ID]           BIGINT        IDENTITY (1, 1) NOT NULL,
	[RaceDate]     DATETIME2 (0) NOT NULL,
	[horseID]      BIGINT        NOT NULL,
	[OPPrice05Min] REAL          NOT NULL,
	[OPPrice04Min] REAL          NOT NULL,
	[OPPrice03Min] REAL          NOT NULL,
	[OPPrice02Min] REAL          NOT NULL,
	[OPPrice01Min] REAL          NOT NULL,
	[OPBFSP]       REAL          NOT NULL,              -- marketBook > actualSP 
	[OPlaces]      INT           NOT NULL,              -- marketBook > numberOfWinners
	[OPoutcomeID]  BIGINT        NOT NULL,              -- marketBook > RunnerStatus, WINNER, 1, LOSER, 0		  
	[OPMarketId]   BIGINT        NOT NULL,              -- strip the '1.' prefix from marketId before insertion
	[EventId]      BIGINT        NOT NULL,         
	[OPRaceCardId] BIGINT        NOT NULL,              -- check reference to dbo.RaceCard
	CONSTRAINT [PK_OtherPlace_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
	CONSTRAINT [FK_OtherPlace_Racecard] FOREIGN KEY ([OPRaceCardId]) REFERENCES [dbo].[RaceCard] ([ID]),
	CONSTRAINT [ix_OtherPlace] UNIQUE NONCLUSTERED ([RaceDate] ASC, [horseID] ASC),
	CONSTRAINT [FK_OtherPlace_outcome] FOREIGN KEY ([OPoutcomeID]) REFERENCES [dbo].[outcome] ([ID])
);

-- Joining main tables
-- RaceDate, EventId and horseID are unique references across
-- dbo.RaceCard, dbo.PlacePrice, dbo.OtherPlace, dbo.Records