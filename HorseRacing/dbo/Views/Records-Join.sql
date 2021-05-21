CREATE VIEW [dbo].[Records-Join]
AS 

SELECT 

    rc.RaceDate, 
    c.Name AS course,
    h.Name AS horse,
    s.Name AS system,
    b.Name AS bid,
    r.pnl

FROM RaceCard rc 
JOIN Records r
ON rc.ID=r.ID

LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID
LEFT JOIN system s ON s.ID = r.systemID
LEFT JOIN bid b ON b.ID = r.bidID