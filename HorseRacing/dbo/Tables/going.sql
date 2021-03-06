CREATE TABLE [dbo].[going] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_going_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_going_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

