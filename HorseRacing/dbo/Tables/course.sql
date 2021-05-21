CREATE TABLE [dbo].[course] (
    [ID]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (200) NOT NULL,
    [BFEquivalence] [varchar](200) NULL,
    CONSTRAINT [PK_course_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_course_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

