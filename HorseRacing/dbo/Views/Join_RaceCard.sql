-- =============================================
-- Description: 
-- joins tables that RaceCard depends on
-- calls formatted user defined function
-- =============================================
CREATE VIEW [dbo].[Join_RaceCard]
AS
SELECT 

    rc.RaceDate, 
    c.Name AS course,
    h.Name AS horse,
    FORMAT(dbo.fn_TickDropAvg(rc.horseID, rc.RaceDate),'0.00') AS TickDropAvg

FROM RaceCard rc 
LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID