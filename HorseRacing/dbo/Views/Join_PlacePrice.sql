-- =============================================
-- Description: 
-- adds schedule info to PlacePrice
-- back and lay PlacePrice returns
-- =============================================
CREATE VIEW [dbo].[Join_PlacePrice]
AS 

SELECT

    rc.RaceDate,
    c.Name AS course,
    h.Name AS horse,
    p.PPrice05Min,
	p.PBFSP,
	p.PoutcomeID,
	IIF(p.PoutcomeID = 1, (p.PBFSP - 1.0), -1.0) AS backReturn,
	IIF(p.PoutcomeID = 1, (1.0 * (p.PBFSP-1.0) * -1.0), 1.0) AS layReturn

FROM 
RaceCard rc INNER JOIN PlacePrice p 
ON rc.EventId = p.EventId AND rc.HorseID = p.HorseID

LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID
GO


