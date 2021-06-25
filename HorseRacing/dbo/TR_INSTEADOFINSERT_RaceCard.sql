CREATE TRIGGER [TR_INSTEADOFINSERT_RaceCard]
ON [dbo].[RaceCard]
INSTEAD OF INSERT
AS
BEGIN
	SET NOCOUNT ON

		-- create a temporary table to hold calculated values
		 select * into #correctedInserts
		 from inserted

		 -- if carriedWeightKGs is not provided, we calculate it (only if carriedWeight is provided)
		 UPDATE #correctedInserts
			 SET carriedWeightKGs = dbo.fn_ConvertStringStonesAndPoundsToKGs(carriedWeight)
		 WHERE (carriedWeightKGs is null) and (carriedWeight IS NOT NULL)  

		  -- if carriedWeightLbs is not provided, we calculate it (only if carriedWeight is provided)
		 UPDATE #correctedInserts
			 SET carriedWeightLbs = dbo.fn_ConvertStringStonesAndPoundsToLbs(carriedWeight)
		 WHERE (carriedWeightLbs is null) and (carriedWeight IS NOT NULL)  

		 -- if horseWeightKGs is not provided, we calculate it (only if horseWeightLbs is provided)
		 UPDATE #correctedInserts
			 SET horseWeightKGs = dbo.fn_ConvertLbsToKGs(horseWeightLbs)
		 WHERE (horseWeightKGs is null) and (horseWeightLbs IS NOT NULL)  
		
		-- if jockeyClaimKGs is not provided, we calculate it (only if jockeyClaimLbs is provided)
		 UPDATE #correctedInserts
			 SET jockeyClaimKGs = dbo.fn_ConvertLbsToKGs(jockeyClaimLbs)
		 WHERE (jockeyClaimKGs is null) and (jockeyClaimLbs IS NOT NULL)  

		 --//

		 -- if WinningDistanceM is not provided in the insertion, we calculate the value
		 UPDATE #correctedInserts
			SET WinningDistanceM = 
				case
					WHEN WinningDistanceL is null then iif(outcomeID = 1, 0,null)
					ELSE
						dbo.fn_ConvertStringWinningDistanceToMeters(WinningDistanceH)
				end
		 WHERE (WinningDistanceM is null)
		 
		 -- request the insertion 
		 INSERT INTO dbo.RaceCard    (RaceDate, countryID, courseID, distanceID, raceTypeID, Class, goingID, Stall,
									 clothNumber, horseID, officialRating, Age,Pace, horseWeightLbs, horseWeightKGs,
									 carriedWeight, carriedWeightKGs, carriedWeightLbs, lastRun, jockeyID,
									 jockeyClaimLbs, jockeyClaimKGs, trainerID, headGearID, Runners, Status, activeRunners,
									 Price09am, Price10am, Price11am, Price60Min, Price30Min, Price15Min, 
									 Price05Min, Price04Min, Price03Min, Price02Min, Price01Min, BFSP, 
									 BFSPfav, sortPriority, ISP, ISPfav, outcomeID, Place, UnPlaced, 
									 WinningDistanceL, WinningDistanceM, PreMax, PreMin, IPMax, IPMin, 
									 MarketId, EventId)

			SELECT  RaceDate, countryID, courseID, distanceID, raceTypeID, Class, goingID, Stall,
					clothNumber, horseID, officialRating, Age, Pace, horseWeightLbs, horseWeightKGs,
					carriedWeight, carriedWeightKGs, carriedWeightLbs, lastRun, jockeyID,jockeyClaimLbs, 
					jockeyClaimKGs, trainerID, headGearID, Runners, Status, activeRunners,
					Price09am, Price10am, Price11am, Price60Min, Price30Min, Price15Min, Price05Min, 
					Price04Min, Price03Min, Price02Min, Price01Min, BFSP, 
					BFSPfav, sortPriority, ISP, ISPfav, outcomeID,Place, UnPlaced, 
					WinningDistanceL, WinningDistanceM, PreMax, PreMin, IPMax, IPMin,
					MarketId, EventId

			FROM #correctedInserts

      END
