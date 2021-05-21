﻿CREATE TABLE [dbo].[bid] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_bid_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_bid_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

