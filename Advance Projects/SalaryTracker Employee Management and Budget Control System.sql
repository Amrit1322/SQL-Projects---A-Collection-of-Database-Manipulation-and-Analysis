--NAME - AMRITPAL SINGH
--PROG1198
--TEST 2

/*1. Create a View which will display all Employee fields and records. Include in the result set the
   department name, as well as a summary field named empFormalName which formats the
   employee's name like "Last, First". Ensure this view has an appropriate name.*/

   CREATE VIEW vw_EmpoloyeeRecord
   AS
    SELECT empID, empFirst, empLast, empTitle, empSalary, empStart, D.deptCode, deptName , CONCAT(empLast,',',empFirst) AS empFormalName
	FROM DEPARTMENT AS D INNER JOIN EMPLOYEE AS E
	     ON D.deptCode = E.deptCode

     GO
  
     /* 2 Write a scalar function named fn_SalariesPaid that receives a department code parameter as input
     and returns the total of all salaries paid to employees in that department. If the total salaries paid is
     NULL, your function should return a zero.*/

	  CREATE FUNCTION fn_SalariesPaid
	  (@deptcode CHAR (4))
	  RETURNS DECIMAL (10,2)
	  AS

	  BEGIN
	       DECLARE @out DECIMAL (10,2)

		   SELECT @out = ISNULL(SUM (empSalary),0)
		   FROM EMPLOYEE
		   WHERE deptCode = @deptCode

		   RETURN @out

	  END
	  GO


	  /*3. Create appropriate trigger(s) on the Employee table to make sure that when either a new Employee
       is added or an existing Employee is updated, their new/changed salary would not cause the
       department to go over budget. If the department will go over budget, then the transaction should
       not be allowed to complete. The trigger(s) should display a feedback message to the user if the
        action is rolled back. Your trigger(s) should make use of your fn_SalariesPaid function.*/

		CREATE TRIGGER tr_InsertSalary
		ON EMPLOYEE
		AFTER INSERT
		AS
		    DECLARE @Salary DECIMAL (10,2)

			SELECT @Salary =  dbo.fn_SalariesPaid(deptCode) FROM EMPLOYEE

		    IF (@Salary > (SELECT deptBudget FROM DEPARTMENT))
			  
		    BEGIN
			    
				PRINT 'TRANSACTION NOT COMPLETED'

				ROLLBACK TRANSACTION

			END

			ELSE 
			  PRINT 'TRANSACTION COMPLETED'
	  
	  GO


	  /*4. Write and execute an INSERT statement to insert a new employee. The new Employee should have
       Your name, should be assigned to the Personnel department, and should have a salary greater than
        $80,000. You can choose your own values for the other fields.
       This employee’s salary would cause the Personnel department to go over budget, so this insert
        should cause your trigger to display the error message and reject the insert.*/

		INSERT INTO EMPLOYEE (empFirst, empLast, empTitle, empSalary, empStart, deptCode)
		VALUES ('Amritpal','Singh','Programmer',80000,'2000/12/7','PERS')

		