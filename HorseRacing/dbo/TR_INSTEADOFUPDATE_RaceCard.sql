CREATE TRIGGER [TR_INSTEADOFUPDATE_RaceCard]
ON [dbo].[RaceCard]
INSTEAD OF UPDATE
AS
BEGIN
	SET NOCOUNT ON
 
		-- create a temporary table to hold calculated values
		 select * into #correctedInserts
		 from inserted

		 -- if carriedWeightKg is not provided, we calculate it (only if carriedWeight is provided)
		if update(carriedWeight)
			UPDATE #correctedInserts
				SET carriedWeightKGs = dbo.fn_ConvertStringStonesAndPoundsToKGs(#correctedInserts.carriedWeight)
			FROM #correctedInserts INNER JOIN Deleted ON #correctedInserts.Id = Deleted.Id
			WHERE (#correctedInserts.carriedWeight IS NOT NULL) and (#correctedInserts.carriedWeight <> Deleted.carriedWeight or Deleted.carriedWeight is null)

		--// 

		-- if carriedWeightLbs is not provided, we calculate it (only if carriedWeight is provided)
		if update(carriedWeight)
			UPDATE #correctedInserts
				SET carriedWeightLbs = dbo.fn_ConvertStringStonesAndPoundsToLbs(#correctedInserts.carriedWeight)
			FROM #correctedInserts INNER JOIN Deleted ON #correctedInserts.Id = Deleted.Id
			WHERE (#correctedInserts.carriedWeight IS NOT NULL) and (#correctedInserts.carriedWeight <> Deleted.carriedWeight or Deleted.carriedWeight is null)


		-- if horseWeightKGs is not provided, we calculate it (only if horseWeightLbs is provided)
		if update(horseWeightLbs)
			UPDATE #correctedInserts
				SET horseWeightKGs = dbo.fn_ConvertLbsToKGs(#correctedInserts.horseWeightLbs)
			FROM #correctedInserts INNER JOIN Deleted ON #correctedInserts.Id = Deleted.Id
			WHERE (#correctedInserts.horseWeightLbs IS NOT NULL) and (#correctedInserts.horseWeightLbs <> Deleted.horseWeightLbs or Deleted.horseWeightLbs is null)

		-- if jockeyClaimKGs is not provided, we calculate it (only if jockeyClaimLbs is provided)
		if update(jockeyClaimLbs)
			UPDATE #correctedInserts
				SET jockeyClaimKGs = dbo.fn_ConvertLbsToKGs(#correctedInserts.jockeyClaimLbs)
			FROM #correctedInserts INNER JOIN Deleted ON #correctedInserts.Id = Deleted.Id
			WHERE (#correctedInserts.jockeyClaimLbs IS NOT NULL) and (#correctedInserts.jockeyClaimLbs <> Deleted.jockeyClaimLbs or Deleted.jockeyClaimLbs is null)


		--// 

		 -- if WinningDistanceM is not provided in the insertion, we calculate the value
		if update(WinningDistanceL)
			UPDATE #correctedInserts
				SET WinningDistanceM = 
					case
						WHEN #correctedInserts.WinningDistanceL is null then iif(#correctedInserts.outcomeID = 1, 0,null)
						ELSE
							dbo.ConvertStringWinningDistanceToMeters(#correctedInserts.WinningDistanceL)
					end
			FROM #correctedInserts INNER JOIN Deleted ON #correctedInserts.Id = Deleted.Id
			WHERE #correctedInserts.WinningDistanceL <> Deleted.WinningDistanceL OR Deleted.WinningDistanceL IS NULL



		 
		 -- request the upate 
		 update dbo.RaceCard SET
			RaceDate=I.RaceDate,
			countryID=I.countryID,
			courseID=I.courseID,
			distanceID=I.distanceID,
			raceTypeID=I.raceTypeID,
			Class=I.Class,
			goingID=I.goingID,
			Stall=I.Stall,
			clothNumber=I.clothNumber,
			horseID=I.horseID,
			officialRating=I.officialRating,
			Age=I.Age,
			Pace=I.Pace,
			horseWeightLbs=I.horseWeightLbs,
			horseWeightKGs=I.horseWeightKGs,
			carriedWeight=I.carriedWeight,
			carriedWeightKGs=I.carriedWeightKGs,
			carriedWeightLbs=I.carriedWeightLbs,
			lastRun=I.lastRun,
			jockeyID=I.jockeyID,
			jockeyClaimLbs=I.jockeClaimLbs,
			jockeyClaimKGs=I.jockeyClaimKGs,
			trainerID=I.trainerID,
			headGearID=I.headGearID,
			Runners=I.Runners,
			Status=I.Status,
			activeRunners=I.activeRunners,
			Price09am=I.Price09am,
			Price10am=I.Price10am,
			Price11am=I.Price11am,
			Price60Min=I.Price60Min,
			Price30Min=I.Price30Min,
			Price15Min=I.Price15Min,
			Price05Min=I.Price05Min,
			Price04Min=I.Price04Min,
			Price03Min=I.Price03Min,
			Price02Min=I.Price02Min,
			Price01Min=I.Price01Min,
			BFSP=I.BFSP,
			BFSPfav=I.BFSPfav,
			sortPriority=I.sortPriority,
			ISP=I.ISP,
			ISPfav=I.ISPfav,
			outcomeID=I.outcomeID,
			Place=I.Place,
			UnPlaced=I.UnPlaced,
			WinningDistanceL=I.WinningDistanceL,
			WinningDistanceM=I.WinningDistanceM,
			PreMax=I.PreMax,
			PreMin=I.PreMin,
			IPMax=I.IPMax,
			IPMin=I.IPMin,
			MarketId=I.MarketId,
			EventId=I.EventId

		from dbo.RaceCard M
			inner join #correctedInserts I on I.Id = M.Id

      END
