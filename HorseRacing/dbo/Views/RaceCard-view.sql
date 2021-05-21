CREATE VIEW [dbo].[RaceCard-view]
AS
SELECT 

    rc.RaceDate, 
    c.Name AS course,
    distance.Name AS Distance,
    distance.Meters As DistanceM,
    distance.Furlongs AS DistanceF,
    h.Name AS horse,
    FORMAT(dbo.fn_GetAvgTickDrop(rc.horseID, rc.RaceDate),'0.00') AS AvgTickDrop

FROM RaceCard rc 
LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN distance ON distance.ID = rc.DistanceID
LEFT JOIN horse h ON h.ID = rc.horseID
