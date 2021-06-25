-- =============================================
-- Description: 
-- aggregates bet profit, loss and performance
-- =============================================
CREATE VIEW [dbo].[Accounts]
AS 

SELECT

    COUNT(DISTINCT betId) AS 't.bets',
    COUNT(CASE WHEN outcomeID = 1 THEN 1 END) AS won,
    COUNT(CASE WHEN outcomeID = 0 THEN 1 END) AS lost,

    FORMAT(100.0 * (SELECT COUNT(*) FROM Records WHERE outcomeID = 1 AND RaceDate <= RaceDate) / 
    (SELECT COUNT(*) FROM Records WHERE RaceDate <= RaceDate), '0.00') as 'win%',

    FORMAT(AVG(stake), '0.00') AS 'avg.stake',
    FORMAT(AVG(price), '0.00') AS 'avg.odds',
    FORMAT(SUM(pnl),'0.00') AS pnl,

    FORMAT(100.0 * (SUM(pnl)) /
    COUNT(DISTINCT betId), '0.00') AS 'yield%',

    FORMAT(100.0 * (SUM(pnl)) /
    200, '0.00') AS 'roi%'

FROM Records
GO

