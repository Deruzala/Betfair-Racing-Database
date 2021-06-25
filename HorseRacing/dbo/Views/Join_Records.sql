-- =============================================
-- Description: 
-- adds schedule info to Records table
-- =============================================
CREATE VIEW [dbo].[Join_Records]
AS 

SELECT 

    rc.RaceDate, 
    s.Name AS systemName,
    c.Name AS course,
    h.SelectionID,
    h.Name AS horse,
    b.Name AS bid,
    r.stake,
    r.price,
    o.Name AS outcome,
    r.pnl


FROM 
RaceCard rc INNER JOIN Records r
ON rc.EventId = r.EventId AND rc.HorseID = r.HorseID

LEFT JOIN system s ON s.ID = r.systemID
LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID
LEFT JOIN bid b ON b.ID = r.bidID
LEFT JOIN outcome o ON o.ID = r.outcomeID