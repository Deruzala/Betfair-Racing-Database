CREATE TABLE [dbo].[horse] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (200) NOT NULL,       -- marketCatalogue > runnerName 
    [SelectionID] BIGINT        NULL,           -- marketCatalogue > selectionId 
    CONSTRAINT [PK_horse_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_horse_Name] UNIQUE NONCLUSTERED ([Name] ASC),
    CONSTRAINT [ix_horse_SelectionID] UNIQUE NONCLUSTERED ([SelectionID] ASC)
);
