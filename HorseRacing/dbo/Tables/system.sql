﻿CREATE TABLE [dbo].[system] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_system_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_system_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

