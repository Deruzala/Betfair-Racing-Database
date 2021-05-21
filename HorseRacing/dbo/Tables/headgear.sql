CREATE TABLE [dbo].[headgear] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_headgear_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_headgear_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

