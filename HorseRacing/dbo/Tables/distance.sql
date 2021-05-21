CREATE TABLE [dbo].[distance] (
    [ID]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (200) NOT NULL,
    [Meters]   REAL          CONSTRAINT [DF__distance__Meters] DEFAULT (NULL) NULL, -- Check constraint
    [Furlongs] REAL          CONSTRAINT [DF__distance__Furlongs] DEFAULT (NULL) NULL, -- Check constraint
    CONSTRAINT [PK_distance_ID] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [ix_distance_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
CREATE TRIGGER [dbo].[TR_INSTEADOFINSERT_distance]
   ON [dbo].[distance]
    INSTEAD OF INSERT
   AS 
      BEGIN

         SET  NOCOUNT  ON

		-- do some basic error checking
		 if (SELECT COUNT(*) FROM Inserted WHERE Name='' OR Name IS NULL)>0
			begin
				raiserror('Name cannot be empty or null', 16, 1)
				return
			end
		
		 -- create a temporary table to hold values that do not have meters and furlongs
		 select * into #CalculatedInserts
		 from inserted

		 -- if Meters is not provided in the insertion, we calculate the value
		 UPDATE #CalculatedInserts
			SET Meters = dbo.fn_ConvertDistanceStringToMeters(Name)
		 WHERE Meters IS NULL

		 -- if Furlongs is not provided in the insertion, we calculate the value
		 UPDATE #CalculatedInserts
			SET Furlongs = Meters * 0.00497096
		 WHERE Furlongs IS NULL
		 
		 -- request the insertion 
		 INSERT INTO dbo.distance
			SELECT  Name, Meters, Furlongs FROM #CalculatedInserts

      END

GO
CREATE TRIGGER [dbo].[TR_INSTEADOFUPDATE_distance]
   ON [dbo].[distance]
    INSTEAD OF UPDATE
   AS 
      BEGIN
		
        SET  NOCOUNT  ON

	    -- do some basic error checking
		if (SELECT COUNT(*) FROM Inserted WHERE Name='' OR Name IS NULL)>0
		begin
			raiserror('Name cannot be empty or null', 16, 1)
			return
		end

		-- create a temporary table to hold values, we may modify this table
		-- with calculated meters and furlongs and it'll be the tables inserts come from
		select * into #CalculatedInserts
		from inserted

		--select * from #CalculatedInserts
		--select * from deleted


		if update(Name)
			begin

					-- if Meters is not provided in the insertion, we calculate the value
					UPDATE #CalculatedInserts
						SET #CalculatedInserts.Meters = dbo.fn_ConvertDistanceStringToMeters(#CalculatedInserts.Name)
					FROM #CalculatedInserts INNER JOIN Deleted ON #CalculatedInserts.ID = Deleted.ID
					WHERE #CalculatedInserts.Name <> Deleted.Name

					-- select * from #CalculatedInserts

					-- if Furlongs is not provided in the insertion, we calculate the value
					UPDATE #CalculatedInserts
						SET #CalculatedInserts.Furlongs = #CalculatedInserts.Meters * 0.00497096
					FROM #CalculatedInserts INNER JOIN Deleted ON #CalculatedInserts.ID = Deleted.ID
					WHERE #CalculatedInserts.Name <> Deleted.Name

					-- select * from #CalculatedInserts

			end
		
		-- request the update 
		update dbo.distance SET 
			Name = I.Name,
			Meters = I.Meters,
			Furlongs = I.Furlongs
		from dbo.distance M
			inner join #CalculatedInserts I on I.ID = M.ID

      END

GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'HorseRacing.`distance`', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'distance';

