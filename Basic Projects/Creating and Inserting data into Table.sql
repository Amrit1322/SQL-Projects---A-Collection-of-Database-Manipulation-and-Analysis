--drop the tables if they already exist
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ATHLETE]') AND type in (N'U'))
	DROP TABLE [dbo].[ATHLETE]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TEAM]') AND type in (N'U'))
DROP TABLE [dbo].[TEAM]
GO

/* **************************************************************************** */
/* Before you begin, execute the TEAM CREATE and INSERT statements.				*/
/* You will need the team table to exist before you can modify and execute		*/
/* the ATHLETE CREATE and INSERTS.												*/
/*																				*/
/* Do not execute the ATHLETE statements until your modifications are complete!	*/
/* **************************************************************************** */


CREATE TABLE TEAM (
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

CREATE TABLE ATHLETE (
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
  CONSTRAINT fk_TEAM_ATHLETE FOREIGN KEY (teamID) REFERENCES TEAM (teamID)

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

/* SELECT queries... */


--3.	For each team, display the team name, stadium, 
--		city and state (together), and how many athletes the team has. 
--		Order the results by team name.
      SELECT  TEAM.teamName,teamStadium, CONCAT (teamCity, ',' , teamState) AS teamLocation , COUNT (teamName) AS numberOfAthletes
      FROM TEAM INNER JOIN ATHLETE
	  ON TEAM.teamID = ATHLETE.teamID
	  GROUP BY  TEAM.teamName,teamStadium,teamCity,teamState
	  ORDER by teamName ASC

--4.	Which teams have an average athlete age under 30? 
--		Display the team league, name, and average athlete age.
     
	SELECT teamLeague,teamName, AVG(DATEDIFF(YEAR,athleteDateOfBirth,GETDATE())) AS [avgAge]
		FROM TEAM INNER JOIN ATHLETE
	       ON TEAM.teamID = ATHLETE.teamID 
        GROUP BY teamName,teamLeague
		HAVING AVG(DATEDIFF(YEAR,athleteDateOfBirth,GETDATE())) < 30
		ORDER BY teamName
	


--5.	Which team has the oldest athlete, and what is that 
--		athlete’s name and age?
        SELECT teamName,CONCAT("athleteFirstName","athleteLastName") AS athleteName,DATEDIFF(YEAR,athleteDateOfBirth,GETDATE()) AS athleteAge 
		FROM TEAM INNER JOIN ATHLETE
	       ON TEAM.teamID = ATHLETE.teamID 
		 WHERE athleteDateofBirth = (SELECT MIN(athleteDateofBirth) FROM ATHLETE)
		GROUP BY teamName,athleteFirstName,athleteLastName,athleteDateofBirth
		 

--6.	Which teams have only one outfielder (includes positions OF, RF, LF and CF) on their roster?
      SELECT teamName 
		FROM TEAM FULL OUTER JOIN ATHLETE
		 ON TEAM.teamID = ATHLETE.teamID
		WHERE athletePosition IN ('OF','RF','LF','CF')
        GROUP BY teamName, athletePosition
		HAVING COUNT (athletePosition) < 2
		ORDER BY teamName

--7.  	How many athletes play at each position?  Order the results by position.
        SELECT athletePosition , COUNT (athletePosition) AS numberOfAthletes
	    FROM TEAM RIGHT JOIN ATHLETE
	    ON TEAM.teamID = ATHLETE.teamID
	    GROUP BY athletePosition

--8.	What is the batting average of all the athletes for each team? 
--		Display each team name, and its team batting average.
--		Ensure all teams are included in the list.  
--		Format the batting average to three decimal places.
--		Order the results by team name.

   SELECT teamName, ISNULL(AVG(athleteBattingAvg),0) AS athleteBattingAvg
		FROM TEAM LEFT JOIN ATHLETE
		 ON TEAM.teamID = ATHLETE.teamID
        GROUP BY teamName
		ORDER BY teamName	       
		                 
       
--9.	Display a list of athletes who were born in a different country 
--		than that which their team is based.  
--		(For example, a Canadian athlete who plays for a team based in USA.)  
--		Put the country names in the output also.
--		Order the results by athlete's nationality, then by last name.
        SELECT athleteFirstName + athleteLastName AS [playerName] , athleteNationality AS [Birth Country], teamCountry
		FROM TEAM INNER JOIN ATHLETE
	       ON TEAM.teamID = ATHLETE.teamID
		   WHERE athleteNationality != teamCountry
		ORDER BY athleteNationality, athleteLastName

--10.	(A+ credit!) Who is the best batter (highest batting average) in each league? 
--		Display the league, athlete’s first and last name, and their batting average.
       
	   
	SELECT teamLeague, athleteFirstName,athleteLastName,athleteBattingAvg
	FROM TEAM FULL OUTER JOIN ATHLETE
	ON TEAM.teamID= ATHLETE.teamID
	WHERE athleteBattingAvg  = (SELECT MAX (athleteBattingAvg) FROM ATHLETE)
	GROUP BY teamLeague, athleteFirstName,athleteLastName, athleteBattingAvg

