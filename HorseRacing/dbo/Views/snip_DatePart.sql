-- =============================================
-- Description: 
-- formats the RaceDate column
-- specifies a date range
-- =============================================
CREATE VIEW [dbo].[snip_DatePart]
AS
SELECT  																							
           rc.RaceDate,
           FORMAT(rc.RaceDate,'dd-MM-yyyy') AS 'Date',
		   DateName(year, rc.RaceDate) as 'Year',
		   DateName(month, rc.RaceDate) as 'Month',
		   DateName(week, rc.RaceDate) as 'Week',
		   DateName(weekday, rc.RaceDate) as 'Day',
		   FORMAT(rc.RaceDate,'HH:mm') AS 'Time',  
		   rc.MarketId, 
		   rc.EventID
		   
		   FROM RaceCard rc
		   WHERE RaceDate BETWEEN CONVERT(DATE,'2018-01-01') AND CONVERT(DATE,'2018-01-02')
GO