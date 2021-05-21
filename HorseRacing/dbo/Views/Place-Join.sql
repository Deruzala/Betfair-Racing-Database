CREATE VIEW [dbo].[Place-Join]
AS 

SELECT 

    rc.RaceDate, 
    c.Name AS course,
    h.Name AS horse,
    p.PPrice05Min

FROM RaceCard rc 
JOIN PlacePrice p
ON rc.ID=p.ID

LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID


