IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POKE_FIGHT]') AND type in (N'U'))
	DROP TABLE [dbo].[POKE_FIGHT]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BATTLE]') AND type in (N'U'))
	DROP TABLE [dbo].[BATTLE]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POKEMON]') AND type in (N'U'))
	DROP TABLE [dbo].[POKEMON]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TRAINER]') AND type in (N'U'))
DROP TABLE [dbo].[TRAINER]
GO

CREATE TABLE TRAINER
(
	trainerID	INT IDENTITY(1,1),
	trainerName VARCHAR(30)
	
	CONSTRAINT pk_TRAINER_trainerID PRIMARY KEY(trainerID)
)
--ADD YOUR DATA INTEGRITY CONSTRAINTS IN THIS CREATE STATEMENT
CREATE TABLE POKEMON
(
	pokeID		INT IDENTITY(1,1),
	pokeDexNum	VARCHAR(5)          NOT NULL,
	pokeName	VARCHAR(50),
	pokeHeight	INT               CHECK (pokeHeight > 0),
	pokeWeight	DECIMAL(6,2)      CHECK (pokeWeight >= 0),
	pokeColour	VARCHAR(20),
	pokeType	VARCHAR(15),
	trainerID	INT					NOT NULL,
	evolvesFrom INT

	CONSTRAINT pk_POKEMON_pokeID PRIMARY KEY(pokeID),
	CONSTRAINT fk_POKEMON_TRAINER FOREIGN KEY(trainerID) REFERENCES TRAINER(trainerID),
	CONSTRAINT fk_POKEMON_evolvesFrom FOREIGN KEY(evolvesFrom) REFERENCES POKEMON(pokeID)
)

CREATE TABLE BATTLE
(
	battleID		INT IDENTITY(1,1),
	battleName		VARCHAR(30)		NOT NULL,
	battleLocation	VARCHAR(30),
	battleExpPoints	INT
	
	CONSTRAINT pk_BATTLE_battleID PRIMARY KEY(battleID)
)

CREATE TABLE POKE_FIGHT
(
	pfID		INT IDENTITY(1,1),
	pokeID		INT 				NOT NULL,
	battleID	INT 				NOT NULL
	
	CONSTRAINT pk_PF_pfID PRIMARY KEY(pfID),
	CONSTRAINT fk_PF_POKEMON FOREIGN KEY(pokeID) REFERENCES POKEMON(pokeID),
	CONSTRAINT fk_PF_BATTLE FOREIGN KEY(battleID) REFERENCES BATTLE(battleID)
)

INSERT INTO TRAINER 
	(trainerName) 
VALUES 
	('Ash'),
	('Brock'),
	('Misty'),
	('Erika'),
	('Alain')

INSERT INTO POKEMON
	(pokeDexNum, pokeName, pokeHeight, pokeWeight, pokeColour, pokeType, trainerID)
VALUES
	('025',	'Pikachu', 41, 6.5, 'Yellow', 'Electric', 1),
	('722', 'Rowlet', 30, 1.5, 'Brown', 'Grass', 1),
	('745', 'Lycanroc', 79, 25.0, 'Gray', 'Rock', 1),				--lycanroc evolves from rockruff
	('744', 'Rockruff', 51, 9.2, 'Brown', 'Rock', 1),
	('726', 'Torracat', 71, 25.0, 'Red', 'Fire', 1),
	('470', 'Leafeon', 99, 25.5, 'Green', 'Grass', 1),				--leafeon evolves from eevee
	('074', 'Geodude', 41, 20.0, 'Gray', 'Rock', 2),
	('095', 'Onix', 879, 210.0, 'Gray', 'Rock', 2),
	('111', 'Rhyhorn', 99, 115.0, 'Gray', 'Ground', 2),
	('044', 'Gloom', 79, 8.6, 'Brown', 'Grass', 2),
	('182', 'Bellossom', 41, 5.8, 'Green', 'Grass', 2),				--bellossom evolves from gloom
	('196', 'Espeon', 89, 26.5, 'Purple', 'Psychic', 2),			--espeon evolves from eevee
	('197', 'Umbreon', 99, 27.0, 'Black', 'Dark', 2),				--umbreon evolves from eevee
	('133', 'Eevee', 30, 6.5, 'Brown', 'Normal', 3),
	('135',	'Jolteon', 84, 24.5, 'Yellow', 'Electric', 3),			--jolteon evolves from eevee
	('136', 'Flareon', 84, 25, 'Orange', 'Fire', 3), 				--flareon evolves from eevee
	('120', 'Staryu', 79, 34.5, 'Brown', 'Water', 3),
	('121', 'Starmie', 109, 80.0, 'Silver', 'Water', 3),			--starmie evolves from staryu
	('134', 'Vaporeon', 99, 29.0, 'Blue', 'Water', 3),				--vaporeon evolves from eevee
	('114', 'Tangela', 99, 35.0, 'Blue', 'Grass', 4),
	('045', 'Vileplume', 119, 18.6, 'Pink', 'Grass', 4),			--vileplume evolves from gloom
	('189', 'Jumpluff', 79, 3.0, 'Purple', 'Grass', 4),
	('005', 'Charmeleon', 109, 19, 'Red', 'Fire', 5),
	('006', 'Charizard', 170, 90.5, 'Orange', 'Fire', 5),			--charizard evolves from charmeleon
	('376', 'Metagross', 160, 550.0, 'Gray', 'Steel', 5),
	('248', 'Tyranitar', 201, 202.0, 'Green', 'Rock', 5),
	('461', 'Weavile', 109, 34.0, 'Purple', 'Dark', 5)

INSERT INTO BATTLE
	(battleName, battleLocation, battleExpPoints)
VALUES
	('Team Battle', 'Summer Camp', 40),
	('Full Battle', 'Mt. Silver', 90),
	('Rotation Battle', 'Driftveil City', 75),
	('Sky Battle', 'Azure Bay', 65),
	('Battle Royal', 'Battle Royal Dome', 100),
	('Double Battle', 'Pokemon Colosseum', 55)

INSERT INTO POKE_FIGHT
	(pokeID, battleID)
VALUES 
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 4),
	(3, 1),
	(3, 5),
	(5, 5),
	(5, 2),
	(5, 6),
	(7, 1),
	(7, 5),
	(8, 3),
	(8, 1),
	(8, 6),
	(9, 6),
	(9, 1),
	(17, 3),
	(18, 6),
	(18, 1),
	(20, 2),
	(20, 3),
	(20, 1),
	(21, 1),
	(22, 4),
	(22, 6),
	(22, 5),
	(24, 2),
	(24, 5),
	(24, 1),
	(24, 4),
	(25, 1),
	(25, 5),
	(25, 6),
	(26, 2),
	(26, 5),
	(27, 2),
	(27, 1)

--WRITE YOUR UPDATE STATEMENTS BELOW...

  UPDATE POKEMON
  SET evolvesFrom = 23
  WHERE pokeID = 24

  UPDATE POKEMON
  SET evolvesFrom = 10
  WHERE pokeID IN (21,11)

  UPDATE POKEMON
  SET evolvesFrom = 17
  WHERE pokeID = 18

  UPDATE POKEMON
  SET evolvesFrom = 4
  WHERE pokeID = 3

  UPDATE POKEMON
  SET evolvesFrom = 14
  WHERE pokeID IN (15,16,19,12,6,13)



--SELECT QUERIES...	
	
--a.	Output each Pokémon, its type, and the total amount of battle experience points it has earned. 
--		Order the output by total points, from most to least, and then by Pokemon name. 
--		Include Pokémon who haven’t battled in your output – display 0 as their points earned.
        
		SELECT pokeName ,ISNULL(SUM (battleExpPoints), 0) AS [Total Points]
		FROM POKEMON P LEFT JOIN POKE_FIGHT F ON P.pokeID = F.pokeID
		             LEFT JOIN BATTLE  ON F.battleID = BATTLE.battleID
        GROUP BY P.pokeName
	    ORDER BY SUM (BATTLE.battleExpPoints) DESC , P.pokeName


--b.	For each original Pokémon, show all the Pokémon that evolve from it.  
--		Order by original name, and then by evolved name.  
--		Pokémon who do not evolve should not be in the output.
         
		SELECT B.pokeName AS Base,P.pokeName AS Evolved
        FROM POKEMON P INNER JOIN POKEMON B ON P.EvolvesFrom = B.pokeID
	    ORDER BY B.pokeName,P.pokeName

--c.	How many Pokémon does each trainer own, who have battled at the Summer Camp location?  
--		Display the trainer's name, along with their number of Pokémon who have battled at Summer Camp. 
--		Order the output by trainer’s name.
   
           SELECT trainerName,COUNT(battleLocation) AS [Number of Summer Camp Pokemon]
		   FROM POKEMON P INNER JOIN TRAINER T  ON   P.trainerID = T.trainerID
		                INNER JOIN POKE_FIGHT F ON  F.pokeID = P.pokeID
		                INNER JOIN BATTLE  ON  BATTLE.battleID = F.battleID	  
		  GROUP BY T.trainerName , BATTLE.battleLocation
		  HAVING BATTLE.battleLocation = 'Summer Camp' 
		  ORDER BY trainerName


--d.	Which Pokémon evolve into another Pokémon with the same Type?
--		Concatenate the Pokémon names and colours in the output as shown, and display their Type also.
        
		 SELECT CONCAT(B.pokeName,' (',B.pokeColour,')' ) AS [Base],CONCAT (P.pokeName,' (',P.pokeColour,')' ) AS [Evolved],B.pokeType AS [Type]
         FROM POKEMON P INNER JOIN POKEMON B ON P.EvolvesFrom = B.pokeID
	     WHERE B.pokeType = P.pokeType
	     ORDER BY P.pokeName,B.pokeName


--e.	Which evolved Pokémon weighs the least?  What is its weight, and from which Pokémon does it evolve?

        SELECT P.pokeName AS [Lightest Evolved Pokemon], P.pokeWeight AS [Weight] ,B.pokeName AS [Evolves From]
	    FROM POKEMON P INNER JOIN POKEMON B ON P.EvolvesFrom = B.pokeID
		WHERE P.pokeWeight = (SELECT MIN(P.pokeWeight) FROM POKEMON P INNER JOIN POKEMON B ON P.EvolvesFrom = B.pokeID )
		ORDER BY P.pokeWeight



	