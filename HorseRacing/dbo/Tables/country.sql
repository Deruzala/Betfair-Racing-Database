CREATE TABLE [dbo].[country] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_country_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_country_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

