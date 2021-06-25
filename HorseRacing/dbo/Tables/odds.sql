CREATE TABLE [dbo].[odds](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Price] [real] NOT NULL,
	[Tick] [int] NOT NULL,
	[impliedProbability] [real] NOT NULL, 
 CONSTRAINT [PK_odds_ID] PRIMARY KEY CLUSTERED ([ID] ASC))