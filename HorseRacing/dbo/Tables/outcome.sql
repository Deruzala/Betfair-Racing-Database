CREATE TABLE [dbo].[outcome] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_outcome_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_outcome_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

