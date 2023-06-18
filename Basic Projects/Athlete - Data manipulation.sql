--LAB 2
--Name:AMRITPAL SINGH
--Date:10-2-2021

--2.a)	Show all of the details about Canadian athletes.
	SELECT *
	FROM ATHLETE
	WHERE athleteNationality = 'CANADA'


--2.b)	How many athletes having Batting Averages between .300 and .310 do we have in the table?
    SELECT COUNT (athleteBattingAvg) AS numHighBA  
	FROM ATHLETE
	WHERE athleteBattingAvg BETWEEN .300 AND .310

--2.c)	Display the names and positions of athletes whose first names end with the letter "n".  
    SELECT athleteFirstName, athleteLastName,athletePosition
	FROM ATHLETE
	WHERE athleteFirstName LIKE '%n'

--2.d)	Which athletes are younger than 27 years old? Display the athletes' ages in years.
    SELECT athleteFirstName ,athleteLastName, DATEDIFF(YEAR,athleteDateofBirth, GETDATE()) AS athleteAGE 
	FROM ATHLETE
	WHERE DATEDIFF(YEAR, athleteDateofBirth, GETDATE()) <=27

--2.e)	Output the Position, Name, and Batting Average of the athlete who has the lowest Batting Average.
	 SELECT athletePosition, CONCAT(athleteFirstName,' ',athleteLastName) AS athleteName,athleteBattingAvg
	 FROM ATHLETE
	 WHERE athleteBattingAvg = (SELECT MIN(athleteBattingAvg) FROM ATHLETE)    

--2.f)	Show each athlete’s Last Name formatted with their Weight and Height, as shown.
--		For example, "Abreu: 115kg, 190cm". Order the athletes from shortest to tallest.

	SELECT CONCAT(athleteLastName,': ', athleteWeight,'kg', athleteHeight,'cm') AS athleteStats
	FROM ATHLETE
	ORDER BY athleteHeight ASC

--2.g)	Show the lowest, highest, and average Batting Average among Infielders 
--		(this category includes Infield, First Base, Second Base, and Third Base positions). 
--		Bonus mark if you can figure out how to round the average to 3 decimal places.
	 SELECT MIN (athleteBattingAvg) AS 'Lowest', MAX(athleteBattingAvg) AS 'Highest', AVG(athleteBattingAvg) AS 'Average'
	 FROM ATHLETE
	 WHERE athletePosition IN ('IF', '1B', '2B', '3B')
--3.	Code INSERT statement(s) to add 3 new player records to the ATHLETE table. 
--		You can look up some player information online (baseball-reference.com has lots of player info) or you can make some up. 
      INSERT INTO ATHLETE
	      (athleteFirstName, athleteLastName, athleteDateofBirth, athleteHeight, athleteWeight, athletePosition, athleteBattingAvg, athleteNationality) 
      VALUES
          ('Tom','Carroll',  '1936-09-17', 190, 84,'SS', 0.300, 'USA')


      INSERT INTO ATHLETE
	      (athleteFirstName, athleteLastName, athleteDateofBirth, athleteHeight, athleteWeight, athletePosition, athleteBattingAvg, athleteNationality)
      VALUES
          ('Trent', 'Giambrone', '1993-12-20', 173, 79, '2B',0.167, 'USA')

      INSERT INTO ATHLETE
	      (athleteFirstName, athleteLastName, athleteDateofBirth, athleteHeight, athleteWeight, athletePosition, athleteBattingAvg, athleteNationality)
      VALUES
          ('Oswaldo', 'Navarro', '1984-10-09', 183, 90,'SS',0.130, 'VENEZUELA')
	
--4.	Code an UPDATE query as follows: change the first and last name of one of the players to your own name. 
       UPDATE ATHLETE
	   SET athleteFirstName = 'Amritpal' ,athleteLastName = 'Singh'
	   WHERE athleteID = 3


--5.	Code a DELETE query to remove a player of your choice from the ATHLETE table.  
--		Leave a comment in the script, indicating why you chose that particular person to remove.

      
	     DELETE FROM ATHLETE

	     WHERE athleteID= 13

		-- I removed him becuase he had a low batting average and personally i dont like him.