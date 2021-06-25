CREATE TABLE [dbo].[Records] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [systemID]    BIGINT        NOT NULL,  -- betting system being used
    [RaceDate]    DATETIME2 (0) NOT NULL,
    [marketOpen]  DATETIME2 (3) NOT NULL,  -- time market was discovered
    [marketTypeID]BIGINT        NOT NULL,  -- marketType; win, place, other_place
    [selectionID] BIGINT        NOT NULL,
    [horseID]     BIGINT        NOT NULL,
    [bidPlaced]   DATETIME2 (3) NOT NULL,  -- time bid placed
    [betId]       BIGINT        NOT NULL,  -- Betfair generated BetId
    [bidID]       BIGINT        NOT NULL,
    [stake]       REAL          NOT NULL,  -- bet size
    [price]       REAL          NOT NULL,
    [outcomeID]   BIGINT        NOT NULL,  -- listClearedOrders
    [pnl]         REAL          NOT NULL,
    [netpnl]      REAL          NOT NULL,
    [EventId]     BIGINT        NOT NULL,
    [MarketId]    BIGINT        NOT NULL, -- strip the '1.' prefix from marketId before insertion
    [RRaceCardId] BIGINT        NOT NULL, -- check reference to dbo.RaceCard
    CONSTRAINT [PK_Records_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Records_marketType] FOREIGN KEY ([marketTypeID]) REFERENCES [dbo].[marketType] ([ID]),
    CONSTRAINT [FK_Records_selectionID] FOREIGN KEY ([horseID]) REFERENCES [dbo].[horse] ([ID]),
    CONSTRAINT [FK_Records_horse] FOREIGN KEY ([horseID]) REFERENCES [dbo].[horse] ([ID]),
    CONSTRAINT [FK_Records_bid] FOREIGN KEY ([bidID]) REFERENCES [dbo].[bid] ([ID]),
    CONSTRAINT [FK_Records_outcome] FOREIGN KEY ([outcomeID]) REFERENCES [dbo].[outcome] ([ID]),
    CONSTRAINT [FK_Records_Racecard] FOREIGN KEY ([RRaceCardId]) REFERENCES [dbo].[RaceCard] ([ID]),
    CONSTRAINT [FK_Records_system] FOREIGN KEY ([systemID]) REFERENCES [dbo].[system] ([ID]),
    CONSTRAINT [ix_Records] UNIQUE NONCLUSTERED ([systemID] ASC, [MarketId] ASC, [selectionID] ASC)
);

-- check contraints for selectionID and horseID

-- Joining main tables
-- RaceDate, EventId and horseID are unique references across
-- dbo.RaceCard, dbo.PlacePrice, dbo.OtherPlace, dbo.Records