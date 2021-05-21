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
	[OPoutcomeID]  BIGINT        NOT NULL,              -- marketBook > RunnerStatus, WINNER, LOSER
	[OPbackReturn]		AS IIF(OPoutcomeID = 1, (OPBFSP - 1.0), -1.0),       
	[OPbackCommission]	AS IIF(OPoutcomeID = 1, (OPBFSP - 1.0) * .02, 0.00), 
	[OPnetBackReturn]	AS IIF(OPoutcomeID = 1, (OPBFSP - 1.0) - ((OPBFSP - 1.0) * .02), -1.0),
	[OPlayLiability]	AS 1.0 * (OPBFSP-1.0),				                         
	[OPlayReturn]		AS IIF(OPoutcomeID = 2, (1.0 * (OPBFSP-1.0) * -1), 1.0),
	[OPlayCommission]	AS IIF(OPoutcomeID = 1, 0.00, 0.20),
	[OPnetLayReturn]	AS IIF(OPoutcomeID = 2, (1.0 * (OPBFSP-1.0) * -1), 0.98),				  
	[OPMarketId]	BIGINT        NOT NULL,
	[OPEventId]		BIGINT        NOT NULL,         
	CONSTRAINT [PK_OtherPlace_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
	CONSTRAINT [FK_OtherPlace_Racecard] FOREIGN KEY ([ID]) REFERENCES [dbo].[RaceCard] ([ID]),
	CONSTRAINT [ix_OtherPlace] UNIQUE NONCLUSTERED ([RaceDate] ASC, [horseID] ASC),
	CONSTRAINT [FK_OtherPlace_outcome] FOREIGN KEY ([OPoutcomeID]) REFERENCES [dbo].[outcome] ([ID])
);

-- Joining main tables
-- RaceDate, EventId and horseID are unique references across
-- dbo.RaceCard, dbo.PlacePrice, dbo.OtherPlace, dbo.Records