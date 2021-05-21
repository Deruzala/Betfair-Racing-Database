--// schedule information available by joining dbo.RaceCard
--// EventID as unique identifier

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
	[PoutcomeID]  BIGINT        NOT NULL,               -- marketBook > Runnerstatus, WINNER, LOSER
	[PbackReturn]		AS IIF(PoutcomeID = 1, (PBFSP - 1.0), -1.0),       
	[PbackCommission]	AS IIF(PoutcomeID = 1, (PBFSP - 1.0) * .02, 0.00), 
	[PnetBackReturn]	AS IIF(PoutcomeID = 1, (PBFSP - 1.0) - ((PBFSP - 1.0) * .02), -1.0),
	[PlayLiability]		AS 1.0 * (PBFSP-1.0),				                         
	[PlayReturn]		AS IIF(PoutcomeID = 2, (1.0 * (PBFSP-1.0) * -1), 1.0),
	[PlayCommission]    AS IIF(PoutcomeID = 1, 0.00, 0.20),
	[PnetLayReturn]		AS IIF(PoutcomeID = 2, (1.0 * (PBFSP-1.0) * -1), 0.98),	
	[PMarketId]   BIGINT        NOT NULL,
	[OPEventId]     BIGINT        NOT NULL,
	CONSTRAINT [PK_PlacePrice_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
	CONSTRAINT [FK_PlacePrice_RaceCard] FOREIGN KEY ([ID]) REFERENCES [dbo].[RaceCard] ([ID]),
	CONSTRAINT [ix_PlacePrice] UNIQUE NONCLUSTERED ([RaceDate] ASC, [horseID] ASC),
	CONSTRAINT [FK_PlacePrice_outcome] FOREIGN KEY ([PoutcomeID]) REFERENCES [dbo].[outcome] ([ID])
);
-- Joining main tables
-- EventId and horseID are unique references across
-- dbo.RaceCard, dbo.PlacePrice, dbo.OtherPlace, dbo.Records

