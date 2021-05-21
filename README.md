# Betfair Racing Database

An SQL Server Horse Racing database project for the Betfair Exchange

The Betfair Racing Database is designed to store racing data from the `win`, `place` and `other_place` markets from the Betfair API

The database stores schedule and race informmation by Normal Form Rules to save space and strengthen data integrity with a Records table to store betting records for analysis.  Common functions such as distance conversion and In-Play price movements are included



Outline of the [Database Design](https://github.com/Deruzala/Betfair-Racing-Database/wiki/Database-Design)

***
# Installation

For installation of SQL Server and SQL Server Management Studio see

[Install Microsoft SQL Server 2019](https://www.microsoft.com/en-gb/sql-server/sql-server-downloads)

[Install SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?redirectedfrom=MSDN&view=sql-server-ver15)

***

# Setup and api integration

Clone the repository and build the solution

Popular Betfair api wrappers are linked in the [Wiki](https://github.com/Deruzala/Betfair-Racing-Database/wiki)

Comments on data elements, columns task scheduling and api endpoints in [dbo.RaceCard](https://github.com/Deruzala/Betfair-Racing-Database/blob/main/HorseRacing/dbo/Tables/RaceCard.sql)




