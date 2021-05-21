CREATE TABLE [dbo].[marketType]
(
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_marketType_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_marketType_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);