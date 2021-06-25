--// schedule market discovery job 1 hour prior 
--   to marketStartTime of corresponding win market
--   EventID as unique identifier

CREATE TABLE [dbo].[PlacePrice] (
	[ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
	[RaceDate]    DATETIME2 (0) NOT NULL,
	[horseID]     BIGINT        NOT NULL,
	[PPrice05Min] REAL          NOT NULL,
	[PPrice04Min] REAL          NOT NULL,
	[PPrice03Min] REAL          NOT NULL,
	[PPrice02Min] REAL          NOT NULL,
	[PPrice01Min] REAL          NOT NULL,
	[PBFSP]       REAL          NOT NULL,               -- marketBook > actualSP
	[Places]      INT           NOT NULL,               -- marketBook > numberOfWinners
	[PoutcomeID]  BIGINT        NOT NULL,               -- marketBook > Runnerstatus, WINNER, 1, LOSER, 0
	[PMarketId]   BIGINT        NOT NULL,               -- strip the '1.' prefix from marketId before insertion
	[EventId]     BIGINT        NOT NULL,
	[PRaceCardId] BIGINT        NOT NULL,               -- check reference to dbo.RaceCard
	CONSTRAINT [PK_PlacePrice_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
	CONSTRAINT [FK_PlacePrice_RaceCard] FOREIGN KEY ([PRaceCardId]) REFERENCES [dbo].[RaceCard] ([ID]),
	CONSTRAINT [ix_PlacePrice] UNIQUE NONCLUSTERED ([RaceDate] ASC, [horseID] ASC),
	CONSTRAINT [FK_PlacePrice_outcome] FOREIGN KEY ([PoutcomeID]) REFERENCES [dbo].[outcome] ([ID])
);

-- Joining main tables
-- EventId and horseID are unique references across
-- dbo.RaceCard, dbo.PlacePrice, dbo.OtherPlace, dbo.Records

