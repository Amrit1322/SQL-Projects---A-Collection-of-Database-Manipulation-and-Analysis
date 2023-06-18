-- NAME-AMRITPAL SINGH
-- DATE-16-2-2022
-- TEST 1

--1. Add a named constraint to the Pet table to ensure that the only valid entries in the Species column are "Cat" or "Dog".
  ALTER TABLE PET 
		ADD CONSTRAINT petSpecies  CHECK (petSpecies = 'Cat' OR petSpecies = 'Dog')

--2. Add a named default of "Unknown" to the Pet Breed column.

   ALTER TABLE PET
		ADD CONSTRAINT df_petbred
		DEFAULT 'Unknown' FOR petBreed;

--3. Display a list of Persons and their Pets exactly as shown in the sample output below. Ensure you usethe column aliases and that you have the formatting correct for the names, phone numbers, pet
--types and DOB values.
    
	SELECT pr.personID,CONCAT(pr.personFirstName,pr.personLastName) AS [personName],pr.personPhone,pt.petID,pt.petName,CONCAT(pt.petSpecies,'>',pt.petBreed) AS [petType], FORMAT(pt.petDOB,'dd MMM yyyy') AS [petBirthDate]
		FROM PET pt
		  INNER JOIN OWNERS ow ON pt.petID = ow.petID
		  INNER JOIN PERSON pr ON ow.personID = pr.personID


--4. The formula for determining the petID value is: First letter of Species, first letter of Breed, then last
--wo digits of birth year. Notice however, that in our table, "Spot" has an incorrect petID value - it
--should be 'DD19'. At this point, we can not modify the petID value because it is a key in another table.
--We wish to allow updates to be made to the petID primary key in the Pet table, and have those
--updates cascade to the foreign key in the Owners table as well.
--To do this, perform the following changes in a transaction using the Xact Abort method:

--a. Remove the existing foreign key constraint on the petID field (it is named fk_PET_OWNERS)
 
--b. Add a new foreign key constraint on the petID field, using the same constraint name, but
--including the option to cascade changes to the foreign key values.
--When completed, perform an UPDATE statement on the Pet table to change Spot's petID to 'DD19'.
--Include this UPDATE statement in your script.

  --both  a and b together

  SET XACT_ABORT ON
		 BEGIN TRANSACTION updating

		 	ALTER TABLE OWNERS   
			DROP CONSTRAINT fk_PET_OWNERS   
			GO 

			ALTER TABLE OWNERS 
			ADD CONSTRAINT fk_PET_OWNERS 
			FOREIGN KEY (petID)
			REFERENCES PET (petID)
			ON UPDATE CASCADE

			UPDATE PET
			SET petID = 'DD19'
			WHERE petName = 'Spot'

			PRINT 'SUCESSFUL'

		COMMIT TRANSACTION updating


--5. Create a transaction which performs the following actions together as one unit of work. Include
--try/catch logic to display a success message if the entire transaction succeeds, or display an error
--message and roll back the transaction if any errors occur.

  BEGIN TRY
	     BEGIN TRANSACTION Query

--a. Insert a new Person with your name and a phone number.

  INSERT INTO PERSON(personFirstName,personLastName,personPhone)
			VALUES ('Amritpal','Singh',4372313224)

--b. Use a variable to retrieve and store the new Person's personID value.

               DECLARE @ID INT 

--c. Insert a new Pet record, you can make up any values you like for the Pet data.

  INSERT INTO PET(petID,petName,petDOB,petSpecies,petBreed)
			 VALUES ('DK20','Kallu', '2020-01-17','Dog','Pitbull')

			

--d. Create the relationship between these new Person and Pet records, in the Owners table.
--Use your variable from (b) in your Insert query.

 SELECT @ID  = personID
			FROM OWNERS
			WHERE petId = 'DK20'

			SELECT @ID  AS newPersonID

		 COMMIT TRANSACTION Query
	   END TRY

	   BEGIN CATCH 
	       PRINT 'TRANSACTION FAILED'
		   ROLLBACK TRANSACTION Query
	   END CATCH



--6. Add a computed column to the Pet table called petAdjustedAge. This column will calculate each
--pet's relative age in either "Cat Years" or "Dog Years", based on the Species value. This data should
--not persist in the table. Calculate "Cat Years" as 5 times the age in years, and "Dog Years" as 7 times
--the age. Use the value of petSpecies to determine which multiplier to use. 

 ALTER TABLE dbo.PET 
 ADD petAdjustedAges  AS(DATEDIFF (yyyy, petDOB ,GETDATE()) * 5 )

 SELECT petID, petName,petSpecies, (DATEDIFF (yyyy, petDOB ,GETDATE())) AS petAgeInYears, petAdjustedAges
 FROM PET

