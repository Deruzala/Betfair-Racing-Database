CREATE TABLE [dbo].[trainer] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_trainer_ID] UNIQUE NONCLUSTERED ([ID] ASC),
    CONSTRAINT [ix_trainer_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

