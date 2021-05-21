﻿CREATE TABLE [dbo].[raceType] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL
    CONSTRAINT [PK_raceType_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_raceType_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);
