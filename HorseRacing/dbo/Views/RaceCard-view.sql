CREATE VIEW [dbo].[RaceCard-view]
AS
SELECT 

    rc.RaceDate, 
    c.Name AS course,
    h.Name AS horse,
    FORMAT(dbo.fn_GetAvgTickDrop(rc.horseID, rc.RaceDate),'0.00') AS AvgTickDrop

FROM RaceCard rc 
LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID