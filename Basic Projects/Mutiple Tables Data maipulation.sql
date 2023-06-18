--drop the tables if they already exist
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WINNER]') AND type in (N'U'))
	DROP TABLE [dbo].[WINNER]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AWARD]') AND type in (N'U'))
	DROP TABLE [dbo].[AWARD]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ATHLETE]') AND type in (N'U'))
	DROP TABLE [dbo].[ATHLETE]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TEAM]') AND type in (N'U'))
	DROP TABLE [dbo].[TEAM]
GO

/* TEAM TABLE CREATE AND INSERT STATEMENTS */

CREATE TABLE TEAM 
(
	teamID				INT IDENTITY(1,1),
	teamName			VARCHAR(50) NOT NULL,
	teamCity			VARCHAR(20) NOT NULL,
	teamState			CHAR(2),
	teamCountry			VARCHAR(6),
	teamManager			VARCHAR(50),
	teamLeague			CHAR(2) NOT NULL,
	teamStadium			VARCHAR(30)

	CONSTRAINT pk_TEAM_teamID PRIMARY KEY(teamID)
)

INSERT INTO TEAM
	(teamName, teamCity, teamState, teamCountry, teamManager, teamLeague, teamStadium)
VALUES
	('Pittsburgh Pirates', 'Pittsburgh', 'PA', 'USA', 'Derek Shelton', 'NL', 'PNC Park'), 
	('Los Angeles Angels', 'Anaheim', 'CA', 'USA', 'Joe Maddon', 'AL', 'Angel Stadium of Anaheim'),
	('Colorado Rockies', 'Denver', 'CO', 'USA', 'Bud Black', 'NL', 'Coors Field'),
	('New York Mets', 'Queens', 'NY', 'USA', 'Luis Rojas', 'NL', 'Citi Field'),
	('Seattle Mariners', 'Seattle', 'WA', 'USA', 'Scott Servais', 'AL', 'T-Mobile Park'), 
	('Toronto Blue Jays', 'Toronto', 'ON', 'Canada', 'Charlie Montoyo', 'AL', 'Rogers Centre'),
	('Boston Red Sox', 'Boston', 'MA', 'USA', 'Alex Cora', 'AL', 'Fenway Park'),
	('New York Yankees', 'New York', 'NY', 'USA', 'Aaron Boone', 'AL', 'Yankee Stadium'),
	('Cleveland Indians', 'Cleveland', 'OH', 'USA', 'Terry Francona', 'AL', 'Progressive Field'),
	('Chicago White Sox', 'Chicago', 'IL', 'USA', 'Tony La Russa', 'AL', 'Guaranteed Rate Field'),
	('Minnesota Twins', 'Minneapolis', 'MN', 'USA', 'Rocco Baldelli', 'AL', 'Target Field'), 
	('Cincinnati Reds', 'Cincinnati', 'OH', 'USA', 'David Bell', 'NL', 'Great American Ball Park'), 
	('Tampa Bay Rays', 'Tampa Bay', 'FL', 'USA', 'Kevin Cash', 'AL', 'Tropicana Field'),
	('St. Louis Cardinals', 'St. Louis', 'MO', 'USA', 'Mike Shildt', 'NL', 'Busch Stadium')

/* ATHLETE TABLE CREATE AND INSERT STATEMENTS */

CREATE TABLE ATHLETE 
(
  athleteID				INT IDENTITY(1,1),
  athleteFirstName 		VARCHAR(20) NOT NULL,
  athleteLastName 		VARCHAR(30) NOT NULL,
  athleteDateofBirth 	DATE,
  athleteHeight			SMALLINT,
  athleteWeight			TINYINT,
  athletePosition 		CHAR(2) NOT NULL,
  athleteBattingAvg 	DECIMAL(4,3) DEFAULT 0.000,
  athleteNationality	VARCHAR(30), 
  teamID				INT
  
  CONSTRAINT pk_ATHLETE_athleteID PRIMARY KEY(athleteID), 
  CONSTRAINT fk_TEAM_ATHLETE FOREIGN KEY(teamID) REFERENCES TEAM(teamID)
) 


INSERT INTO ATHLETE
	(athleteFirstName, athleteLastName, athleteDateofBirth, athleteHeight, athleteWeight, athletePosition, athleteBattingAvg, athleteNationality, teamID) 
VALUES
	('Bo', 'Bichette',				'1998-03-05', 183, 83,	'SS', 0.294, 'USA', 6),
	('Kevin', 'Kiermaier',			'1990-04-22', 185, 95,  'CF', 0.247, 'USA', 13),
	('Nolan', 'Arenado', 			'1991-04-16', 188, 97,  '3B', 0.255, 'USA', 14),
	('Vladimir', 'Guererro Jr.',	'1999-03-16', 188, 113, '1B', 0.321, 'Canada', 6),
	('Mike', 'Trout', 				'1991-08-07', 188, 106, 'CF', 0.333, 'USA', 2),
	('Jose', 'Abreu', 				'1987-01-29', 190, 115, '1B', 0.263, 'Cuba', 10),
	('Tyler', 'O''Neill',			'1995-06-22', 180, 90,	'LF', 0.282, 'Canada', 14),
	('Aaron', 'Judge', 				'1992-04-26', 201, 127, 'RF', 0.284, 'USA', 8),
	('Joey', 'Votto', 				'1983-09-10', 188, 99,  '1B', 0.267, 'Canada', 12),
	('Kevin', 'Pillar', 			'1989-01-04', 183, 95,  'CF', 0.223, 'USA', 4),
	('Abraham', 'Toro',				'1996-12-20', 183, 93,	'IF', 0.247, 'Canada', 5),
	('Cavan', 'Biggio',				'1995-04-11', 188, 90,  'IF', 0.215, 'USA', 6),
	('Travis', 'Shaw',				'1990-04-16', 193, 104, 'IF', 0.202, 'USA', 7),
	('Josh', 'Donaldson', 			'1985-12-08', 185, 95,  '3B', 0.245, 'USA', 11),
	('Danny', 'Jansen',				'1995-04-15', 188, 104, 'C',  0.209, 'USA', 6),
	('Randal', 'Grichuk',			'1991-08-13', 188, 96,  'OF', 0.247, 'USA', 6),
	('Teoscar', 'Hernandez',		'1992-10-15', 188, 92,	'OF', 0.303, 'Dominican Republic', 6),
	('Tim', 'Anderson',				'1993-06-23', 185, 83,	'SS', 0.301, 'USA', 10), 
	('Marcus', 'Semien',			'1990-09-17', 183, 88,  'IF', 0.270, 'USA', 6), 
	('Josh', 'Naylor',				'1997-06-22', 180, 113, 'OF', 0.253, 'Canada', 9)
	

/* AWARD TABLE CREATE AND INSERT STATEMENTS */


CREATE TABLE AWARD 
(
	awardID			INT IDENTITY(1,1),
	awardName		VARCHAR(30) NOT NULL,
	awardSponsor	VARCHAR(100)
	
	CONSTRAINT pk_AWARD_awardID PRIMARY KEY(awardID)
)

INSERT INTO AWARD
	(awardName, awardSponsor)
VALUES 
	('Most Valuable Player', 'Baseball Writers Association of America'),
	('Gold Glove', 'Rawlings'),
	('Silver Slugger', 'Hillerich & Bradsby'),
	('Rookie of the Year', 'Baseball Writers Association of America')
	



-----------------------------------------------------------


-----------------------------------------------------------
CREATE TABLE WINNER
(

      winID                     INT IDENTITY(1,1),            
      winYear                   INT                         NOT NULL,
      athleteID                 INT                         NOT NULL,
      awardID                   INT                         NOT NULL

	CONSTRAINT pk_WINNER_winID PRIMARY KEY(winID),
	CONSTRAINT fk_WINNER_ATHLETE FOREIGN KEY (athleteID) REFERENCES ATHLETE(athleteID),
	CONSTRAINT fk_WINNER_AWARD FOREIGN KEY (awardID) REFERENCES AWARD(awardID)

)

INSERT INTO WINNER
	(winYear, athleteID, awardID)
VALUES 
	(2017,8,4),
	(2017,8,3),
	(2020,7,2),
	(2013,3,2),
	(2014,3,2),
	(2015,3,2),
	(2016,3,2),
	(2017,3,2),
	(2018,3,2),
	(2019,3,2),
	(2020,3,2),
	(2015,3,3),
	(2016,3,3),
	(2017,3,3),
	(2018,3,3),
	(2010,9,1),
	(2011,9,2),
	(2012,5,4),
	(2014,6,4),
	(2014,6,3),
	(2018,6,3),
	(2020,6,3),
	(2014,5,1),
	(2016,5,1),
	(2019,5,1),
	(2015,2,2),
	(2016,2,2),
	(2019,2,2),
	(2015,14,1),
	(2015,14,3),
	(2016,14,3)

	
	--a. Show a list of awards including winners’ names and the year in which they won. Order the output by year from newest to oldest, and then by award name.
	SELECT winYear,awardName,CONCAT(athleteFirstName,athleteLastName) AS [athleteName]
			FROM ATHLETE INNER JOIN WINNER
			  ON ATHLETE.athleteID = WINNER.athleteID
			    INNER JOIN AWARD
			  ON WINNER.awardID = AWARD.awardID
			ORDER BY winYear  DESC

	--b. How many years have passed since Jose Abreu won Rookie of the Year?

		 SELECT  winYear AS [numberOfYears]
		 FROM AWARD INNER JOIN WINNER 
	     ON AWARD.awardId=WINNER.awardId INNER JOIN ATHLETE
		 ON ATHLETE.athleteId=WINNER.athleteId 
		 WHERE athleteFirstName = 'Jose' AND  awardName='Rookie of the Year'
		 GROUP BY winYear
									
							
	      

	--c. For each athlete, show how many awards he has won. Include athletes who have not won any awards, and ensure their total displays as zero (0). Show each athlete’s first and last name concatenated with their position, as shown in the sample output. Order the output by number of awards won, from most to least, and then by athlete’s last name.

	SELECT CONCAT(athleteLastName,', ',athleteFirstName,' (',athletePosition,')') AS [athleteInfo], ISNULL(COUNT(WINNER.athleteID),0) AS [awardCount]
			FROM ATHLETE LEFT JOIN WINNER ON ATHLETE.athleteID = WINNER.athleteID
			             LEFT JOIN AWARD  ON  AWARD.awardID = WINNER.awardID
		    GROUP BY athleteLastName,athleteFirstName,athletePosition
			ORDER BY COUNT(WINNER.athleteID) DESC, athleteLastName

	--d. How many times has a Canadian athlete won a Gold Glove award?

	
		SELECT awardName, COUNT(athleteNationality) AS [CanadianWinners]
		    FROM ATHLETE INNER JOIN WINNER ON ATHLETE.athleteID = WINNER.athleteID
			             INNER JOIN AWARD  ON AWARD.awardID = WINNER.awardID
		    WHERE athleteNationality = 'Canada' AND awardName = 'Gold Glove'
			GROUP BY awardName

	--e. Which teams have won 3 or more awards among all its listed athletes? Show the team’s name, city, and manager, along with its total number of awards won.

	     SELECT teamName,teamCity,teamManager,COUNT(*) AS [awardsWon]
			FROM TEAM INNER JOIN ATHLETE  ON TEAM.teamID = ATHLETE.teamID
			          INNER JOIN WINNER   ON WINNER.athleteID = ATHLETE.athleteID
			          INNER JOIN AWARD    ON AWARD.awardID = WINNER.awardID
            GROUP BY teamName,teamCity,teamManager
			HAVING COUNT(*)  >= 3
	