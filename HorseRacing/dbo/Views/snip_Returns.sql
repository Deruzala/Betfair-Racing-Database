-- =============================================
-- Description: 
-- back and lay returns
-- liability and commission
-- =============================================
CREATE VIEW [dbo].[snip_Returns]
AS 
SELECT 

    rc.RaceDate, 
    c.Name AS course,
    h.Name AS horse,
	rc.outcomeID,
	
	IIF(outcomeID = 1, (BFSP - 1.0), -1.0) AS backReturn,       
	IIF(outcomeID = 1, (BFSP - 1.0) * .02, 0.00) AS backCommission,     
	IIF(outcomeID = 1, (BFSP - 1.0) - ((BFSP - 1.0) * .02), -1.0) AS netBackReturn,
	1.0 * (BFSP-1.0)AS layLiability,				                         
	IIF(outcomeID = 1, (1.0 * (BFSP-1.0) * -1.0), 1.0) AS layReturn,
	IIF(outcomeID = 1, 0.00, 0.20) AS layCommission,
	IIF(outcomeID = 1, (1.0 * (BFSP-1.0) * -1.0), 0.98) AS netLayReturn	

FROM RaceCard rc
LEFT JOIN course c ON c.ID = rc.courseID 
LEFT JOIN horse h ON h.ID = rc.horseID
